local name, ns = ...

local model = ns.auctionHouseModel
local view = ns.auctionHouseView

local function onAuctionHouseShow()
    if not view:Create() then return end
    view:Hide()
    view:SetResultsText(model:GetResultsText())
    view:SetScanEnabled(true)
end

local function onAuctionHouseClosed()
    view:Hide()
end

local function onScanClicked()
    view:SetScanEnabled(false)
    view:SetResultsText("Scanning all auctions...")

    local ok, err = model:Scan()
    if not ok then
        view:SetResultsText(err)
        view:SetScanEnabled(true)
    end
end

local function onBrowseResultsUpdated()
    if not view.frame or not view.frame:IsShown() then return end

    local ok, err = model:UpdateResults()
    if not ok then
        view:SetResultsText(err)
    else
        view:SetResultsText(model:GetResultsText())
    end
    view:SetScanEnabled(true)
end

ns.bus:RegisterEvent("AUCTION_HOUSE_SHOW", onAuctionHouseShow)
ns.bus:RegisterEvent("AUCTION_HOUSE_CLOSED", onAuctionHouseClosed)
ns.bus:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_UPDATED", onBrowseResultsUpdated)

local originalCreate = view.Create
function view:Create()
    local frame = originalCreate(self)
    if frame and not self.scanHandlerAttached then
        self.scanButton:SetScript("OnClick", onScanClicked)
        self.scanHandlerAttached = true
    end
    return frame
end
