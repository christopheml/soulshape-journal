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

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local NIGHT_FAE = Enum.CovenantType["NightFae"]

local CollectionPanelMixin = {
    selectedSoulshape = nil,
    onSoulshapeChangeCallbacks = {},
}

local function CreateInsets(panel)
    local leftInset = CreateFrame("Frame", "$parentLeftInset", panel, "InsetFrameTemplate")
    leftInset:SetSize(260, 496)
    leftInset:SetPoint("TOPLEFT", 4, -60)
    leftInset:SetPoint("BOTTOMLEFT", 4, 5)

    local rightInset = CreateFrame("Frame", "$parentRightInset", panel, "InsetFrameTemplate")
    rightInset:SetPoint("TOPLEFT", leftInset, "TOPRIGHT", 23, 0)
    rightInset:SetPoint("BOTTOMRIGHT", -6, 5)

    panel.LeftInset = leftInset
    panel.RightInset = rightInset
end

local function CreateCount(panel)
    local countFrame = CreateFrame("Frame", "$parentCount", panel, "InsetFrameTemplate3")
    countFrame:SetSize(130, 20)
    countFrame:SetPoint("TOPLEFT", 70, -35)

    local countNumber = countFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    countNumber:SetText("0")
    countNumber:SetJustifyH("RIGHT")
    countNumber:SetPoint("RIGHT", -10, 0)

    local countLabel = countFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    countLabel:SetText(L["COUNT_LABEL"])
    countLabel:SetJustifyH("LEFT")
    countLabel:SetPoint("LEFT", 10, 0)
    countLabel:SetPoint("RIGHT", countNumber, "LEFT", -3, 0)

    panel.Count = countNumber
end

local function CreateCovenantWarning(panel)
    local warningFrame = CreateFrame("Frame", nil, panel)
    -- This positioning is super ugly, but it does the job, don't do this at home
    warningFrame:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -10, -28)
    warningFrame:SetSize(395, 30)
    local warningLabel = warningFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    warningLabel:SetText(L["WARNING_NOT_NIGHT_FAE"])
    warningLabel:SetJustifyH("LEFT")
    warningLabel:SetAllPoints()
    warningLabel:Hide()

    panel.CovenantWarning = warningLabel
end

