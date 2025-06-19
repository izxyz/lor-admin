local config = require("app.config")
local anonymous = config.anonymous

return function(req, res, next)
    local path = req.path
    for _, v in ipairs(anonymous) do
        if string.match(path, v) then
            next()
            return
        end
    end
    next()
end
