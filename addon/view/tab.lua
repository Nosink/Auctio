local name, ns = ...


local function createTab()
    local tab = CreateFrame("Button", name .. "_Tab", AuctionFrame, "AuctionFrameTabTemplate")
    tab:SetText(ns.L["TAB_TITLE"])
    tab:SetID(3)
    tab:ClearAllPoints()
    tab:SetPoint("LEFT", _G[name .. "_Tab2"], "RIGHT", -15, 0)
    PanelTemplates_TabResize(tab, 0)
    PanelTemplates_DeselectTab(tab)
    return tab
end

local function onTabClick()
    AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopLeft")
    AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Top")
    AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopRight")
    AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotLeft")
    AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-Bot")
    AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight")

    ns.bus:TriggerEvent(name .. "_TAB_CLICKED")
end

local function onTabShow()
    if (AuctionFrame.selectedTab == 3) then
        onTabClick()
    end
end

ns.bus:RegisterEvent(name .. "_AUCTION_HOUSE_SHOW", function()
    local tab = _G[name .. "_Tab"]
    if (not tab) then
        tab = createTab()
        tab:SetScript("OnClick", onTabClick)
        tab:SetScript("OnShow", onTabShow)
    end
end)
