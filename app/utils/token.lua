local _M = {}

local expires = require("app.config").expires
local uuid = require("resty.jit-uuid")

local token = ngx.shared.token

function _M.login(id)
    token:flush_expired()
    local authorization = uuid()
    token:set(authorization, id, expires)
    return authorization
end

function _M.logout(authorization)
    token:flush_expired()
    token:delete(authorization)
end

function _M.authenticated(authorization)
    token:flush_expired()
    return token:get(authorization) ~= nil
end

function _M.get(authorization)
    token:flush_expired()
    return token:get(authorization)
end

return _M
