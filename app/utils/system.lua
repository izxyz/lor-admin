---@diagnostic disable: undefined-field
local _M = {}

local ffi = require("ffi")
local jit = require("jit")

local is_windows = jit.os == "Windows"


if is_windows then
    ffi.cdef [[
        typedef struct _FILETIME {
            unsigned long dwLowDateTime;
            unsigned long dwHighDateTime;
        } FILETIME;
        
        void GetSystemTimeAsFileTime(FILETIME* lpSystemTimeAsFileTime);
    ]]
else
    ffi.cdef [[
        typedef struct timeval {
            long tv_sec;
            long tv_usec;
        } timeval;
        
        int gettimeofday(struct timeval *tv, void *tz);
    ]]
end

function _M.time()
    if is_windows then
        local ft = ffi.new("FILETIME")
        ffi.C.GetSystemTimeAsFileTime(ft)
        -- Windows文件时间是从1601年开始的100纳秒间隔数
        -- 需要转换为Unix时间戳（从1970年开始的毫秒数）
        local WINDOWS_TICK = 10000000 -- 100纳秒到秒
        local SEC_TO_UNIX_EPOCH = 11644473600 -- 1601年到1970年的秒数
        local ft_time = (tonumber(ft.dwHighDateTime) * 2^32 + tonumber(ft.dwLowDateTime))
        local unix_time = (ft_time / WINDOWS_TICK - SEC_TO_UNIX_EPOCH) * 1000
        return math.floor(unix_time)
    else
        local tv = ffi.new("timeval")
        ffi.C.gettimeofday(tv, nil)
        return tonumber(tv.tv_sec * 1000 + tv.tv_usec / 1000)
    end
end

return _M
