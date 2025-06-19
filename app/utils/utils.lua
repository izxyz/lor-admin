local _M = {}

function _M.is_array(t)
    if type(t) ~= "table" then return false end
    local n = #t
    for k, v in pairs(t) do
        if type(k) ~= "number" or k > n or k < 1 then
            return false
        end
    end
    return true
end

return _M
