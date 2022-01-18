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

local ADDON_NAME, SC = ...

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME, true)

-- upvalues for frequent API calls
local isQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted

local function isarray(t)
   return type(t) == "table" and #t > 0
end

local DatabaseMixin = {

    Filters = {

        COLLECTED = function(soulshape)
            return soulshape.collected
        end,

        NOT_COLLECTED = function(soulshape)
            return not soulshape.collected
        end,

    },

    activeFilters = {},

}

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
        SC.saved.char.collectedUntrackable[soulshape.untrackable] = true
        return true
    end
    return false
end

function DatabaseMixin:IsCollected(soulshape)
    if soulshape.questID then
        return isQuestCompleted(soulshape.questID)
    else
        return soulshape.untrackable and SC.saved.char.collectedUntrackable[soulshape.untrackable]
    end
end

function DatabaseMixin:SetTextFilter(textFilter)
    self.textFilter = textFilter
end

function DatabaseMixin:SetFilter(filter, value)
    self.activeFilters[filter] = value
end

function DatabaseMixin:HasFilter(filter)
    return self.activeFilters[filter] or false
end

function DatabaseMixin:HasAtLeastOneFilter()
    for k, v in pairs(self.activeFilters) do
        if v then
            return true
        end
    end
    return false
end

function DatabaseMixin:GetFilteredItems()
    if (self.textFilter == nil or self.textFilter == "") and not self:HasAtLeastOneFilter() then
        -- No filter active, do nothing
        return self.soulshapes
    end

    local filteredItems = {}
    for _, item in ipairs(self.soulshapes) do
        local isShown = false

        -- Dropdown filters
        for filter, enabled in pairs(self.activeFilters) do
            if enabled then
                isShown = isShown or filter(item)
            end
        end

        -- Text filter
        if self.textFilter and self.textFilter ~= "" then
            isShown = isShown and item.searchText:find(self.textFilter:lower(), 1, true)
        end

        if isShown then
            tinsert(filteredItems, item)
        end
    end
    return filteredItems
end

local function CostFormatter(cost)
    if not isarray(cost) then
        cost = {cost}
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

local function CoordinatesFormatter(coordinates)
    return coordinates.x .. ", " .. coordinates.y
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
        addLine(L["Coordinates"], vendor.coordinates, CoordinatesFormatter)
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
    addLine(L["Difficulty"], soulshape.difficulty)
    addLine(L["Coordinates"], soulshape.coordinates, CoordinatesFormatter)
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

