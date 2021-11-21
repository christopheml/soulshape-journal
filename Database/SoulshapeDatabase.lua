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

 function isarray(t)
    return type(t) == "table" and #t > 0
 end

local DatabaseFactory = {
    DEFAULT_SOULSHAPE_ICON = 3586268,
    formatters = {},
}

local DatabaseMixin = {}

function DatabaseMixin:Sort()
    -- For the moment default to natural order on names
    table.sort(soulshapes, function(left, right)
        return left.name < right.name
    end)
end

function DatabaseMixin:Update()
    for _, soulshape in ipairs(self.soulshapes) do
        soulshape.collected = soulshape.collected or self:IsCollected(soulshape)
    end
end

function DatabaseMixin:Count()
    return #self.soulshapes
end

function DatabaseMixin:IsCollected(soulshape)
    if soulshape.questID then
        return C_QuestLog.IsQuestFlaggedCompleted(soulshape.questID)
    else
        return soulshape.untrackable and SC.saved.char.collectedUntrackable[soulshape.untrackable]
    end
end

function DatabaseFactory.formatters.cost(cost)
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

function DatabaseFactory.formatters.coordinates(coordinates)
    return coordinates.x .. ", " .. coordinates.y
end

function DatabaseFactory.formatters.faction(faction)
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

function DatabaseFactory.formatters.campaignQuest(quest)
    return "|A:quest-campaign-available:12:12|a" .. quest
end

function DatabaseFactory:Label(name)
    if GetLocale() == "frFR" then
        -- French typography requires a space after colons
        return format("|cffffd100%s: |r ", name)
    else
        return format("|cffffd100%s:|r ", name)
    end
end

function DatabaseFactory:Item(icon, name, rarity)
    return format("|T%d:0|t%s", icon, rarity:WrapTextInColorCode(name))
end

function DatabaseFactory:CreateSourceString(soulshape)
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
            tinsert(source, self:Label(label) .. value)
        end
    end

    function renderVendor(vendor)
        addLine(L["Vendor"], vendor.name)
        addLine(L["Region"], vendor.region)
        addLine(L["Coordinates"], vendor.coordinates, self.formatters.coordinates)
        addLine(L["Cost"], vendor.cost, self.formatters.cost)
    end
    
    addLine(L["Loot"], soulshape.loot)
    addLine(L["Quest"], soulshape.quest)
    addLine(L["Quest"], soulshape.campaignQuest, self.formatters.campaignQuest)
    addLine(L["Campaign"], soulshape.campaign)
    addLine(L["World Event"], soulshape.worldEvent)
    addLine(L["World Quest"], soulshape.worldQuest)
    addLine(L["NPC"], soulshape.npc)
    addLine(L["Profession"], soulshape.profession)
    addLine(L["Region"], soulshape.region)
    addLine(L["Cost"], soulshape.cost, self.formatters.cost)
    addLine(L["Faction"], soulshape.faction, self.formatters.faction)
    addMultiLine(soulshape.vendor, renderVendor)
    addLine(L["Covenant Feature"], soulshape.covenantFeature)
    addLine(L["Difficulty"], soulshape.difficulty)
    addLine(L["Coordinates"], soulshape.coordinates, self.formatters.coordinates)
    addLine(L["Renown"], soulshape.renown)
    addLine(L["Spell"], soulshape.spell)
    return table.concat(source, "\n")
end

function DatabaseFactory:CreateGuideString(soulshape)
    local guide = soulshape.guide
    if type(guide) == "table" and guide.text and guide.args and isarray(guide.args) then
        return string.format(guide.text, unpack(guide.args))
    else
        return guide
    end
end

