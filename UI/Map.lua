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

local _, SJ = ...

local SoulshapeMapNavigationMixin = { }

function SoulshapeMapNavigationMixin:OnLoad()
    UIDropDownMenu_SetWidth(self, 130)
end

function SoulshapeMapNavigationMixin:Refresh()
    local map = self:GetParent()
    if map.soulshape and map.soulshape.maps and #map.soulshape.maps > 1 then
        local mapID = map:GetMapID()
        UIDropDownMenu_Initialize(self, self.InitializeDropDown)
        UIDropDownMenu_SetSelectedValue(self, mapID)
        self:Show()
    else
        self:Hide()
    end
end

function SoulshapeMapNavigationMixin:InitializeDropDown()
    local map = self:GetParent()
    local mapID = map:GetMapID()
    if not map.soulshape or not map.soulshape.maps then
        return
    end
    local function GoToMap(button)
        map:SetMapID(button.value)
        self:Refresh()
    end
    local info = UIDropDownMenu_CreateInfo();
    for _, mapInfo in ipairs(map.soulshape.maps) do
        info.text = mapInfo[2]
        info.value = mapInfo[1]
        info.func = GoToMap;
        info.checked = (mapID == mapInfo.mapID)
        UIDropDownMenu_AddButton(info)
    end
end

local SoulshapeMapMixin = {
    pins = {}
}

function SoulshapeMapMixin:OnShow()
    MapCanvasMixin.OnShow(self)
    DoEmote("READ", nil, true)
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

function SoulshapeMapMixin:OnHide()
    MapCanvasMixin.OnHide(self)
    self.mapButton:SetButtonState("NORMAL")
    CancelEmote()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
end

function SoulshapeMapMixin:Setup()
    self:SetScript("OnEvent", self.OnEvent)
    self:SetScript("OnUpdate", self.OnUpdate)
    self:SetScript("OnShow", self.OnShow)
    self:SetScript("OnHide", self.OnHide)
end

function SoulshapeMapMixin:GetMapID()
    -- Blizzard's implementation makes sure to never return nil and will return the mapID of the
    -- area the player currently is. We don't need this, and this avoids a bug if the first map
    -- a Soulshape Journal's user is opening is the map of the current area.
    return self.mapID
end

function SoulshapeMapMixin:OnSoulshapeChange(soulshape)
    local maps = soulshape.maps

    if not maps then
        -- No map to display, hide the map
        self:Hide()
        self.mapButton:Hide()
        self.soulshape = nil
    else
        self.soulshape = soulshape
        -- display the first map by default
        local oldMapID = self:GetMapID()
        local newMapID = maps[1][1]
        if oldMapID ~= newMapID then
            self:SetMapID(newMapID)
        else
            -- Force refresh of map pins without redrawing everything
            self:OnMapChanged()
        end

        self.NavigationDropDownFrame:Refresh()
        self.mapButton:Show()
    end
end

function SoulshapeMapMixin:SetMapButton(button)
    self.mapButton = button
    button:SetMap(self)
end

function SoulshapeMapMixin:SetTitle(title)
    self.TitleText:SetText(title)
end

local function CreateMapButton(parent)
    local MapButtonMixin = { }

    function MapButtonMixin:SetMap(map)
        self:SetScript("OnClick", function(self)
            local shown = not map:IsShown()
            map:SetShown(shown)
            self:SetButtonState(shown and "PUSHED" or "NORMAL", shown)
        end)
    end

    local button = Mixin(CreateFrame("Button", nil, parent), MapButtonMixin)
    button:SetSize(48, 32)
    button:SetFrameStrata("DIALOG")
    button:Hide()

    local baseTexture = button:CreateTexture(nil, "ARTWORK", nil, 1)
    baseTexture:SetTexture("Interface/QuestFrame/UI-QuestMap_Button")
    baseTexture:SetTexCoord(0.125, 0.875, 0.0, 0.5)
    baseTexture:SetAllPoints()
    button:SetNormalTexture(baseTexture)

    local pushedTexture = button:CreateTexture(nil, "ARTWORK", nil, 1)
    pushedTexture:SetTexture("Interface/QuestFrame/UI-QuestMap_Button")
    pushedTexture:SetTexCoord(0.125, 0.875, 0.5, 1.0)
    baseTexture:SetAllPoints()
    button:SetPushedTexture(pushedTexture)

    local highlightTexture = button:CreateTexture(nil, "HIGHLIGHT")
    highlightTexture:SetTexture("Interface/BUTTONS/ButtonHilight-Square")
    highlightTexture:SetSize(36, 25)
    highlightTexture:SetPoint("RIGHT", -7, 0)
    button:SetHighlightTexture(highlightTexture)

    button:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 10)
    return button
end

local function CreateCloseButton(parent)
    local closeButton = CreateFrame("Button", nil, parent, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 5.6, 5)
    return closeButton
end

local function CreateScrollFrame(parent)
    local scrollFrame = CreateFrame("ScrollFrame", nil, parent, "MapCanvasFrameScrollContainerTemplate")
    scrollFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 1, -19)

    -- This little shit of 2 pixels prevents the map from clipping outside of the frame corners
    -- A texture mask could probably work too, but this is way easier.
    scrollFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -2, 2)
    return scrollFrame
end

local function CreateBorderFrame(parent)
    local borderFrame = CreateFrame("Frame", nil, parent, "DefaultPanelTemplate")
    borderFrame:SetAllPoints()
    return borderFrame
end

local function CreateNavigationDropDownFrame(parent)
    local dropDownFrame = Mixin(CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate"), SoulshapeMapNavigationMixin)
    dropDownFrame:SetFrameStrata("DIALOG")
    dropDownFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", -5, -29)
    dropDownFrame:OnLoad()
    return dropDownFrame
end

local function CreateMap(parent)
    local map = Mixin(CreateFrame("Frame", nil, parent, "DefaultPanelTemplate"), MapCanvasMixin, SoulshapeMapMixin)
    map:Setup()
    map:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT")
    -- Ratio that makes the map fit just fine
    map:SetSize(570, 400)
    map:Hide()

    map.CloseButton = CreateCloseButton(map)
    map.BorderFrame = CreateBorderFrame(map)
    map.ScrollContainer = CreateScrollFrame(map)
    map.NavigationDropDownFrame = CreateNavigationDropDownFrame(map)

    map:OnLoad()

    map:AddDataProvider(CreateFromMixins(MapExplorationDataProviderMixin))
    map:AddDataProvider(SJ.UIFactory:CreateDataProviderMixin())

    local pinFrameLevelsManager = map:GetPinFrameLevelsManager()
    pinFrameLevelsManager:AddFrameLevel(SJ.FrameLevelType)

    map:SetShouldZoomInstantly(true)

    return map
end

function SJ.UIFactory:CreateMap(parent, buttonParent)
    local map = CreateMap(parent)
    local mapButton = CreateMapButton(buttonParent)

    map:SetMapButton(mapButton)

    return map
end
