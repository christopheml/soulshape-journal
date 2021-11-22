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

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local CollectionPanelMixin = {
    selectedSoulshape = nil
}

function CollectionPanelMixin:CreateCount()
    local countFrame = CreateFrame("Frame", "$parentCount", self, "InsetFrameTemplate3")
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

    self.Count = countNumber
end

function CollectionPanelMixin:CreateInsets()
    local leftInset = CreateFrame("Frame", "$parentLeftInset", self, "InsetFrameTemplate")
    leftInset:SetSize(260, 496)
    leftInset:SetPoint("TOPLEFT", 4, -60)
    leftInset:SetPoint("BOTTOMLEFT", 4, 5)

    local rightInset = CreateFrame("Frame", "$parentRightInset", self, "InsetFrameTemplate")
    rightInset:SetPoint("TOPLEFT", leftInset, "TOPRIGHT", 23, 0)
    rightInset:SetPoint("BOTTOMRIGHT", -6, 5)

    self.LeftInset = leftInset
    self.RightInset = rightInset
end

function CollectionPanelMixin:CreateModelView()
    local soulshapeDisplay = CreateFrame("Frame", nil, self)
    soulshapeDisplay:SetPoint("TOPLEFT", self.RightInset, "TOPLEFT", 3, -3)
    soulshapeDisplay:SetPoint("BOTTOMRIGHT", self.RightInset, "BOTTOMRIGHT", -3, 3)

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

    local infoName = soulshapeInfo:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    infoName:SetPoint("TOPLEFT", 0, 0)
    infoName:SetPoint("TOPRIGHT", 0, 0)
    infoName:SetSize(0, 35)
    infoName:SetJustifyH("CENTER")
    self.Name = infoName

    local infoSource = soulshapeInfo:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    infoSource:SetJustifyH("LEFT")
    infoSource:SetPoint("TOPLEFT", infoName, "BOTTOMLEFT", 20, -10)
    infoSource:SetPoint("TOPRIGHT", infoName, "BOTTOMRIGHT", -20, -10)
    infoSource:SetWordWrap(true)
    self.Source = infoSource

    local infoGuide = soulshapeInfo:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoGuide:SetJustifyH("LEFT")
    infoGuide:SetPoint("TOPLEFT", infoSource, "BOTTOMLEFT", 0, -5)
    infoGuide:SetPoint("TOPRIGHT", infoSource, "BOTTOMRIGHT", 0, -5)
    infoGuide:SetWordWrap(true)
    self.Guide = infoGuide

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

    self.SoulshapeDisplay = soulshapeDisplay
end

function CollectionPanelMixin:UpdateSoulshapeDisplay()
    local soulshape = self.selectedSoulshape
    if soulshape then
        self.Name:SetText(soulshape.name)
        self.Source:SetText(soulshape.source)
        self.Guide:SetText(soulshape.guide)

        local scene = self.SoulshapeDisplay.ModelScene
        if soulshape.model then
            local modelSceneID = 4
            scene:TransitionToModelSceneID(modelSceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_MAINTAIN, true)
            local actor = scene:GetActorByTag("unwrapped")
            if actor then
                actor:SetModelByCreatureDisplayID(soulshape.model)
                if soulshape.scale then
                    actor:SetRequestedScale(soulshape.scale)
                end
            end
            local camera = scene:GetActiveCamera()
            scene:Show()
        else
            C_ModelInfo.ClearActiveModelScene(scene)
            scene:Hide()
        end
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
    self.Count:SetText(SC.Database:CountCollected() .. "/" .. SC.Database:CountTotal())
end

function CollectionPanelMixin:CreateTab()
    local tab = LibStub('SecureTabs-2.0'):Add(CollectionsJournal)
    tab:SetText(L["TAB_TITLE"])
    tab.frame = self

    tab.OnSelect = function()
        if _G["RematchJournal"] then
            -- Rematch isn't aware that we exist and won't hide iteself correctly when
            -- we show up. We'll circumvent this by telling the UI we're selecting the 
            -- first real tab of the CollectionsJournal immediately before switching to
            -- ours, which causes Rematch to hide itself.
            CollectionsJournal_SetTab(CollectionsJournal, CollectionsJournalTab1:GetID())
        end
    end

    self.Tab = tab
