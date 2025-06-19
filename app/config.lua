return {
    anonymous = {
        "^/login",
        "^/captcha"
    },
    mysql = {
        ["default"] = {
            host = "127.0.0.1",
            port = 3306,
            database = "lor-admin",
            user = "root",
            password = "",
            max_packet_size = 1024 * 1024 * 4,
            charset = "utf8mb4",

            timeout = 1000,

            pool = {
                name = "lor-admin",
                size = 100,
                timeout = 10 * 1000
            }
        }
    },
    rsa = {
        private_key =
        "MIIBUwIBADANBgkqhkiG9w0BAQEFAASCAT0wggE5AgEAAkEA0vfvyTdGJkdbHkB8mp0f3FE0GYP3AYPaJF7jUd1M0XxFSE2ceK3k2kw20YvQ09NJKk+OMjWQl9WitG9pB6tSCQIDAQABAkA2SimBrWC2/wvauBuYqjCFwLvYiRYqZKThUS3MZlebXJiLB+Ue/gUifAAKIg1avttUZsHBHrop4qfJCwAI0+YRAiEA+W3NK/RaXtnRqmoUUkb59zsZUBLpvZgQPfj1MhyHDz0CIQDYhsAhPJ3mgS64NbUZmGWuuNKp5coY2GIj/zYDMJp6vQIgUueLFXv/eZ1ekgz2Oi67MNCk5jeTF2BurZqNLR3MSmUCIFT3Q6uHMtsB9Eha4u7hS31tj1UWE+D+ADzp59MGnoftAiBeHT7gDMuqeJHPL4b+kC+gzV4FGTfhR9q3tTbklZkD2A=="
    },
    expires = 60 * 60,
    authorization = "authorization"
}
