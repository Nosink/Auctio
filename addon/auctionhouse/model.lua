local _, ns = ...

local model = {
    results = nil,
}

local function valueToText(value, indent, seen)
    local valueType = type(value)
    if valueType ~= "table" then
        return tostring(value)
    end

    if seen[value] then
        return "<recursive>"
    end
    seen[value] = true

    local keys = {}
    for key in pairs(value) do
        keys[#keys + 1] = key
    end
    table.sort(keys, function(left, right)
        return tostring(left) < tostring(right)
    end)

    local lines = { "{" }
    for _, key in ipairs(keys) do
        lines[#lines + 1] = string.rep(" ", indent + 2) ..
            tostring(key) .. " = " .. valueToText(value[key], indent + 2, seen)
    end
    lines[#lines + 1] = string.rep(" ", indent) .. "}"
    seen[value] = nil
    return table.concat(lines, "\n")
end

function model:Scan()
    if not C_AuctionHouse or not C_AuctionHouse.SendBrowseQuery then
        return false, "The Auction House scan API is unavailable."
    end

    self.results = nil
    C_AuctionHouse.SendBrowseQuery({
        searchString = "",
        sorts = {},
        filters = {},
    })
    return true
end

function model:UpdateResults()
    if not C_AuctionHouse or not C_AuctionHouse.GetBrowseResults then
        return false, "The Auction House results API is unavailable."
    end

    self.results = C_AuctionHouse.GetBrowseResults()
    return true
end

function model:GetResultsText()
    if not self.results then
        return "Scan results will appear here."
    end

    return valueToText(self.results, 0, {})
end

ns.auctionHouseModel = model
