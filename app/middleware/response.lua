local time = require("app.utils.system").time
local uuid = require("resty.jit-uuid")

return function(req, res, next)
    local _json = res.json
    res.json = function(self, data, empty_table_as_object)
        if type(data) == "table" then
            data.timestamp = time()
            if not data.uuid then
                data.uuid = uuid()
            end
        end
        _json(self, data, empty_table_as_object)
    end
    next()
end
