local name, ns = ...

local tab = nil;
local panel = nil;

local auctionPanels = {
    "AuctionFrameBrowse",
    "AuctionFrameBid",
    "AuctionFrameAuctions",
    "AuctionFramePost",
}

local function getTabName(frame, tabID)
    return frame:GetName() .. "Tab" .. tabID
end

local function getTab(frame, tabID)
    return _G[getTabName(frame, tabID)]
end

local function setAuctionPanelsShown(shown)
    for _, panelName in ipairs(auctionPanels) do
        local auctionPanel = _G[panelName]
        if auctionPanel then
            auctionPanel:SetShown(shown)
        end
    end
end

local function showPanel()
    setAuctionPanelsShown(false)
    panel:Show()
end

local function hidePanel()
    if panel then
        panel:Hide()
    end
end

local function updateNumTabs(frame)
    frame.numTabs = frame.numTabs + 1
    PanelTemplates_SetNumTabs(frame, frame.numTabs)
end

local function hookExistingTabs(frame)
    for index = 1, frame.numTabs - 1 do
        local auctionTab = getTab(frame, index)
        if auctionTab then
            auctionTab:HookScript("OnClick", hidePanel)
        end
    end
end

local function onTabClick(self, frame)
    PanelTemplates_SetTab(frame, self:GetID())
    showPanel()
end

local function createTab(frame)
    local previousTab = getTab(frame, frame.numTabs - 1)

    tab = CreateFrame("Button", getTabName(frame, frame.numTabs), frame, "CharacterFrameTabButtonTemplate")
    tab:SetID(frame.numTabs)
    tab:SetText(name .. " Scan")
    tab:SetPoint("TOPLEFT", previousTab, "TOPRIGHT", -8, 0)
    tab:SetScript("OnClick", function(self)
        onTabClick(self, frame)
    end)
    PanelTemplates_TabResize(tab, 0, 110, 110, 110, 0)
end

local function createPanel(frame)
    panel = CreateFrame("Frame", name .. "Panel", frame)
    panel:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -80)
    panel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)
    panel:Hide()
end

local function onButtonClick()
    print("clicked")
end

local function createButton()
    local button = CreateFrame("Button", name .. "Button", panel, "UIPanelButtonTemplate")
    button:SetText(name)
    button:SetSize(120, 30)
    button:SetPoint("CENTER")
    button:SetScript("OnClick", onButtonClick)
end

local function onAuctionHouseShow(_, frame)
    if tab then return end
    updateNumTabs(frame)

    hookExistingTabs(frame)
    createTab(frame)

    createPanel(frame)
    createButton()
end

ns.bus:RegisterEvent(name .. "_AUCTION_HOUSE_SHOW", onAuctionHouseShow)