local function CreateDatabase()
    local soulshapes =  {
        {
            name = L["Alpaca Soul"],
            loot = L["Shadowlands World Bosses"],
            questID = 65010,
            icon = 2061352,
            model = 103074,
            scale = 3.5,
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
        },
        {
            name = L["Boar Soul"],
            worldEvent = L["Warlords of Draenor Timewalking"],
            guide = L["Boar Soul Guide"],
            questID = 65025,
            icon = 1044799,
            model = 103082,
            scale = 3,
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
        },
        {
            name = L["Cat Soul"],
            npc = L["Lost Soul"],
            region = L["Ardenweald"],
            guide = L["Cat Soul Guide"],
            critter = true,
            questID = 64961,
            icon = 656574,
            model = 103084,
        },
        {
            name = L["Cat Soul (Well Fed)"],
            npc = L["Ma'oh"],
            region = L["Ardenweald"],
            coordinates = { x=54.9, y=45.1 },
            guide = L["Cat Soul (Well Fed) Guide"],
            critter = true,
            icon = 656577,
            model = 100636,
            scale = 4,
            untrackable = "catwellfed",
        },
        {
            name = L["Chicken Soul"],
            npc = L["Lost Soul"],
            region = L["Revendreth"],
            coordinates = { x=63.18, y=42.76 },
            guide = L["Chicken Soul Guide"],
            critter = true,
            questID = 64941,
            icon = 2027864,
            model = 102363,
            scale = 4,
        },
        {
            name = L["Cloud Serpent Soul"],
            worldEvent = L["Mists of Pandaria Timewalking"],
            guide = L["Cloud Serpent Soul Guide"],
            questID = 65024,
            icon = 1247267,
            model = 103080,
            scale = 6,
        },
        {
            name = L["Cobra Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Cobra Soul Guide"],
            questID = 64651,
            icon = 2399271,
            model = 96525,
            scale = 4,
        },
        {
            name = L["Corgi Soul"],
            npc = L["Sparkle"],
            region = L["Ardenweald"],
            guide = L["Corgi Soul Guide"],
            critter = true,
            icon = 1339013,
            model = 100634,
            scale = 4,
            untrackable = "corgi",
        },
        {
            name = L["Crane Soul"],
            faction = { id=2465, level=6 },
            vendor = {
                {
                    name = L["Aithlyn"],
                    region = L["Ardenweald"],
                    cost = { id=1813, amount=2500 },
                },
                {
                    name = L["Liawyn"],
                    region = L["Oribos"],
                    cost = { id=1813, amount=2500 },
                }
            },
            questID = 62424,
            icon = 605484,
            model = 96519,
            scale = 4,
        },
        {
            name = L["Cricket Soul"],
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                coordinates = { x=59.6, y=52.8 },
                cost = {
                    { id=1813, amount=15000 },
                    { id=1885, amount=25 },
                },
            },
            critter = true,
            questID = 64990,
            icon = 646325,
            model = 103069,
            scale = 4,
        },
        {
            name = L["Direhorn Soul"],
            loot = L["The Grand Menagerie"],
            region = L["Tazavesh, the Veiled Market"],
            questID = 63607,
            icon = 791593,
            model = 100626,
            scale = 5,
        },
        {
            name = L["Eagle Soul"],
            vendor = {
                name = L["Master Clerk Salorn"],
                region = L["Ardenweald"],
                coordinates = { x=43.0, y=47.0 },
                cost = { id=1813, amount=20000 },
            },
            questID = 65021,
            icon = 132172,
            model = 103076,
            modelSceneID = 34,
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
        },
        {
            name = L["Gryphon Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Gryphon Soul Guide"],
            questID = 62426,
            icon = 537515,
            model = 96539,
            scale = 5.5,
        },
        {
            name = L["Gulper Soul"],
            loot = L["Queen's Conservatory Cache"],
            covenantFeature = L["Queen's Conservatory"],
            guide = {
                text = L["Gulper Soul Guide"],
                args = {Item(960671, L["Wildseed Root Grain"], EPIC_PURPLE_COLOR)},
            },
            questID = 62421,
            icon = 2481372,
            model = 97394,
            scale = 3,
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
        },
        {
            name = L["Hyena Soul"],
            loot = L["Mythic+ dungeons"],
            guide = L["Hyena Soul Guide"],
            questID = 64650,
            icon = 132190,
            model = 96524,
            scale = 4,
        },
        {
            name = L["Jormungar Soul"],
            worldEvent = L["Wrath of the Lich King Timewalking"],
            guide = L["Jormungar Soul Guide"],
            questID = 65023,
            icon = 1531518,
            model = 103079,
            scale = 5,
        },
        {
            name = L["Kodo Soul"],
            worldEvent = L["Cataclysm Timewalking"],
            guide = L["Kodo Soul Guide"],
            questID = 63609,
            icon = 132243,
            model = 100629,
            scale = 5,
        },
        {
            name = L["Leonine Soul"],
            faction = { id=2464, level=5 },
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                coordinates = { x=59.6, y=52.8 },
                cost = {
                    { id=1813, amount=1500 },
                    { id=1885, amount=5 },
                },
            },
            questID = 62429,
            icon = 464140,
            model = 96520,
            scale = 5.5,
        },
        {
            name = L["Lupine Soul"],
            faction = { id=2464, level=5 },
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                coordinates = { x=59.6, y=52.8 },
                cost = {
                    { id=1813, amount=1500 },
                    { id=1885, amount=5 },
                },
            },
            questID = 62438,
            icon = 464162,
            model = 96534,
            scale = 5,
        },
        {
            name = L["Mammoth Soul"],
            loot = Item(3753378, L["Wild Hunt Supplies"], RARE_BLUE_COLOR),
            faction = { id=2465, level=8 },
            guide = L["Paragon reward."],
            questID = 63610,
            icon = 236240,
            model = 100630,
        },
        {
            name = L["Moose Soul"],
            vendor = {
                name = L["Master Clerk Salorn"],
                region = L["Ardenweald"],
                coordinates = { x=43.0, y=47.0 },
                cost = { id=1813, amount=1500 },
            },
            guide = L["Moose Soul Guide"],
            questID = 62430,
            icon = 1390637,
            model = 96533,
        },
        {
            name = L["Otter Soul"],
            npc = L["Lost Soul"],
            region = L["Bastion"],
            coordinates = { x=49.8, y=46.8 },
            guide = L["Otter Soul Guide"],
            critter = true,
            questID = 64959,
            icon = 645906,
            model = 100637,
            scale = 4,
        },
        {
            name = L["Owl Soul"],
            worldEvent = L["Legion Timewalking"],
            guide = L["Owl Soul Guide"],
            questID = 65026,
            icon = 1387709,
            model = 103083,
            modelSceneID = 34,
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
        },
        {
            name = L["Porcupine Soul"],
            loot = Item(3753378, L["Wild Hunt Supplies"], RARE_BLUE_COLOR),
            faction = { id=2465, level=8 },
            guide = L["Paragon reward."],
            critter = true,
            questID = 64989,
            icon = 838549,
            model = 100640,
        },
        {
            name = L["Prairie Dog Soul"],
            vendor = {
                name = L["Master Clerk Salorn"],
                region = L["Ardenweald"],
                coordinates = { x=43.0, y=47.0 },
                cost = { id=1813, amount=10000 },
            },
            critter = true,
            questID = 64992,
            icon = 656176,
            model = 103070,
            scale = 6.5,
        },
        {
            name = L["Ram Soul"],
            vendor = {
                name = L["Spindlenose"],
                region = L["Ardenweald"],
                coordinates = { x=59.6, y=52.8 },
                cost = {
                    { id=1813, amount=25000 },
                    { id=1885, amount=50 },
                },
            },
            questID = 65009,
            icon = 132248,
            model = 103075,
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
        },
        {
            name = L["Rat Soul"],
            vendor = {
                name = L["Shopkeeper"],
                region = L["Tazavesh, the Veiled Market"],
                cost = {
                    { gold=750 },
                    { custom=Item(1542861, L["Synvir Lockbox"], UNCOMMON_GREEN_COLOR), amount=2 },
                    { custom=Item(1542849, L["Stygian Lockbox"], UNCOMMON_GREEN_COLOR), amount=2 },
                },
            },
            guide = L["Rat Soul Guide"],
            critter = true,
            questID = 64985,
            icon = 647701,
            model = 100639,
            scale = 5,
        },
        {
            name = L["Runestag Soul"],
            loot = L["Mystic Rainbowhorn"],
            region = L["Ardenweald"],
            guide = L["Runestag Soul Guide"],
            questID = 62434,
            icon = 3087326,
            model = 95614,
        },
        {
            name = L["Saurid Soul"],
            npc = L["Lost Soul"],
            region = L["Maldraxxus"],
            coordinates = { x=44.8, y=67.8 },
            guide = L["Saurid Soul Guide"],
            critter = true,
            questID = 64995,
            icon = 2399239,
            model = 103067,
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
        },
        {
            name = L["Saurolisk Soul"],
            loot = L["The Adamant Vaults"],
            region = L["Torghast"],
            questID = 63605,
            icon = 2027929,
            model = 100624,
            scale = 5,
        },
        {
            name = L["Shadowstalker Soul"],
            loot = L["Valfir the Unrelenting"],
            region = L["Ardenweald"],
            coordinates = { x=30.6, y=55.0 },
            questID = 62431,
            icon = 2475038,
            model = 97492,
            scale = 5.5,
        },
        {
            name = L["Shoveltusk Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Shoveltusk Soul Guide"],
            questID = 63604,
            icon = 134060,
            model = 100623,
            scale = 4,
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
        },
        {
            name = L["Snapper Soul"],
            loot = L["Queen's Conservatory Cache"],
            covenantFeature = L["Queen's Conservatory"],
            guide = {
                text = L["Gulper Soul Guide"], -- not a typo, same as Gulper
                args = {Item(960671, L["Wildseed Root Grain"], EPIC_PURPLE_COLOR)},
            },
            questID = 62420,
            icon = 1339043,
            model = 96527,
            scale = 4,
        },
        {
            name = L["Spider Soul"],
            loot = L["Riftbound Cache"],
            region = L["Korthia"],
            guide = {
                text = L["Spider Soul Guide"],
                args = {Item(528693, L["Repaired Riftkey"], UNCOMMON_GREEN_COLOR)},
            },
            questID = 63606,
            icon = 2027946,
            model = 100625,
            scale = 4,
        },
        {
            name = L["Sporebat Soul"],
            worldEvent = L["Burning Crusade Timewalking"],
            guide = L["Sporebat Soul Guide"],
            questID = 65022,
            icon = 132197,
            model = 103078,
        },
        {
            name = L["Stag Soul"],
            quest = L["Night Fae dailies"],
            region = L["Korthia"],
            guide = L["Stag Soul Guide"],
            questID = 62435,
            icon = 1396983,
            model = 96528,
        },
        {
            name = L["Tiger Soul"],
            faction = { name=L["Marasmius"], level=5 },
            vendor = {
                name = L["Cortinarius"],
                region = L["Mushroom Network"],
                cost = { id=1813, amount=1500 },
            },
            questID = 62437,
            icon = 620832,
            model = 96521,
            scale = 5.5,
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
        },
        {
            name = L["Ursine Soul"],
            faction = { name=L["Marasmius"], level=5 },
            vendor = {
                name = L["Cortinarius"],
                region = L["Mushroom Network"],
                cost = { id=1813, amount=1500 },
            },
            questID = 62423,
            icon = 132183,
            model = 96532,
            scale = 4.5,
        },
        {
            name = L["Veilwing Soul"],
            loot = L["Sire Denathrius"],
            region = L["Castle Nathria"],
            difficulty = L["Normal or Heroic"],
            questID = 62425,
            icon = 303867,
            model = 96535,
            scale = 5.5,
        },
        {
            name = L["Vulpine Soul"],
            spell = L["Soulshape"],
            guide = L["Vulpine Soul Guide"],
            icon = 3586268,
            model = 93949,
            scale = 5,
            collected = true,
        },
        {
            name = L["Wolfhawk Soul"],
            loot = L["Skuld Vit"],
            region = L["Ardenweald"],
            coordinates = { x=36.90, y=60.20 },
            guide = L["Wolfhawk Soul Guide"],
            questID = 62439,
            icon = 1279719,
            model = 96537,
            scale = 5.5,
        },
        {
            name = L["Wyvern Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Gryphon Soul Guide"], -- not a typo, same as Gryphon
            questID = 62440,
            icon = 537531,
            model = 96540,
            scale = 5.5,
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
        }
    }

    -- Generate source and guide fields for soulshapes
    for _, soulshape in ipairs(soulshapes) do
        soulshape.source = CreateSourceString(soulshape)
        soulshape.guide = CreateGuideString(soulshape)
        soulshape.searchText = CreateSearchText(soulshape)
    end

    SC.Database = CreateFromMixins({
        soulshapes = soulshapes,
    }, DatabaseMixin)

    -- Default filters
    SC.Database:SetFilter(SC.Database.Filters.COLLECTED, true)
    SC.Database:SetFilter(SC.Database.Filters.NOT_COLLECTED, true)
end

SC.CreateDatabase = function()
    CreateDatabase()
    SC.Database:Sort()
end