function DatabaseFactory:CreateDatabase()
    local soulshapes =  {
        {
            name = L["Alpaca Soul"],
            loot = L["Shadowlands World Bosses"],
            questID = 65010,
            icon = 2061352,
            model = 103074,
            scale = 3,
        },
        {
            name = L["Ardenmoth Soul"],
            campaignQuest = L["Drust and Ashes"],
            campaign = L["Drust and Ashes"],
            renown = 22,
            questID = 62422,
            icon = 3255388,
            model = 96511,
        },
        {
            name = L["Boar Soul"],
            worldEvent = L["Warlords of Draenor Timewalking"],
            guide = L["Boar Soul Guide"],
            questID = 65025,
            icon = 1044799,
            model = 103082,
            scale = 2,
        },
        {
            name = L["Bunny Soul"],
            worldQuest = L["Pet Battle"],
            region = L["Ardenweald"],
            guide = L["Bunny Soul Guide"],
            questID = 64984,
            icon = 2399274,
            model = 102364,
        },
        {
            name = L["Cat Soul"],
            npc = L["Lost Soul"],
            region = L["Ardenweald"],
            guide = L["Cat Soul Guide"],
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
            icon = 656577,
            model = 100636,
            untrackable = "catwellfed",
        },
        {
            name = L["Chicken Soul"],
            npc = L["Lost Soul"],
            region = L["Revendreth"],
            coordinates = { x=63.18, y=42.76 },
            guide = L["Chicken Soul Guide"],
            questID = 64941,
            icon = 2027864,
            model = 102363,
        },
        {
            name = L["Cloud Serpent Soul"],
            worldEvent = L["Mists of Pandaria Timewalking"],
            guide = L["Cloud Serpent Soul Guide"],
            questID = 65024,
            icon = 1247267,
            model = 103080,
        },
        {
            name = L["Cobra Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Cobra Soul Guide"],
            questID = 64651,
            icon = 2399271,
            model = 96525,
        },
        {
            name = L["Corgi Soul"],
            npc = L["Sparkle"],
            region = L["Ardenweald"],
            guide = L["Corgi Soul Guide"],
            icon = 1339013,
            model = 100634,
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
        },
        {
            name = L["Direhorn Soul"],
            loot = L["The Grand Menagerie"],
            region = L["Tazavesh, the Veiled Market"],
            questID = 63607,
            icon = 791593,
            model = 100626,
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
        },
        {
            name = L["Equine Soul"],
            campaignQuest = L["Mending a Broken Hart"],
            campaign = L["Night Warrior's Curse"],
            renown = 11,
            questID = 62428,
            icon = 2153980,
            model = 96517,
        },
        {
            name = L["Frog Soul"],
            profession = PROFESSIONS_FISHING,
            region = L["Shadowlands"],
            guide = L["Frog Soul Guide"],
            questID = 64994,
            icon = 2399262,
            model = 100638,
        },
        {
            name = L["Goat Soul"],
            loot = self:Item(3753378, L["Bounty of the Grove Wardens"], RARE_BLUE_COLOR),
            region = L["Ardenweald"],
            guide = BOUNTY_BOARD_LOCKED_TITLE,
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
        },
        {
            name = L["Gulper Soul"],
            loot = L["Queen's Conservatory Cache"],
            covenantFeature = L["Queen's Conservatory"],
            guide = {
                text = L["Gulper Soul Guide"],
                args = {self:Item(960671, L["Wildseed Root Grain"], EPIC_PURPLE_COLOR)},
            },
            questID = 62421,
            icon = 2481372,
            model = 97394,
            scale = 3,
        },
        {
            name = L["Hippo Soul"],
            loot = self:Item(3753378, L["War Chest of the Wild Hunt"], RARE_BLUE_COLOR),
            region = L["The Maw"],
            guide = L["Hippo Soul Guide"],
            questID = 63608,
            icon = 1044490,
            model = 100627,
            scale = 2.2,
        },
        {
            name = L["Hippogryph Soul"],
            campaignQuest = L["The Power of Elune"],
            campaign = L["The Power of Night"],
            renown = 54,
            questID = 62427,
            icon = 1455896,
            model = 96538,
        },
        {
            name = L["Hyena Soul"],
            loot = L["Mythic+ dungeons"],
            guide = L["Hyena Soul Guide"],
            questID = 64650,
            icon = 132190,
            model = 96524,
        },
        {
            name = L["Jormungar Soul"],
            worldEvent = L["Wrath of the Lich King Timewalking"],
            guide = L["Jormungar Soul Guide"],
            questID = 65023,
            icon = 1531518,
            model = 103079,
        },
        {
            name = L["Kodo Soul"],
            worldEvent = L["Cataclysm Timewalking"],
            guide = L["Kodo Soul Guide"],
            questID = 63609,
            icon = 132243,
            model = 100629,
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
        },
        {
            name = L["Mammoth Soul"],
            loot = self:Item(3753378, L["Wild Hunt Supplies"], RARE_BLUE_COLOR),
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
            questID = 64959,
            icon = 645906,
            model = 100637,
        },
        {
            name = L["Owl Soul"],
            worldEvent = L["Legion Timewalking"],
            guide = L["Owl Soul Guide"],
            questID = 65026,
            icon = 1387709,
            model = 103083,
        },
        {
            name = L["Owlcat Soul"],
            loot = L["Lady Sylvanas Windrunner"],
            region = L["Sanctum of Domination"],
            difficulty = L["Heroic"],
            questID = 62432,
            icon = 132192,
            model = 96529,
        },
        {
            name = L["Porcupine Soul"],
            loot = self:Item(3753378, L["Wild Hunt Supplies"], RARE_BLUE_COLOR),
            faction = { id=2465, level=8 },
            guide = L["Paragon reward."],
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
            questID = 64992,
            icon = 656176,
            model = 103070,
            scale = 6,
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
        },
        {
            name = L["Rat Soul"],
            vendor = {
                name = L["Shopkeeper"],
                region = L["Tazavesh, the Veiled Market"],
                cost = {
                    { gold=750 },
                    { custom=self:Item(1542861, L["Synvir Lockbox"], UNCOMMON_GREEN_COLOR), amount=2 },
                    { custom=self:Item(1542849, L["Stygian Lockbox"], UNCOMMON_GREEN_COLOR), amount=2 },
                },
            },
            guide = L["Rat Soul Guide"],
            questID = 64985,
            icon = 647701,
            model = 100639,
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
            questID = 64995,
            icon = 2399239,
            model = 103067,
        },
        {
            name = L["Saurolisk Hatchling Soul"],
            loot = L["The Adamant Vaults"],
            region = L["Torghast"],
            questID = 64993,
            icon = 2027844,
            model = 97505,
            scale = 2,
        },
        {
            name = L["Saurolisk Soul"],
            loot = L["The Adamant Vaults"],
            region = L["Torghast"],
            questID = 63605,
            icon = 2027929,
            model = 100624,
        },
        {
            name = L["Shadowstalker Soul"],
            loot = L["Valfir the Unrelenting"],
            region = L["Ardenweald"],
            coordinates = { x=30.6, y=55.0 },
            questID = 62431,
            icon = 2475038,
            model = 97492,
        },
        {
            name = L["Shoveltusk Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Shoveltusk Soul Guide"],
            questID = 63604,
            icon = 134060,
            model = 100623,
        },
        {
            name = L["Shrieker Soul"],
            loot = L["Mistcaller"],
            region = L["Mists of Tirna Scithe"],
            difficulty = L["Any"],
            questID = 62436,
            icon = 952507,
            model = 96518,
        },
        {
            name = L["Snake Soul"],
            loot = self:Item(3753378, L["Bounty of the Grove Wardens"], RARE_BLUE_COLOR),
            region = L["Ardenweald"],
            guide = BOUNTY_BOARD_LOCKED_TITLE,
            questID = 64988,
            icon = 2399227,
            model = 103068,
        },
        {
            name = L["Snapper Soul"],
            loot = L["Queen's Conservatory Cache"],
            covenantFeature = L["Queen's Conservatory"],
            guide = {
                text = L["Gulper Soul Guide"], -- not a typo, same as Gulper
                args = {self:Item(960671, L["Wildseed Root Grain"], EPIC_PURPLE_COLOR)},
            },
            questID = 62420,
            icon = 1339043,
            model = 96527,
        },
        {
            name = L["Spider Soul"],
            loot = L["Riftbound Cache"],
            region = L["Korthia"],
            guide = {
                text = L["Spider Soul Guide"],
                args = {self:Item(528693, L["Repaired Riftkey"], UNCOMMON_GREEN_COLOR)},
            },
            questID = 63606,
            icon = 2027946,
            model = 100625,
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
        },
        {
            name = L["Veilwing Soul"],
            loot = L["Sire Denathrius"],
            region = L["Castle Nathria"],
            difficulty = L["Normal or Heroic"],
            questID = 62425,
            icon = 303867,
            model = 96535,
        },
        {
            name = L["Vulpine Soul"],
            spell = L["Soulshape"],
            guide = L["Vulpine Soul Guide"],
            icon = 3586268,
            model = 93949,
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
        },
        {
            name = L["Wyvern Soul"],
            loot = PLAYER_V_PLAYER,
            guide = L["Gryphon Soul Guide"], -- not a typo, same as Gryphon
            questID = 62440,
            icon = 537531,
            model = 96540,
        },
        {
            name = L["Yak Soul"],
            loot = L["So'leah"],
            region = L["Tazavesh, the Veiled Market"],
            difficulty = L["Hardmode"],
            questID = 63603,
            icon = 900317,
            model = 100622,
        }
    }

    -- Generate source and guide fields for soulshapes
    for _, soulshape in ipairs(soulshapes) do
        soulshape.source = self:CreateSourceString(soulshape)
        soulshape.guide = self:CreateGuideString(soulshape)
    end
    
    SC.Database = CreateFromMixins({ 
        soulshapes = soulshapes,
    }, DatabaseMixin)
end

SC.CreateDatabase = function()
    DatabaseFactory:CreateDatabase()
end
