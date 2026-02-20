--[[
    Soulshape Journal - A World of Warcraft Soulshape collection addon
    Copyright (C) 2021-2026  Christophe MICHEL

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local ADDON_NAME, SC = ...
local SoulshapeJournal = LibStub("AceAddon-3.0"):NewAddon(SC, ADDON_NAME, "AceConsole-3.0")

function SoulshapeJournal:OnInitialize()
    self.saved = LibStub("AceDB-3.0"):New("SoulshapeJournalDB", {
        char = {
            collectedUntrackable = {
                ["corgi"] = false,
                ["catwellfed"] = false,
            },
        },
    })
end

function SoulshapeJournal:OnEnable()
    self:CreateDatabase()

    -- Fixes an issue when our addon loads before Blizzard_Collections
    if not CollectionsJournal then
        C_AddOns.LoadAddOn("Blizzard_Collections")
    end 

    self:CreateCollectionPanel()
end
