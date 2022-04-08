--[[ MIT License

Copyright (c) 2021 Christophe MICHEL

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local ADDON_NAME, SJ = ...

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME, true)

-- upvalues for frequent API calls
local isQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted

local function isarray(t)
    return type(t) == "table" and #t > 0
end

local DatabaseMixin = { }

function DatabaseMixin:Sort()
    -- For the moment default to natural order on names
    table.sort(self.soulshapes, function(left, right)
        return left.name < right.name
    end)
end

function DatabaseMixin:Update()
    for _, soulshape in ipairs(self.soulshapes) do
        soulshape.collected = soulshape.collected or self:IsCollected(soulshape)
    end
end

function DatabaseMixin:CountTotal()
    return #self.soulshapes
end

function DatabaseMixin:CountCollected()
    local collected = 0
    for _, soulshape in ipairs(self.soulshapes) do
        if soulshape.collected then
            collected = collected + 1
        end
    end
    return collected
end

function DatabaseMixin:AddUntrackable(soulshape)
    if soulshape.untrackable then
        SJ.saved.char.collectedUntrackable[soulshape.untrackable] = true
        return true
    end
    return false
end

function DatabaseMixin:IsCollected(soulshape)
    if soulshape.questID then
        return isQuestCompleted(soulshape.questID)
    else
        return soulshape.untrackable and SJ.saved.char.collectedUntrackable[soulshape.untrackable]
    end
end

local function CostFormatter(cost)
    if not isarray(cost) then
        cost = { cost }
    end
    rendered = {}
    for _, currency in ipairs(cost) do
        if currency.custom then
            -- FIXME Find a better way to handle regular items as currencies?
            tinsert(rendered, (currency.amount and currency.amount or "") .. currency.custom)
        elseif currency.gold then
            tinsert(rendered, GetCoinTextureString(currency.gold * 10000))
        else
            local info = C_CurrencyInfo.GetBasicCurrencyInfo(currency.id, currency.amount)
            tinsert(rendered, info.displayAmount .. "|T" .. info.icon .. ":0|t")
        end
    end
    return table.concat(rendered, " ")
end

local function FactionFormatter(faction)
    local name
    if faction.id then
        name, _ = GetFactionInfoByID(faction.id)
    else
        -- We can't fetch all factions by id because GetFactionInfoByID will return nil
        -- on convenant-specific factions when the player has currently chosen another covenant
        name = faction.name
    end
    if faction.level then
        local genderSuffix = UnitSex("player") == 3 and "_FEMALE" or ""
        local levelString = _G["FACTION_STANDING_LABEL" .. faction.level .. genderSuffix]
        return string.format("%s - %s", name, levelString)
    end
end

local function CampaignQuestFormatter(quest)
    return "|A:quest-campaign-available:12:12|a" .. quest
end

local function Label(name)
    if GetLocale() == "frFR" then
        -- French typography requires a space after colons
        return format("|cffffd100%s :|r ", name)
    else
        return format("|cffffd100%s:|r ", name)
    end
end

local function JoiningFormatter(values)
    if isarray(values) then
        return table.concat(values, ", ")
    end
    return values
end

local function Item(icon, name, rarity)
    return format("|T%d:0|t%s", icon, rarity:WrapTextInColorCode(name))
end

local function CreateSourceString(soulshape)
    local source = {}

    function addMultiLine(value, renderer)
        if value then
            if isarray(value) then
                for _, entry in ipairs(value) do
                    renderer(entry)
                end
            else
                renderer(value)
            end
        end
    end

    function addLine(label, value, transformation)
        if value then
            if transformation then
                value = transformation(value)
            end
            tinsert(source, Label(label) .. value)
        end
    end

    function renderVendor(vendor)
        addLine(L["Vendor"], vendor.name)
        addLine(L["Region"], vendor.region)
        addLine(L["Cost"], vendor.cost, CostFormatter)
    end

    addLine(L["Loot"], soulshape.loot)
    addLine(L["Quest"], soulshape.quest)
    addLine(L["Quest"], soulshape.campaignQuest, CampaignQuestFormatter)
    addLine(L["Campaign"], soulshape.campaign)
    addLine(L["World Event"], soulshape.worldEvent)
    addLine(L["World Quest"], soulshape.worldQuest)
    addLine(L["NPC"], soulshape.npc)
    addLine(L["Profession"], soulshape.profession)
    addLine(L["Region"], soulshape.region)
    addLine(L["Cost"], soulshape.cost, CostFormatter)
    addLine(L["Faction"], soulshape.faction, FactionFormatter)
    addMultiLine(soulshape.vendor, renderVendor)
    addLine(L["Covenant Feature"], soulshape.covenantFeature)
    addLine(L["Difficulty"], soulshape.difficulty, JoiningFormatter)
    addLine(L["Renown"], soulshape.renown)
    addLine(L["Spell"], soulshape.spell)
    return table.concat(source, "\n")
end

local function CreateGuideString(soulshape)
    local guide = soulshape.guide
    if type(guide) == "table" and guide.text and guide.args and isarray(guide.args) then
        return string.format(guide.text, unpack(guide.args))
    else
        return guide
    end
end

--- Concats and transforms to lowercase all searchable text related to a soulshape.
local function CreateSearchText(soulshape)
    local guide = soulshape.guide or ""
    local values = { soulshape.name:lower(), soulshape.source:lower(), guide:lower() }
    return table.concat(values, " ")
end

--- Filters soulshapes from a future build
local function RemoveUpcomingSoulshapes(soulshapes)

    local function GetBuildNumber()
        local _, buildNumber = GetBuildInfo()
        return tonumber(buildNumber)
    end

    local currentSoulshapes = {}
    local currentBuild = GetBuildNumber()
    for _, soulshape in ipairs(soulshapes) do
        if not soulshape.buildNumber or soulshape.buildNumber <= currentBuild then
            table.insert(currentSoulshapes, soulshape)
        end
    end
    return currentSoulshapes
end

local function CreateLocations(soulshape)
    if soulshape.pinData then
        soulshape.pins = {}
        soulshape.maps = {}

        local addedMaps = {}

        for _, pin in ipairs(soulshape.pinData) do
            local mapID = pin[1]

            if not addedMaps[mapID] then
                tinsert(soulshape.maps, { mapID, SJ:GetMapName(mapID) })
                addedMaps[mapID] = true
            end

            tinsert(soulshape.pins, {
                mapID = mapID,
                x = pin[2],
                y = pin[3],
                creatureDisplayID = pin[4],
                iconID = pin[5],
                label = pin[6],
                details = pin[7],
            })
        end
        soulshape.pinData = nil
    end
end

local function ResolveRegion(soulshape)
    if soulshape.zoneID then
        soulshape.region = SJ:GetMapName(soulshape.zoneID)
        soulshape.zoneID = nil
    end
    if soulshape.vendor and soulshape.vendor.zoneID then
        soulshape.vendor.region = SJ:GetMapName(soulshape.vendor.zoneID)
        soulshape.vendor.zoneID = nil
    end
end

local PIN_DATA_OLEA_MANU = { { 1970, 37.0, 44.6, 101851, nil, L["Olea Manu"], L["Olea Manu Tooltip"] } }

local function CreateDatabase()
    local soulshapes = {
        {
            name = L["Alpaca Soul"],
            loot = L["Shadowlands World Bosses"],
            questID = 65010,
            icon = 2061352,
            model = 103074,
            scale = 3.5,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Ardenmoth Soul"],
            campaignQuest = L["Drust and Ashes"],
            campaign = L["Drust and Ashes"],
            renown = 22,
            questID = 62422,
            icon = 3255388,
            model = 96511,
            modelSceneID = 34,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Boar Soul"],
            worldEvent = L["Warlords of Draenor Timewalking"],
            guide = L["Boar Soul Guide"],
            questID = 65025,
            icon = 1044799,
            model = 103082,
            scale = 3,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Bunny Soul"],
            worldQuest = L["Pet Battle"],
            region = L["Shadowlands"],
            guide = L["Bunny Soul Guide"],
            critter = true,
            questID = 64984,
            icon = 2399274,
            model = 102364,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Cat Soul"],
            npc = L["Lost Soul"],
            region = L["Ardenweald"],
            guide = L["Cat Soul Guide"],
            pinData = {
                { 1565, 37.6, 36.2, 103084, nil, L["Lost Soul"], nil },
                { 1565, 51.2, 31, 103084, nil, L["Lost Soul"], nil },
                { 1565, 65, 36.4, 103084, nil, L["Lost Soul"], nil },
                { 1565, 60, 55, 103084, nil, L["Lost Soul"], nil },
                { 1565, 51.8, 69.2, 103084, nil, L["Lost Soul"], nil },
            },
            critter = true,
            questID = 64961,
            icon = 656574,
            model = 103084,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Cat Soul (Well Fed)"],
            npc = L["Ma'oh"],
            region = L["Ardenweald"],
            guide = L["Cat Soul (Well Fed) Guide"],
            pinData = {
                { 1702, 58, 69, 103084, nil, L["Ma'oh"], nil },
                { 1525, 63.7, 61.6, nil, 134058, L["Spectral Feed"], L["Spectral Feed Tooltip"] }
            },
            critter = true,
            questID = 64982,
            icon = 656577,
            model = 100636,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Chicken Soul"],
            npc = L["Lost Soul"],
            region = L["Revendreth"],
            pinData = {
                { 1525, 63.18, 42.76, 102363, nil, L["Lost Soul"], nil },
                { 1525, 63.7, 61.6, nil, 134058, L["Spectral Feed"], L["Spectral Feed Tooltip"] }
            },
            guide = L["Chicken Soul Guide"],
            critter = true,
            questID = 64941,
            icon = 2027864,
            model = 102363,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Cloud Serpent Soul"],
            worldEvent = L["Mists of Pandaria Timewalking"],
            guide = L["Cloud Serpent Soul Guide"],
            questID = 65024,
            icon = 1247267,
            model = 103080,
            scale = 6,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Cobra Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Cobra Soul Guide"],
            questID = 64651,
            icon = 2399271,
            model = 96525,
            scale = 4,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Corgi Soul"],
            npc = L["Sparkle"],
            region = L["Ardenweald"],
            guide = L["Corgi Soul Guide"],
            critter = true,
            questID = 64938,
            icon = 1339013,
            model = 100634,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Crane Soul"],
            faction = { id = 2465, level = 6 },
            vendor = {
                {
                    name = L["Aithlyn"],
                    region = L["Ardenweald"],
                    cost = { id = 1813, amount = 2500 },
                },
                {
                    name = L["Liawyn"],
                    region = L["Oribos"],
                    cost = { id = 1813, amount = 2500 },
                }
            },
            pinData = {
                { 1701, 59.6, 32.6, 99153, nil, L["Aithlyn"], nil },
                { 1670, 47.0, 76.8, 99156, nil, L["Liawyn"], nil }
            },
            questID = 62424,
            icon = 605484,
            model = 96519,
            scale = 4,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Cricket Soul"],
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                cost = {
                    { id = 1813, amount = 15000 },
                    { id = 1885, amount = 25 },
                },
            },
            pinData = {
                { 1565, 59.6, 52.8, 99751, nil, L["Spindlenose"], nil },
            },
            critter = true,
            questID = 64990,
            icon = 646325,
            model = 103069,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Direhorn Soul"],
            loot = L["The Grand Menagerie"],
            region = L["Tazavesh, the Veiled Market"],
            questID = 63607,
            icon = 791593,
            model = 100626,
            scale = 5,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Eagle Soul"],
            vendor = {
                name = L["Master Clerk Salorn"],
                region = L["Ardenweald"],
                cost = { id = 1813, amount = 20000 },
            },
            pinData = {
                { 1565, 43.0, 47.0, 99767, nil, L["Master Clerk Salorn"], nil },
            },
            questID = 65021,
            icon = 132172,
            model = 103076,
            modelSceneID = 34,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Equine Soul"],
            campaignQuest = L["Mending a Broken Hart"],
            campaign = L["Night Warrior's Curse"],
            renown = 11,
            questID = 62428,
            icon = 2153980,
            model = 96517,
            scale = 4.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Frog Soul"],
            profession = PROFESSIONS_FISHING,
            region = L["Shadowlands"],
            guide = L["Frog Soul Guide"],
            critter = true,
            questID = 64994,
            icon = 2399262,
            model = 100638,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Goat Soul"],
            loot = L["Covenant Callings reward chests"],
            region = L["Shadowlands"],
            guide = L["Goat Soul Guide"],
            questID = 65008,
            icon = 877477,
            model = 103072,
            scale = 3,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Gryphon Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Gryphon Soul Guide"],
            questID = 62426,
            icon = 537515,
            model = 96539,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Gulper Soul"],
            loot = L["Queen's Conservatory Cache"],
            covenantFeature = L["Queen's Conservatory"],
            guide = {
                text = L["Gulper Soul Guide"],
                args = { Item(960671, L["Wildseed Root Grain"], EPIC_PURPLE_COLOR) },
            },
            questID = 62421,
            icon = 2481372,
            model = 97394,
            scale = 3,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Hippo Soul"],
            loot = Item(3753378, L["War Chest of the Wild Hunt"], RARE_BLUE_COLOR),
            region = L["The Maw"],
            guide = L["Hippo Soul Guide"],
            questID = 63608,
            icon = 1044490,
            model = 100627,
            scale = 3.4,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Hippogryph Soul"],
            campaignQuest = L["The Power of Elune"],
            campaign = L["The Power of Night"],
            renown = 54,
            questID = 62427,
            icon = 1455896,
            model = 96538,
            scale = 4.5,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Hyena Soul"],
            loot = L["Mythic+ dungeons"],
            guide = L["Hyena Soul Guide"],
            questID = 64650,
            icon = 132190,
            model = 96524,
            scale = 4,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Jormungar Soul"],
            worldEvent = L["Wrath of the Lich King Timewalking"],
            guide = L["Jormungar Soul Guide"],
            questID = 65023,
            icon = 1531518,
            model = 103079,
            scale = 5,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Kodo Soul"],
            worldEvent = L["Cataclysm Timewalking"],
            guide = L["Kodo Soul Guide"],
            questID = 63609,
            icon = 132243,
            model = 100629,
            scale = 5,
            buildNumber = SJ.BUILD_9_0_5,
        },
        {
            name = L["Leonine Soul"],
            faction = { id = 2464, level = 5 },
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                cost = {
                    { id = 1813, amount = 1500 },
                    { id = 1885, amount = 5 },
                },
            },
            pinData = {
                { 1565, 59.6, 52.8, 99751, nil, L["Spindlenose"], nil },
            },
            questID = 62429,
            icon = 464140,
            model = 96520,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Lupine Soul"],
            faction = { id = 2464, level = 5 },
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                cost = {
                    { id = 1813, amount = 1500 },
                    { id = 1885, amount = 5 },
                },
            },
            pinData = {
                { 1565, 59.6, 52.8, 99751, nil, L["Spindlenose"], nil },
            },
            questID = 62438,
            icon = 464162,
            model = 96534,
            scale = 5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Mammoth Soul"],
            loot = Item(3753378, L["Wild Hunt Supplies"], RARE_BLUE_COLOR),
            faction = { id = 2465, level = 8 },
            guide = L["Paragon reward."],
            questID = 63610,
            icon = 236240,
            model = 100630,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Moose Soul"],
            vendor = {
                name = L["Master Clerk Salorn"],
                region = L["Ardenweald"],
                cost = { id = 1813, amount = 1500 },
            },
            guide = L["Moose Soul Guide"],
            pinData = {
                { 1565, 43.0, 47.0, 99767, nil, L["Master Clerk Salorn"], nil },
            },
            questID = 62430,
            icon = 1390637,
            model = 96533,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Otter Soul"],
            npc = L["Lost Soul"],
            region = L["Bastion"],
            guide = L["Otter Soul Guide"],
            pinData = {
                { 1533, 49.8, 46.8, 100637, nil, L["Lost Soul"], nil },
            },
            critter = true,
            questID = 64959,
            icon = 645906,
            model = 100637,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Owl Soul"],
            worldEvent = L["Legion Timewalking"],
            guide = L["Owl Soul Guide"],
            questID = 65026,
            icon = 1387709,
            model = 103083,
            modelSceneID = 34,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Owlcat Soul"],
            loot = L["Lady Sylvanas Windrunner"],
            region = L["Sanctum of Domination"],
            difficulty = L["Heroic"],
            questID = 62432,
            icon = 132192,
            model = 96529,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Porcupine Soul"],
            loot = Item(3753378, L["Wild Hunt Supplies"], RARE_BLUE_COLOR),
            faction = { id = 2465, level = 8 },
            guide = L["Paragon reward."],
            critter = true,
            questID = 64989,
            icon = 838549,
            model = 100640,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Prairie Dog Soul"],
            vendor = {
                name = L["Master Clerk Salorn"],
                region = L["Ardenweald"],
                cost = { id = 1813, amount = 10000 },
            },
            pinData = {
                { 1565, 43.0, 47.0, 99767, nil, L["Master Clerk Salorn"], nil },
            },
            critter = true,
            questID = 64992,
            icon = 656176,
            model = 103070,
            scale = 6.5,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Ram Soul"],
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                cost = {
                    { id = 1813, amount = 25000 },
                    { id = 1885, amount = 50 },
                },
            },
            pinData = {
                { 1565, 59.6, 52.8, 99751, nil, L["Spindlenose"], nil },
            },
            questID = 65009,
            icon = 132248,
            model = 103075,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Raptor Soul"],
            loot = L["Mueh'Zala"],
            region = L["De Other Side"],
            difficulty = L["Any"],
            questID = 62433,
            icon = 838683,
            model = 96531,
            scale = 5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Rat Soul"],
            vendor = {
                name = L["Shopkeeper"],
                region = L["Tazavesh, the Veiled Market"],
                cost = {
                    { gold = 750 },
                    { custom = Item(1542861, L["Synvir Lockbox"], UNCOMMON_GREEN_COLOR), amount = 2 },
                    { custom = Item(1542849, L["Stygian Lockbox"], UNCOMMON_GREEN_COLOR), amount = 2 },
                },
            },
            guide = L["Rat Soul Guide"],
            critter = true,
            questID = 64985,
            icon = 647701,
            model = 100639,
            scale = 5,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Runestag Soul"],
            loot = L["Mystic Rainbowhorn"],
            region = L["Ardenweald"],
            guide = L["Runestag Soul Guide"],
            questID = 62434,
            icon = 3087326,
            model = 95614,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Saurid Soul"],
            npc = L["Lost Soul"],
            region = L["Maldraxxus"],
            guide = L["Saurid Soul Guide"],
            pinData = {
                { 1536, 44.8, 67.8, 103067, nil, L["Lost Soul"], nil },
            },
            critter = true,
            questID = 64995,
            icon = 2399239,
            model = 103067,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Saurolisk Hatchling Soul"],
            loot = L["The Adamant Vaults"],
            region = L["Torghast"],
            critter = true,
            questID = 64993,
            icon = 2027844,
            model = 97505,
            scale = 3,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Saurolisk Soul"],
            loot = L["The Adamant Vaults"],
            region = L["Torghast"],
            questID = 63605,
            icon = 2027929,
            model = 100624,
            scale = 5,
            buildNumber = SJ.BUILD_9_0_5,
        },
        {
            name = L["Shadowstalker Soul"],
            loot = L["Valfir the Unrelenting"],
            region = L["Ardenweald"],
            pinData = {
                { 1565, 30.6, 55.0, 96087, nil, L["Valfir the Unrelenting"], nil },
            },
            questID = 62431,
            icon = 2475038,
            model = 96530,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Shoveltusk Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Shoveltusk Soul Guide"],
            questID = 63604,
            icon = 134060,
            model = 100623,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Shrieker Soul"],
            loot = L["Mistcaller"],
            region = L["Mists of Tirna Scithe"],
            difficulty = L["Any"],
            questID = 62436,
            icon = 952507,
            model = 96518,
            scale = 5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Snake Soul"],
            loot = L["Covenant Callings reward chests"],
            region = L["Shadowlands"],
            guide = L["Goat Soul Guide"],
            critter = true,
            questID = 64988,
            icon = 2399227,
            model = 103068,
            scale = 4,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Snapper Soul"],
            loot = L["Queen's Conservatory Cache"],
            covenantFeature = L["Queen's Conservatory"],
            guide = {
                text = L["Gulper Soul Guide"], -- not a typo, same as Gulper
                args = { Item(960671, L["Wildseed Root Grain"], EPIC_PURPLE_COLOR) },
            },
            questID = 62420,
            icon = 1339043,
            model = 96527,
            scale = 4,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Spider Soul"],
            loot = L["Riftbound Cache"],
            region = L["Korthia"],
            guide = {
                text = L["Spider Soul Guide"],
                args = { Item(528693, L["Repaired Riftkey"], UNCOMMON_GREEN_COLOR) },
            },
            questID = 63606,
            icon = 2027946,
            model = 100625,
            scale = 4,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Sporebat Soul"],
            worldEvent = L["Burning Crusade Timewalking"],
            guide = L["Sporebat Soul Guide"],
            questID = 65022,
            icon = 132197,
            model = 103078,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Stag Soul"],
            quest = L["Night Fae dailies"],
            region = L["Korthia"],
            guide = L["Stag Soul Guide"],
            questID = 62435,
            icon = 1396983,
            model = 96528,
            buildNumber = SJ.BUILD_9_1,
        },
        {
            name = L["Squirrel Soul"],
            spell = L["Soulshape"],
            region = L["Ardenweald"],
            guide = L["Squirrel Soul Guide"],
            critter = true,
            icon = 3749003,
            model = 100635,
            scale = 5,
            collected = true,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Tiger Soul"],
            faction = { name = L["Marasmius"], level = 5 },
            vendor = {
                name = L["Cortinarius"],
                region = L["Mushroom Network"],
                cost = { id = 1813, amount = 1500 },
            },
            questID = 62437,
            icon = 620832,
            model = 96521,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Turkey Soul"],
            worldEvent = L["Pilgrim's Bounty"],
            guide = L["Turkey Soul Guide"],
            critter = true,
            questID = 65467,
            icon = 250626,
            model = 105220,
            scale = 3,
            buildNumber = SJ.BUILD_9_1_5,
        },
        {
            name = L["Ursine Soul"],
            faction = { name = L["Marasmius"], level = 5 },
            vendor = {
                name = L["Cortinarius"],
                region = L["Mushroom Network"],
                cost = { id = 1813, amount = 1500 },
            },
            questID = 62423,
            icon = 132183,
            model = 96532,
            scale = 4.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Veilwing Soul"],
            loot = L["Sire Denathrius"],
            region = L["Castle Nathria"],
            difficulty = { L["Heroic"], L["Mythic"] },
            questID = 62425,
            icon = 303867,
            model = 96535,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Vulpine Soul"],
            spell = L["Soulshape"],
            guide = L["Vulpine Soul Guide"],
            icon = 3586268,
            model = 93949,
            scale = 5,
            collected = true,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Wolfhawk Soul"],
            loot = L["Skuld Vit"],
            region = L["Ardenweald"],
            guide = L["Wolfhawk Soul Guide"],
            pinData = {
                { 1565, 36.9, 60.2, 96776, nil, L["Skuld Vit"], nil },
            },
            questID = 62439,
            icon = 1279719,
            model = 96537,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Wyvern Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Gryphon Soul Guide"], -- not a typo, same as Gryphon
            questID = 62440,
            icon = 537531,
            model = 96540,
            scale = 5.5,
            buildNumber = SJ.BUILD_9_0,
        },
        {
            name = L["Yak Soul"],
            loot = L["So'leah"],
            region = L["Tazavesh, the Veiled Market"],
            difficulty = L["Hardmode"],
            questID = 63603,
            icon = 900317,
            model = 100622,
            scale = 4,
            buildNumber = SJ.BUILD_9_1,
        },
        -- 9.2 Soulshapes
        {
            name = L["Armadillo Soul"],
            vendor = {
                name = L["Olea Manu"],
                zoneID = 1970,
                cost = { id = 1979, amount = 500 },
            },
            pinData = PIN_DATA_OLEA_MANU,
            questID = 65514,
            icon = 464159,
            model = 105260,
            critter = true,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Bat Soul"],
            npc = L["Lost Soul"],
            region = L["Torghast"],
            guide = L["Torghast 9.2 Soulshape Guide"],
            questID = 65509,
            icon = 132182,
            model = 105256,
            modelSceneID = 34,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Bee Soul"],
            loot = L["Lost Comb"],
            zoneID = 1970,
            guide = L["Bee Soul Guide"],
            pinData = {
                { 1970, 63.3, 60.6, nil, 3066348, L["Lost Comb"], nil }
            },
            questID = 65518,
            icon = 2027853,
            model = 105264,
            modelSceneID = 34,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Brutosaur Soul"],
            vendor = {
                name = L["Olea Manu"],
                zoneID = 1970,
                cost = { id = 1979, amount = 1000 },
            },
            pinData = PIN_DATA_OLEA_MANU,
            questID = 65510,
            icon = 1881827,
            model = 105257,
            scale = 5,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Cervid Soul"],
            loot = L["Prototype Pantheon"],
            difficulty = L["Heroic"],
            zoneID = 2049,
            questID = 65640,
            icon = 3747644,
            model = 105366,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Dragonhawk Soul"],
            npc = L["Lost Soul"],
            region = L["Torghast"],
            guide = L["Torghast 9.2 Soulshape Guide"],
            questID = 65504,
            icon = 132188,
            model = 105251,
            modelSceneID = 34,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Elekk Soul"],
            npc = L["Lost Soul"],
            region = L["Torghast"],
            guide = L["Torghast 9.2 Soulshape Guide"],
            questID = 65507,
            icon = 132254,
            model = 105254,
            scale = 4,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Gromit Soul"],
            loot = L["Shrouded Cypher Cache"],
            guide = L["Gromit Soul Guide"],
            zoneID = 1970,
            pinData = {
                { 1970, 36.3, 48.1, nil, 4066374, L["Shrouded Cypher Cache"], L["Shrouded Cypher Cache Tooltip"] },
                { 1970, 40.3, 62.7, nil, 4066374, L["Shrouded Cypher Cache"], L["Shrouded Cypher Cache Tooltip"] },
                { 1970, 43.9, 84.2, nil, 4066374, L["Shrouded Cypher Cache"], L["Shrouded Cypher Cache Tooltip"] },
                { 1970, 54.5, 77.8, nil, 4066374, L["Shrouded Cypher Cache"], L["Shrouded Cypher Cache Tooltip"] },
            },
            questID = 65513,
            icon = 3931157,
            model = 105259,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Penguin Soul"],
            npc = L["Lost Soul"],
            guide = L["Penguin Soul Guide"],
            zoneID = 1970,
            pinData = {
                { 1970, 31.48, 50.42, 105263, nil, L["Lost Soul"], nil }
            },
            coordinates = { x = 31.48, y = 50.42 },
            questID = 65517,
            icon = 655866,
            model = 105263,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Pig Soul"],
            npc = L["Lost Soul"],
            region = L["Torghast"],
            guide = L["Torghast 9.2 Soulshape Guide"],
            questID = 65515,
            icon = 1721030,
            model = 105261,
            critter = true,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Ray Soul"],
            loot = Item(4066374, L["Enlightened Broker Supplies"], RARE_BLUE_COLOR),
            faction = { id = 2478, level = 8 },
            guide = L["Paragon reward."],
            zoneID = 1970,
            questID = 65506,
            icon = 2620775,
            model = 105253,
            modelSceneID = 34,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Scorpid Soul"],
            loot = L["Shifting Stargorger"],
            zoneID = 1970,
            pinData = {
                { 1970, 42.2, 21.6, 101916, nil, L["Shifting Stargorger"], nil }
            },
            questID = 65505,
            icon = 132195,
            model = 105252,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Sheep Soul"],
            npc = L["Lost Soul"],
            guide = L["Sheep Soul Guide"],
            zoneID = 1970,
            pinData = {
                { 1970, 37.2, 34.2, 105262, nil, L["Lost Soul"], nil },
                { 1970, 37.6, 77.0, 105262, nil, L["Lost Soul"], nil },
                { 1970, 44.0, 79.8, 105262, nil, L["Lost Soul"], nil },
                { 1970, 49.9, 80.1, 105262, nil, L["Lost Soul"], nil },
                { 1970, 38.6, 80.6, 105262, nil, L["Lost Soul"], nil },
                { 1970, 38.6, 80.6, 105262, nil, L["Lost Soul"], nil },
                { 1970, 38.2, 71.8, 105262, nil, L["Lost Soul"], nil },
                { 1970, 30.6, 67.2, 105262, nil, L["Lost Soul"], nil },
                { 1970, 58.4, 75.0, 105262, nil, L["Lost Soul"], nil },
            },
            questID = 65516,
            icon = 136071,
            model = 105262,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Silithid Soul"],
            loot = L["The Jailer"],
            difficulty = L["Heroic"],
            zoneID = 2051,
            questID = 65512,
            icon = 1623378,
            model = 105258,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Snail Soul"],
            loot = L["High Value Cache"],
            difficulty = { L["Normal"], L["Heroic"], L["Mythic"] },
            zoneID = 2061,
            guide = L["Snail Soul Guide"],
            pinData = {
                { 2061, 24.5, 36.9, nil, 4062292, L["High Value Cache"], L["High Value Cache Tooltip"] },
                { 2061, 20.5, 40, 98515, nil, L["Taskmaster Xy'pro"], L["Taskmaster Xy'pro Tooltip"] },
            },
            questID = 65519,
            icon = 2530489,
            model = 105265,
            critter = true,
            buildNumber = SJ.BUILD_9_2,
        },
        {
            name = L["Tallstrider Soul"],
            npc = L["Lost Soul"],
            region = L["Torghast"],
            guide = L["Torghast 9.2 Soulshape Guide"],
            questID = 65508,
            icon = 132198,
            model = 105255,
            buildNumber = SJ.BUILD_9_2,
        },
    }

    -- This is a safety against showing soulshapes from a future build
    soulshapes = RemoveUpcomingSoulshapes(soulshapes)

    -- Generate source and guide fields for soulshapes
    for _, soulshape in ipairs(soulshapes) do
        ResolveRegion(soulshape)
        CreateLocations(soulshape)
        soulshape.source = CreateSourceString(soulshape)
        soulshape.guide = CreateGuideString(soulshape)
        soulshape.searchText = CreateSearchText(soulshape)
    end

    SJ.Database = CreateFromMixins({
        soulshapes = soulshapes,
    }, DatabaseMixin)
end

SJ.CreateDatabase = function()
    CreateDatabase()
    SJ.Database:Sort()
end