end

function CollectionPanelMixin:OnButtonClick(button)
    self.selectedSoulshape = button.soulshape
    self:UpdateSoulshapeDisplay()
    self.ScrollFrame:UpdateButtons()
end

function CollectionPanelMixin:AddUntrackableToCollection(addButton)
    local soulshape = addButton:GetParent().soulshape
    if SC.Database:AddUntrackable(soulshape) then
        self:Update()
    end
end

function CollectionPanelMixin:CreateScrollFrame()

    local panel = self

    local ScrollFrameMixin = {}

    function ScrollFrameMixin:CreateButtons()
        HybridScrollFrame_CreateButtons(self, "SoulshapeListButtonTemplate", 44, 0)
        local buttons = HybridScrollFrame_GetButtons(self)
        
        for index = 1, #buttons do
            local button = buttons[index]
            button.index = index
            button.name:SetText("")
			button.icon:SetTexture(GetSpellTexture(310143))
            button.soulshape = item
        end
    end

    function ScrollFrameMixin:UpdateButtons()
        local buttons = HybridScrollFrame_GetButtons(self)
        local offset = HybridScrollFrame_GetOffset(self)
        local buttonHeight;

        for index = 1, #buttons do
            local button = buttons[index]
            local itemIndex = index + offset
    
            buttonHeight = button:GetHeight()
    
            if itemIndex <= #self.items then
                local item = self.items[itemIndex]
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

                button.untrackableAddButton:SetShown(not item.collected and item.untrackable)

                if panel.selectedSoulshape == item then
                    button.selected = true;
                    button.selectedTexture:Show();
                else
                    button.selected = false;
                    button.selectedTexture:Hide();
                end

                button:SetEnabled(true)
            end
        end
    
        HybridScrollFrame_Update(self, #self.items * buttonHeight, self:GetHeight())
    end

    local scrollFrame = Mixin(CreateFrame("ScrollFrame", "$parentScrollFrame", self, "HybridScrollFrameTemplate"), ScrollFrameMixin)
    scrollFrame:SetPoint("TOPLEFT", self.LeftInset, "TOPLEFT", 3, -5)
    scrollFrame:SetPoint("BOTTOMRIGHT", self.LeftInset, "BOTTOMRIGHT", -3, 5)
    scrollFrame.items = SC.Database.soulshapes

    local scrollBar = CreateFrame("Slider", "$parentScrollBar", scrollFrame, "HybridScrollBarTemplate")
    scrollBar:SetPoint("TOPLEFT", self.LeftInset, "TOPRIGHT", 1, -16)
    scrollBar:SetPoint("BOTTOMLEFT", self.LeftInset, "BOTTOMRIGHT", 1, 16)
    scrollBar.doNotHide = true

    scrollFrame.ScrollBar = scrollBar

    scrollFrame:CreateButtons()
    scrollFrame.update = scrollFrame.UpdateButtons

    self.ScrollFrame = scrollFrame
end

function CollectionPanelMixin:Update()
    SC.Database:Update()
    self.ScrollFrame:UpdateButtons()
    self:UpdateSoulshapeDisplay()
    self:UpdateCount()
end

function SC:CreateCollectionPanel()
    local panel = Mixin(CreateFrame("Frame", "SoulshapeCollectionPanel", CollectionsJournal, "PortraitFrameTemplate"), CollectionPanelMixin)
    panel:Hide()
    panel:SetAllPoints()
    panel:SetPortraitToAsset(GetSpellTexture(310143))
    panel:SetTitle(L["TAB_TITLE"])
    
    panel:CreateInsets()
    panel:CreateCount()
    panel:CreateScrollFrame()
    panel:CreateTab()
    panel:CreateModelView()

    panel:SetScript("OnShow", function(self)
        self:Update()
    end)

    SC.Panel = panel
end