local function CreateScrollFrame(panel)

    local ScrollFrameMixin = {}

    function ScrollFrameMixin:ResetButton(button)
        button.name:SetText("")
        button.icon:SetTexture(C_Spell.GetSpellTexture(310143))
        button.critterIcon:Hide()
        button.untrackableAddButton:Hide()
        button.selectedTexture:Hide()
        button.selected = false
        button:SetEnabled(false)
        button.icon:SetAlpha(0.25)
        button.icon:SetDesaturated(true)
        button.name:SetFontObject("GameFontDisable")
    end

    function ScrollFrameMixin:CreateButtons()
        HybridScrollFrame_CreateButtons(self, "SoulshapeListButtonTemplate", 44, 0)
    end

    function ScrollFrameMixin:UpdateButtons()
        local buttons = HybridScrollFrame_GetButtons(self)
        local offset = HybridScrollFrame_GetOffset(self)
        local buttonHeight;

        local filteredItems = SJ.Filters:Filter(SJ.Database.soulshapes)

        for index = 1, #buttons do
            local button = buttons[index]
            local itemIndex = index + offset

            buttonHeight = button:GetHeight()

            if itemIndex <= #filteredItems then
                local item = filteredItems[itemIndex]
                button.name:SetText(item.name)
                button.icon:SetTexture(item.icon)
                button.soulshape = item

                if item.collected then
                    button.icon:SetAlpha(1)
                    button.icon:SetDesaturated(false)
                    button.name:SetFontObject("GameFontNormal")
                    button.background:SetVertexColor(1, 1, 1, 1);
                else
                    button.icon:SetAlpha(0.25)
                    button.icon:SetDesaturated(true)
                    button.name:SetFontObject("GameFontDisable")
                end

                button.critterIcon:SetShown(item.critter)
                button.untrackableAddButton:SetShown(not item.collected and item.untrackable)

                button.selected = panel.selectedSoulshape == item
                button.selectedTexture:SetShown(button.selected)

                button:SetEnabled(true)
            else
                self:ResetButton(button)
            end
        end

        HybridScrollFrame_Update(self, #filteredItems * buttonHeight, self:GetHeight())
    end

    local scrollFrame = Mixin(CreateFrame("ScrollFrame", "$parentScrollFrame", panel, "HybridScrollFrameTemplate"), ScrollFrameMixin)
    scrollFrame:SetPoint("TOPLEFT", panel.LeftInset, "TOPLEFT", 3, -36)
    scrollFrame:SetPoint("BOTTOMRIGHT", panel.LeftInset, "BOTTOMRIGHT", -3, 5)
    scrollFrame.items = SJ.Database.soulshapes

    local scrollBar = CreateFrame("Slider", "$parentScrollBar", scrollFrame, "HybridScrollBarTemplate")
    scrollBar:SetPoint("TOPLEFT", panel.LeftInset, "TOPRIGHT", 1, -16)
    scrollBar:SetPoint("BOTTOMLEFT", panel.LeftInset, "BOTTOMRIGHT", 1, 16)
    scrollBar.doNotHide = true

    scrollFrame.ScrollBar = scrollBar

    scrollFrame:CreateButtons()
    scrollFrame.update = scrollFrame.UpdateButtons

    panel.ScrollFrame = scrollFrame
end

local function CreateModelView(panel)
    local soulshapeDisplay = CreateFrame("Frame", nil, panel)
    soulshapeDisplay:SetPoint("TOPLEFT", panel.RightInset, "TOPLEFT", 3, -3)
    soulshapeDisplay:SetPoint("BOTTOMRIGHT", panel.RightInset, "BOTTOMRIGHT", -3, 3)

    local background = soulshapeDisplay:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetTexture("Interface/CovenantChoice/CovenantChoiceOfferingsNightFae")
    background:SetTexCoord(0.0434117648, 0.3608851102, 0.427734375, 0.8486328125)

    local shadow = CreateFrame("Frame", nil, soulshapeDisplay, "ShadowOverlayTemplate")
    shadow:Lower()
    shadow:SetAllPoints()

    local soulshapeInfo = CreateFrame("Frame", nil, soulshapeDisplay)
    soulshapeInfo:SetPoint("TOPLEFT", 20, -20)
    soulshapeInfo:SetPoint("BOTTOMRIGHT", -20, 20)

    -- FIXME: extract this
    local bannerLeft = soulshapeInfo:CreateTexture(nil, "ARTWORK")
    bannerLeft:SetPoint("TOPLEFT", 0, 5)
    bannerLeft:SetAtlas("UI-Frame-NightFae-TitleLeft", false)
    bannerLeft:SetSize(100, 42)

    local bannerRight = soulshapeInfo:CreateTexture(nil, "ARTWORK")
    bannerRight:SetPoint("TOPRIGHT", soulshapeInfo, "TOPRIGHT", 0, 5)
    bannerRight:SetAtlas("UI-Frame-NightFae-TitleRight", false)
    bannerRight:SetSize(100, 42)

    local bannerMid = soulshapeInfo:CreateTexture(nil, "ARTWORK")
    bannerMid:SetPoint("TOPLEFT", bannerLeft, "TOPRIGHT")
    bannerMid:SetPoint("BOTTOMRIGHT", bannerRight, "BOTTOMLEFT")
    bannerMid:SetAtlas("_UI-Frame-NightFae-TitleMiddle", false)

    local infoName = soulshapeInfo:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge2")
    infoName:SetPoint("TOPLEFT", 0, 0)
    infoName:SetPoint("TOPRIGHT", 0, 0)
    infoName:SetSize(0, 35)
    infoName:SetJustifyH("CENTER")
    panel.Name = infoName

    local infoSource = soulshapeInfo:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
    infoSource:SetJustifyH("LEFT")
    infoSource:SetPoint("TOPLEFT", infoName, "BOTTOMLEFT", 20, -10)
    infoSource:SetPoint("TOPRIGHT", infoName, "BOTTOMRIGHT", -20, -10)
    infoSource:SetWordWrap(true)
    panel.Source = infoSource

    local infoGuide = soulshapeInfo:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoGuide:SetJustifyH("LEFT")
    infoGuide:SetPoint("TOPLEFT", infoSource, "BOTTOMLEFT", 0, -5)
    infoGuide:SetPoint("TOPRIGHT", infoSource, "BOTTOMRIGHT", 0, -5)
    infoGuide:SetWordWrap(true)
    panel.Guide = infoGuide

    local modelScene = CreateFrame("ModelScene", nil, soulshapeDisplay, "WrappedAndUnwrappedModelScene")
    modelScene:Lower()
    modelScene:SetPoint("TOPLEFT", 0, -80)
    modelScene:SetPoint("BOTTOMRIGHT", 0, 40)
    modelScene.RotateLeftButton = CreateFrame("Button", nil, modelScene, "RotateOrbitCameraLeftButtonTemplate")
    modelScene.RotateLeftButton:SetPoint("TOPRIGHT", modelScene, "BOTTOM", -5, 20)
    modelScene.RotateRightButton = CreateFrame("Button", nil, modelScene, "RotateOrbitCameraRightButtonTemplate")
    modelScene.RotateRightButton:SetPoint("TOPLEFT", modelScene, "BOTTOM", 5, 20)
    modelScene:Hide()

    soulshapeDisplay.ModelScene = modelScene

    panel.SoulshapeDisplay = soulshapeDisplay
end

local function CreateSearchBox(panel)
    local editBox = CreateFrame("EditBox", nil, panel, "SearchBoxTemplate")
    editBox:SetSize(145, 20)
    editBox:SetPoint("TOPLEFT", panel.LeftInset, 15, -9)
    editBox.letters = 40
    editBox:SetScript("OnTextChanged", function(self)
        SearchBoxTemplate_OnTextChanged(self)
        SJ.Filters:SetTextFilter(self:GetText())
        panel.ScrollFrame:UpdateButtons()
    end)
    editBox:SetScript("OnHide", function(self)
        self:SetText("")
    end)
end

local function CreateTab(panel)
    local tab = LibStub('SecureTabs-2.0'):Add(CollectionsJournal)
    tab:SetText(L["TAB_TITLE"])
    tab.frame = panel

    tab.OnSelect = function()
        -- Some addons aren't aware that we exist and won't hide themselves correctly when
        -- we show up. We'll circumvent this by telling the UI we're selecting another tab
        -- from the CollectionsJournal immediately before switching to ours, which causes
        -- those addons to hide themselves gracefully.
        -- The chosen tab is the Heirlooms Journal because we don't expect any popular
        -- addon to modify its frame. If it's the case, well, we're screwed.
        -- If you read this and you have a better technique to attach tabs to the
        -- collection journal, please message me.
        CollectionsJournal_SetTab(CollectionsJournal, CollectionsJournalTab4:GetID())
    end

    panel.Tab = tab
end

function CollectionPanelMixin:UpdateSoulshapeDisplay()
    local scene = self.SoulshapeDisplay.ModelScene

    local function showModel(creatureDisplayID, scale, modelSceneID, animation)
        scene:SetFromModelSceneID(modelSceneID, true, false)
        local actor = scene:GetActorByTag("unwrapped")
        if actor then
            actor:SetModelByCreatureDisplayID(creatureDisplayID)
            if scale then
                actor:SetRequestedScale(scale)
            end
            if animation then
                actor:SetAnimation(animation, 0)
            end
        end
        scene:Show()
    end

    local function enableUserControls(enabled)
        scene.RotateLeftButton:SetShown(enabled)
        scene.RotateRightButton:SetShown(enabled)
        scene:EnableMouse(enabled)
        scene:EnableMouseWheel(enabled)
    end

    local soulshape = self.selectedSoulshape
    if soulshape then
        enableUserControls(true)
        self.Name:SetText(soulshape.name)
        self.Source:SetText(soulshape.source)
        self.Guide:SetText(soulshape.guide)
        showModel(soulshape.model, soulshape.scale, soulshape.modelSceneID or 44)
    else
        -- Default display
        enableUserControls(false)
        self.Name:SetText(L["Soulshape Journal"])
        -- Running Vulpine!
        showModel(93949, 4, 4, 5)
    end
end

function CollectionPanelMixin:ShowUntrackableTooltip(addButton)
    local soulshape = addButton:GetParent().soulshape
    GameTooltip:SetOwner(addButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine(string.format("|A:services-icon-warning:16:16|a |cFFFFFFFF%s|r", L["UNTRACKABLE_TOOLTIP_TITLE"]))
    GameTooltip:AddLine(string.format(L["UNTRACKABLE_TOOLTIP_CLICK_ME"], NIGHT_FAE_BLUE_COLOR:WrapTextInColorCode(soulshape.name)))
    GameTooltip:Show()
end

function CollectionPanelMixin:UpdateCount()
    self.Count:SetText(SJ.Database:CountCollected() .. "/" .. SJ.Database:CountTotal())
end

function CollectionPanelMixin:UpdateCovenantWarning()
    local covenant = C_Covenants.GetActiveCovenantID()
    self.CovenantWarning:SetShown(covenant ~= NIGHT_FAE)
end

function CollectionPanelMixin:OnButtonClick(button)
    self.selectedSoulshape = button.soulshape
    self:UpdateSoulshapeDisplay()

    -- FIXME: move this to callbacks
    self.ScrollFrame:UpdateButtons()

    -- callbacks for other components
    self:SoulshapeChanged(button.soulshape)
end

--- Callback signature: callback(soulshape)
function CollectionPanelMixin:OnSoulshapeChange(callback)
    tinsert(self.onSoulshapeChangeCallbacks, callback)
end

function CollectionPanelMixin:SoulshapeChanged(soulshape)
    --SJ:Print("Panel:SoulshapeChanged")
    for _, callback in ipairs(self.onSoulshapeChangeCallbacks) do
        callback(soulshape)
    end
end

--- FIXME Remove this
function CollectionPanelMixin:GetSelectedSoulshape()
    return self.selectedSoulshape
end

function CollectionPanelMixin:AddUntrackableToCollection(addButton)
    local soulshape = addButton:GetParent().soulshape
    if SJ.Database:AddUntrackable(soulshape) then
        self:Update()
    end
end

-- Called when journal is shown
function CollectionPanelMixin:Update()
    SJ.Database:Update()
    self.ScrollFrame:UpdateButtons()
    self:UpdateSoulshapeDisplay()
    self:UpdateCount()
    self:UpdateCovenantWarning()
end

function SJ:CreateCollectionPanel()
    local panel = Mixin(CreateFrame("Frame", "SoulshapeCollectionPanel", CollectionsJournal, "PortraitFrameTemplate"), CollectionPanelMixin)
    panel:Hide()
    panel:SetAllPoints()
    panel:SetPortraitToAsset(C_Spell.GetSpellTexture(310143))
    panel:SetTitle(L["TAB_TITLE"])

    SJ.Panel = panel

    CreateInsets(panel)
    CreateCount(panel)
    CreateCovenantWarning(panel)
    CreateScrollFrame(panel)
    CreateModelView(panel)
    CreateSearchBox(panel)
    SJ.UIFactory:CreateFilterDropDown(panel)

    -- Map
    panel.Map = SJ.UIFactory:CreateMap(panel, panel.RightInset)
    panel:OnSoulshapeChange(function(soulshape)
        panel.Map:OnSoulshapeChange(soulshape)
    end)

    CreateTab(panel)

    panel:SetScript("OnShow", function(self)
        self:Update()
    end)
end

function SJ:GetSelectedSoulshape()
    return self.Panel:GetSelectedSoulshape()
end
