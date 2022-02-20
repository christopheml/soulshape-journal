--[[ MIT License

Copyright (c) 2021-2022 Christophe MICHEL

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

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

SJ.FrameLevelType = "PIN_FRAME_LEVEL_SOULSHAPE_JOURNAL"

local SoulshapeJournalDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin)

function SoulshapeJournalDataProviderMixin:OnAdded(mapCanvas)
    MapCanvasDataProviderMixin.OnAdded(self, mapCanvas)
    mapCanvas:SetPinTemplateType("SoulshapeJournalPinTemplate", "BUTTON")
end

function SoulshapeJournalDataProviderMixin:OnShow()
    self:RegisterEvent("PORTRAITS_UPDATED")
end

function SoulshapeJournalDataProviderMixin:OnHide()
    self:UnregisterEvent("PORTRAITS_UPDATED")
end

function SoulshapeJournalDataProviderMixin:OnEvent(event, ...)
    if event == "PORTRAITS_UPDATED" then
        self:RefreshAllData()
    end
end

function SoulshapeJournalDataProviderMixin:RemoveAllData()
    self:GetMap():RemoveAllPinsByTemplate("SoulshapeJournalPinTemplate");
end

function SoulshapeJournalDataProviderMixin:OnMapChanged()
    MapCanvasDataProviderMixin.OnMapChanged(self)
end

function SoulshapeJournalDataProviderMixin:RefreshAllData()
    self:RemoveAllData()

    local soulshape = self.owningMap.soulshape
    if soulshape then
        local pins = soulshape.pins

        if pins then
            for _, pinData in ipairs(pins) do
                if pinData.mapID == self:GetMap():GetMapID() then
                    self:GetMap():AcquirePin("SoulshapeJournalPinTemplate", pinData)
                end
            end
        end
    end
end

-- We need this to be global for proper templating
SoulshapeJournalPinMixin = CreateFromMixins(MapCanvasPinMixin)

function SoulshapeJournalPinMixin:OnLoad()
    self:SetScalingLimits(1, 0.7, 1.3)
    self:UseFrameLevelType(SJ.FrameLevelType)
end

function SoulshapeJournalPinMixin:OnAcquired(pinData)
    self.data = pinData
    self:SetPosition(pinData.x / 100, pinData.y / 100)
    -- picture
    if pinData.creatureDisplayID then
        SetPortraitTextureFromCreatureDisplayID(self.Background, pinData.creatureDisplayID)
    elseif pinData.iconID then
        SetPortraitToTexture(self.Background, pinData.iconID)
    end
end

function SoulshapeJournalPinMixin:OnReleased()
    MapCanvasPinMixin.OnReleased(self)
    self.data = nil
end

function SoulshapeJournalPinMixin:OnMouseClickAction()
    if IsControlKeyDown() then
        local waypoint = UiMapPoint.CreateFromCoordinates(self.data.mapID, self.data.x / 100, self.data.y / 100)
        C_Map.SetUserWaypoint(waypoint)
        PlaySound(SOUNDKIT.UI_MAP_WAYPOINT_CONTROL_CLICK)
    elseif IsShiftKeyDown() then
        -- TODO: Add Tomtom Waypoint
    end
end

function SoulshapeJournalPinMixin:OnMouseEnter()
    if self.data and self.data.label then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        local coordinates = "(" .. self.data.x .. ", " .. self.data.y .. ")"
        GameTooltip_AddColoredDoubleLine(GameTooltip, self.data.label, coordinates, HIGHLIGHT_FONT_COLOR, NORMAL_FONT_COLOR)
        GameTooltip_AddBlankLineToTooltip(GameTooltip)
        if self.data.details then
            GameTooltip_AddNormalLine(GameTooltip, self.data.details)
        end

        GameTooltip_AddInstructionLine(GameTooltip, L["BLIZZARD_MAP_PIN_TOOLTIP"])
        -- TODO: Add coordinates
        GameTooltip:Show()
    end
end

function SoulshapeJournalPinMixin:OnMouseLeave()
    if GameTooltip:GetOwner() == self then
        GameTooltip:Hide()
    end
end

function SJ.UIFactory:CreateDataProviderMixin()
    return CreateFromMixins(SoulshapeJournalDataProviderMixin)
end
