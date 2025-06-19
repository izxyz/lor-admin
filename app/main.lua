require("app.initializer")()

local app = require("lib.lor.index")()
local cjson = require("cjson")
local system = require("app.utils.system")


app:use(require("app.middleware.response"))
app:use(require("app.middleware.auth"))

app:use("/login", require("app.routes.login"))

app:get("/", function(req, res, next)
    -- local db = require("app.utils.db")
    -- local t = {
    --     username = "zhangsan",
    --     password = "123456",
    --     role = 1,
    --     dept = 2,
    --     status = 1,
    -- }

    -- local ret = db.insert("users",t)


    local db = require("app.utils.db")

    local db0 = db()

    local begin = system.time()

    local ret, err, errcode, sqlstate = db0:insert("users", {
        username = tostring(system.time()),
        password = 8888,
        role = 1,
        dept = 2,
        status = 1,
    })

    -- ngx.log(ngx.DEBUG,ret, err, errcode, sqlstate)


    res:json({
        name = "zhangsan"
    })
end)

app:get("/err", function(req, res, next)
    error("主动抛出异常")
end)


app:run()
