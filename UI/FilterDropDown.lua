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

local _, SJ = ...

SJ.UIFactory = SJ.UIFactory or { }

local function InitializeFilterDropDown(_, level, menuList)

    local function CreateFilter(filter)
        local info = UIDropDownMenu_CreateInfo()
        info.text = filter.label
        info.checked = filter.enabled
        info.isNotRadio = true
        info.keepShownOnClick = true
        info.func = function(_, _, _, checked)
            SJ.Filters:SetFilter(filter, checked)
            SJ.Panel.ScrollFrame:UpdateButtons()
        end
        UIDropDownMenu_AddButton(info, level)
    end

    local function CreateFilterGroupLabel(text)
        local info = UIDropDownMenu_CreateInfo()
        info.isTitle = true
        info.text = text
        info.notCheckable = true
        UIDropDownMenu_AddButton(info, level)
    end

    local function CreateSubMenu(text, filters)
        local info = UIDropDownMenu_CreateInfo()
        info.hasArrow = true
        info.notCheckable = true
        info.text = text
        info.menuList = filters
        UIDropDownMenu_AddButton(info, level)
    end

    if level == 1 then
        local insertSpace = false
        for _, filterGroup in ipairs(SJ.Filters:GetFilters()) do
            if insertSpace then
                UIDropDownMenu_AddSpace(level)
                insertSpace = false
            end

            if filterGroup.subMenu then
                CreateSubMenu(filterGroup.label, filterGroup.filters)
            else
                if filterGroup.label then
                    CreateFilterGroupLabel(filterGroup.label)
                end

                for _, filter in ipairs(filterGroup.filters) do
                    CreateFilter(filter)
                end
                insertSpace = true
            end
        end
    elseif menuList then
        for _, filter in ipairs(menuList) do
            CreateFilter(filter)
        end
    end
end

function SJ.UIFactory:CreateFilterDropDown(panel)
    local dropDownMenu = CreateFrame("FRAME", nil, panel, "UIDropDownMenuTemplate")
    UIDropDownMenu_Initialize(dropDownMenu, InitializeFilterDropDown, "MENU")

    local dropDownButton = CreateFrame("DropDownToggleButton", nil, panel, "UIMenuButtonStretchTemplate")
    dropDownButton:SetText(FILTER)
    dropDownButton:SetSize(93, 22)
    dropDownButton:SetPoint("TOPRIGHT", panel.LeftInset, -5, -9)

    local arrow = dropDownButton:CreateTexture(nil, "ARTWORK")
    arrow:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")
    arrow:SetSize(10, 12)
    arrow:SetPoint("RIGHT", dropDownButton, "RIGHT", -5, 0)

    dropDownButton:SetScript("OnMouseDown", function(sender, mouseButton)
        UIMenuButtonStretchMixin.OnMouseDown(sender, mouseButton)
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        ToggleDropDownMenu(1, nil, dropDownMenu, dropDownButton, 74, 15)
    end)

end
