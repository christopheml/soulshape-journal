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

local _, SJ = ...

-- Map name resolution
local nameCache = {}
local GetMapInfo = C_Map.GetMapInfo

function SJ:GetMapName(mapID)
    if not nameCache[mapID] then
        local mapInfo = GetMapInfo(mapID)
        nameCache[mapID] = mapInfo.name
    end
    return nameCache[mapID]
end
