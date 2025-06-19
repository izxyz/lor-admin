local _M = {}

--- 是否包含指定角色
---@param roles integer
---@param role_id integer 
---@return boolean
function _M.has(roles, role_id)
    if roles and role_id then
        return bit.band(roles, bit.lshift(1, role_id)) ~= 0
    end
    return false
end

--- 添加角色
---@param roles integer
---@param role_id integer
---@return integer
function _M.add(roles, role_id)
    return bit.bor(roles or 0, bit.lshift(1, role_id))
end

--- 删除角色
---@param roles integer
---@param role_id integer
function _M.delete(roles, role_id)
    if roles and role_id then
        return bit.band(roles, bit.bnot(bit.lshift(1, role_id)))
    end
    return false
end

return _M
