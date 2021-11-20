--[[
Copyright 2013-2021 João Cardoso
SecureTabs is distributed under the terms of the GNU General Public License (or the Lesser GPL).
This file is part of SecureTabs.

SecureTabs is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

SecureTabs is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with SecureTabs. If not, see <http://www.gnu.org/licenses/>.
--]]

local Lib, old = LibStub:NewLibrary('SecureTabs-2.0', 2)
if not Lib then
	return
elseif not old then
	hooksecurefunc('PanelTemplates_SetTab', function(panel, id)
		Lib:Update(panel)
	end)
end

Lib.tabs = Lib.tabs or {}
Lib.covers = Lib.covers or {}


--[[ Main API ]]--

function Lib:Add(panel, frame, label)
	local secureTabs = self.tabs[panel] or {}
	local id = #secureTabs
	local anchor = id > 0 and 'SecureTab' .. (id-1) or 'Tab' .. panel.numTabs

	local tab = CreateFrame('Button', '$parentSecureTab' .. id, panel, 'CharacterFrameTabButtonTemplate')
	tab:SetPoint('LEFT', panel:GetName() .. anchor, 'RIGHT', -16, 0)
	tab:SetScript('OnClick', function(tab) self:Select(tab) end)
	tab:SetText(label)
	tab.frame = frame
	tinsert(secureTabs, tab)
	PanelTemplates_DeselectTab(tab)

	local cover = self.covers[panel] or CreateFrame('Button', '$parentCoverTab', panel, 'CharacterFrameTabButtonTemplate')
	cover:SetScript('OnClick', function(tab) self:Uncover(panel) end)
	PanelTemplates_DeselectTab(cover)

	self.tabs[panel] = secureTabs
	self.covers[panel] = cover

	return tab
end

function Lib:Select(tab)
	if tab.OnSelect then
		tab:OnSelect()
	end

	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
	self:Update(tab:GetParent(), tab)
end


--[[ Advanced Methods ]]--

function Lib:Uncover(panel)
	PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
	self:Update(panel)
end

function Lib:Update(panel, selection)
	local secureTabs = self.tabs[panel]
	if not secureTabs then
		return
	end

	for i, tab in ipairs(secureTabs) do
		local selected = tab == selection
		if selected then
			PanelTemplates_SelectTab(tab)
		else
			PanelTemplates_DeselectTab(tab)
		end

		local frame = tab.frame
		if frame then
			frame:SetShown(selected)

			if selected then
				frame:SetParent(panel)
				frame:EnableMouse(true)
				frame:SetAllPoints(true)
				frame:SetFrameLevel(panel:GetFrameLevel() + 20)

				if frame.CloseButton then -- this could cause taint, must solve?
					frame.CloseButton:SetScript('OnClick',  function() panel:Hide() end)
				end
			end
		end
	end

	if panel.selectedTab then
		local cover = self.covers[panel]
		local tab = _G[panel:GetName() .. 'Tab'.. panel.selectedTab]

		local tabname = tab:GetName()
		local leftDisabled = tab.LeftDisabled or _G[tabname..'LeftDisabled']
		local middleDisabled = tab.MiddleDisabled or _G[tabname..'MiddleDisabled']
		local rightDisabled = tab.RightDisabled or _G[tabname..'RightDisabled']

		cover:SetShown(selection)
		leftDisabled:SetShown(not selection)
		middleDisabled:SetShown(not selection)
		rightDisabled:SetShown(not selection)

 		if selection then
			cover:SetParent(tab)
			cover:SetAllPoints(tab)
			cover:SetText(tab:GetText())
			PanelTemplates_TabResize(cover, 0, nil, 36, panel.maxTabWidth or 88)
		end
	end
end
