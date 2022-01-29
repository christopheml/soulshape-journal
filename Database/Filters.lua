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

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME, true)

local function matchBuild(targetBuild)
    return function(soulshape)
        return soulshape.buildNumber == targetBuild
    end
end

local filters = {
    {
        label = nil,
        filters = {
            {
                label = COLLECTED,
                enabled = true,
                func = function(soulshape)
                    return soulshape.collected
                end
            },
            {
                label = NOT_COLLECTED,
                enabled = true,
                func = function(soulshape)
                    return not soulshape.collected
                end
            }
        }
    },
    {
        label = TYPE,
        filters = {
            {
                label = L["Soulshape"],
                enabled = true,
                func = function(soulshape)
                    return not soulshape.critter
                end
            },
            {
                label = L["Crittershape"],
                enabled = true,
                func = function(soulshape)
                    return soulshape.critter or false
                end
            }
        }
    },
    {
        label = L["Available since"],
        filters = {
            {
                label = "9.0",
                enabled = true,
                func = matchBuild(SJ.BUILD_9_0)
            },
            {
                label = "9.0.5",
                enabled = true,
                func = matchBuild(SJ.BUILD_9_0_5)
            },
            {
                label = "9.1",
                enabled = true,
                func = matchBuild(SJ.BUILD_9_1)
            },
            {
                label = "9.1.5",
                enabled = true,
                func = matchBuild(SJ.BUILD_9_1_5)
            }
        }
    }
}

local function AllFiltersEnabled()
    for _, filterGroup in ipairs(filters) do
        for _, filter in ipairs(filterGroup.filters) do
            if not filter.enabled then
                return false
            end
        end
    end
    return true
end

local function IsRetained(soulshape)
    local isShown = true
    for _, filterGroup in ipairs(filters) do
        local isShownForGroup = true
        for _, filter in ipairs(filterGroup.filters) do
            if filter.func(soulshape) then
                isShownForGroup = isShownForGroup and filter.enabled
            end
        end
        isShown = isShown and isShownForGroup
    end
    return isShown
end

SJ.Filters = {
    textFilter = nil
}

function SJ.Filters:SetTextFilter(textFilter)
    self.textFilter = textFilter
end

function SJ.Filters:SetFilter(filter, value)
    filter.enabled = value
end

function SJ.Filters:GetFilters()
    return filters
end

function SJ.Filters:Filter(soulshapes)
    if (self.textFilter == nil or self.textFilter == "") and AllFiltersEnabled() then
        -- No filtering active, do nothing
        return soulshapes
    end

    local filteredSoulshapes = {}
    for _, soulshape in ipairs(soulshapes) do
        local isShown = false

        -- Dropdown filters
        isShown = isShown or IsRetained(soulshape)

        -- Text filter
        if self.textFilter and self.textFilter ~= "" then
            isShown = isShown and soulshape.searchText:find(self.textFilter:lower(), 1, true)
        end

        if isShown then
            tinsert(filteredSoulshapes, soulshape)
        end
    end
    return filteredSoulshapes
end
