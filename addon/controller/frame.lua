local name, ns = ...

local frame = nil

local function getAuctionFrame()
    return _G["AuctionFrame"]
end

local function onAuctionHouseShow()
    if frame then return end

    frame = getAuctionFrame()
    ns.bus:TriggerEvent(name .. "_AUCTION_HOUSE_SHOW", frame)
end

ns.bus:RegisterEvent("AUCTION_HOUSE_SHOW", onAuctionHouseShow)
