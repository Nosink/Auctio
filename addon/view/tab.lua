local name, ns = ...

local tab = {}
local frame = { numTabs = 0, selectedTab = 1, }

local function getAuctionFrame()
    return _G["AuctionFrame"]
end

local function setNumTabs()
    frame.numTabs = frame.numTabs + 1
    PanelTemplates_SetNumTabs(frame, frame.numTabs)
end


local function createTab()
    local tabName = frame:GetName() .. "Tab" .. frame.numTabs
    local previousTab = _G[frame:GetName() .. "Tab" .. frame.numTabs - 1]

    tab = CreateFrame("Button", tabName, frame, "CharacterFrameTabButtonTemplate", frame.numTabs)
    tab:SetPoint("TOPLEFT", previousTab, "TOPRIGHT", -8, 0)
end

local function setText(params)
    local text = params.text or (name .. " Tab")
    tab:SetText(text)
end

local function tabResize()
    local width = PanelTemplates_GetTabWidth(tab)
    PanelTemplates_TabResize(tab, 0, width, 0, 0, 0)
end

local function setOnClick(params)
    tab:SetScript("OnClick", function(self)
        PanelTemplates_SetTab(frame, self:GetID())
        if params.onClick then
            params.onClick()
        end
    end)
end

local function setTab()
    PanelTemplates_SetTab(frame, frame.selectedTab or 1)
end

function ns.AddTab(params)
    frame = getAuctionFrame()

    setNumTabs()
    createTab()
    setText(params)
    tabResize()
    setOnClick(params)
    setTab()

    return tab
end
