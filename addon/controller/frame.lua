local name, ns = ...

local function onAuctionHouseShow()
    ns.bus:TriggerEvent(name .. "_AUCTION_HOUSE_SHOW")
end

ns.bus:RegisterEvent("AUCTION_HOUSE_SHOW", onAuctionHouseShow)
