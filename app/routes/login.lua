local router = require("lib.lor.index"):Router()

--- 登录
router:post("", function (req,res,next)
    print(req.body.username)
end)

--- 注销
router:delete("", function (req,res,next)
    print(req.body.username)
end)

return router
