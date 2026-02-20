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
