local _, ns = ...

local view = {}

local function createResultsScrollFrame(parent)
    local scrollFrame = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 12, -54)
    scrollFrame:SetPoint("BOTTOMRIGHT", -28, 12)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(1, 1)
    scrollFrame:SetScrollChild(content)

    local text = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    text:SetPoint("TOPLEFT", 4, -4)
    text:SetJustifyH("LEFT")
    text:SetJustifyV("TOP")
    text:SetWordWrap(true)

    scrollFrame:SetScript("OnSizeChanged", function(frame)
        content:SetWidth(math.max(frame:GetWidth() - 8, 1))
        text:SetWidth(math.max(content:GetWidth() - 8, 1))
    end)
    return scrollFrame, content, text
end

function view:Create()
    if self.frame then return self.frame end

    local auctionHouseFrame = AuctionHouseFrame
    if not auctionHouseFrame then return nil end

    local tab = CreateFrame("Button", nil, auctionHouseFrame, "UIPanelButtonTemplate")
    tab:SetSize(110, 28)
    tab:SetPoint("TOPLEFT", auctionHouseFrame, "TOPLEFT", 140, -70)
    tab:SetText("Auctio")
    tab:SetScript("OnClick", function()
        self:Show()
    end)

    local frame = CreateFrame("Frame", nil, auctionHouseFrame)
    frame:SetPoint("TOPLEFT", auctionHouseFrame, "TOPLEFT", 12, -100)
    frame:SetPoint("BOTTOMRIGHT", auctionHouseFrame, "BOTTOMRIGHT", -12, 12)
    frame:SetFrameStrata("DIALOG")
    frame:Hide()

    local background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetColorTexture(0.06, 0.06, 0.06, 0.96)

    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 12, -12)
    title:SetText("Auctio")

    local scanButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    scanButton:SetSize(150, 26)
    scanButton:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    scanButton:SetText("Scan all auctions")

    local _, resultsContent, resultsText = createResultsScrollFrame(frame)

    self.frame = frame
    self.tab = tab
    self.scanButton = scanButton
    self.resultsContent = resultsContent
    self.resultsText = resultsText
    return frame
end

function view:SetScanEnabled(enabled)
    self.scanButton:SetEnabled(enabled)
end

function view:SetResultsText(text)
    self.resultsText:SetText(text)
    self.resultsContent:SetHeight(math.max(self.resultsText:GetStringHeight() + 8, 1))
end

function view:Show()
    self.frame:Show()
end

function view:Hide()
    if self.frame then self.frame:Hide() end
end

ns.auctionHouseView = view
