local db = require("lib.classic"):extend()
local mysql = require("resty.mysql")
local configs = require("app.config").mysql
local cjson = require("cjson")

function db:new(config_name)
    self.config = configs[config_name or "default"]
    self.client = assert(mysql:new())
    self.client:set_timeout(self.config.timeout)
end

function db:connect()
    local ok, err, errcode, sqlstate = self.client:connect({
        host = self.config.host,
        port = self.config.port,
        database = self.config.database,
        user = self.config.user,
        password = self.config.password,
        max_packet_size = self.config.max_packet_size,
        charset = self.config.charset
    })
    assert(ok, cjson.encode({
        ok = ok,
        err = err,
        errcode = errcode,
        sqlstate = sqlstate
    }))
end

function db:query(sql, nrows)
    self:connect()
    local _, res, err
    res, err = self.client:query(sql, nrows or 4)
    assert(res, err)
    _, err = self.client:set_keepalive(self.config.pool.timeout, self.config.pool.size)
    if not res then
        pcall(self.client.close, self.client)
        error(err)
    end
    return res
end

function db:parse(sql, ...)
    if not sql or #{ ... } == 0 then
        return sql
    end
    local new_params = {}
    for _, v in ipairs({ ... }) do
        if type(v) == "string" then
            v = ngx.quote_sql_str(v)
        end
        table.insert(new_params, v)
    end
    return string.format(sql, unpack(new_params))
end

function db:insert(table_name, data)
    local fields, values = {}, {}
    for k, v in pairs(data) do
        table.insert(fields, k)
        if type(v) == "string" then
            v = ngx.quote_sql_str(v)
        end
        table.insert(values, v)
    end
    local sql = string.format("INSERT INTO `%s` (%s) VALUES (%s)",
        table_name,
        table.concat(fields, ", "),
        table.concat(values, ", ")
    )
    return self:query(sql)
end

function db:delete(sql, ...)
    sql = self:parse(sql, ...)
    return self:query(sql)
end

function db:update(sql, ...)
    sql = self:parse(sql, ...)
    return self:query(sql)
end

function db:select(sql, ...)
    sql = self:parse(sql, ...)
    return self:query(sql)
end

return db
