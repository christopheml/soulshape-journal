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

-- Debug module, not for regular use
local Debug = SJ:NewModule("DebugTools", "AceConsole-3.0")

function Debug:OnInitialize()
    -- Allows fishing for SpellVisualKit ids
    self:RegisterChatCommand("sj_kit", function(input)
        if input == "+" then
            self.lastID = self.lastID + 1
        elseif input == "-" then
            self.lastID = self.lastID - 1
        else
            self.lastID = tonumber(input)
        end
        self:Print("CreatureDisplayInfoID = " .. (self.lastID or "<nil>"))
        CharacterModelFrame:SetDisplayInfo(self.lastID)
    end)

    -- Sets the ModelSceneID in the 3D view
    self:RegisterChatCommand("sj_msi", function(input)
        local modelSceneID = tonumber(input)
        local scene = SJ.Panel.SoulshapeDisplay.ModelScene
        scene:TransitionToModelSceneID(modelSceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_MAINTAIN, true)
    end)

    -- Sets the scale in the 3D view
    self:RegisterChatCommand("sj_scale", function(input)
        local scale = tonumber(input)
        local scene = SJ.Panel.SoulshapeDisplay.ModelScene
        local actor = scene:GetActorByTag("unwrapped")
        actor:SetRequestedScale(scale)
    end)
end
