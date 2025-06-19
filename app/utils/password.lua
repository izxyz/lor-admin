local _M = {}

local pkey = require("resty.openssl.pkey")

local bcrypt = require("jit").os == 'Windows' and require("lua-bcrypt") or require("bcrypt")

local private_key = require("app.config").rsa.private_key

--- 解密前端传来的密码
---@param text string 前端传来的经过rsa公钥加密过的密码
---@return string,string 解密后的密码，错误信息
function _M.decrypt(text)
    local decode_private_key = ngx.decode_base64(private_key)
    local decode_text = ngx.decode_base64(text)

    local obj_pkey, err = pkey.new(decode_private_key)
    return obj_pkey:decrypt(decode_text)
end

--- 验证密码
---@param raw string 明文密码字符串
---@param cipher string bcrypt加密过的密文密码字符串
---@return boolean
function _M.verify(raw, cipher)
    return bcrypt.verify(raw, cipher)
end

--- 加密密码
---@param raw string 明文密码字符串
---@return string bcrypt加密过的密文密码字符串
function _M.digest(raw)
    return bcrypt.digest(raw)
end

return _M
