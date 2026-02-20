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

local ADDON_NAME, SJ = ...

-- Debug module, not for regular use
local Debug = SJ:NewModule("DebugTools", "AceConsole-3.0")

function Debug:OnInitialize()
    -- Sets the ModelSceneID in the 3D view
    self:RegisterChatCommand("sj_msi", function(input)
        local modelSceneID = tonumber(input)
        local scene = SJ.Panel.SoulshapeDisplay.ModelScene
        scene:SetFromModelSceneID(modelSceneID, true, false)
    end)

    -- Sets the scale in the 3D view
    self:RegisterChatCommand("sj_scale", function(input)
        local scale = tonumber(input)
        local scene = SJ.Panel.SoulshapeDisplay.ModelScene
        local actor = scene:GetActorByTag("unwrapped")
        actor:SetRequestedScale(scale)
    end)
end
