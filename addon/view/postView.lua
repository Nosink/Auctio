local name, ns = ...

local tab = nil;
local frame = nil;

local function createFrame()
    frame = CreateFrame("Frame", name .. "ScanFrame", _G["AuctionFrame"])
    frame:SetPoint("TOPLEFT", _G["AuctionFrame"], "TOPLEFT", 0, -80)
    frame:SetPoint("BOTTOMRIGHT", _G["AuctionFrame"], "BOTTOMRIGHT", 0, 0)
    frame:Hide()
end

local function onAuctionHouseShow(_)
    if tab then return end
    tab = ns.AddTab({
        text = "Post",
        onClick = function()
            print("Post tab clicked")
        end
    })

    createFrame()
end

ns.bus:RegisterEvent(name .. "_AUCTION_HOUSE_SHOW", onAuctionHouseShow)
