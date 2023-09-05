require("rider.v2")

local envoy = envoy

local exampleHandler = {}

exampleHandler.version = "v2"

function exampleHandler:on_request_header()
    local err, msg = envoy.socket.tcp()
    if err then
        envoy.logErr(msg)
        return
    end
    envoy.socket.connect("180.97.34.94", 80)
    err, msg = envoy.socket.send("GET / HTTP/1.1\r\nHost: www.baidu.com\r\n\r\n")
    if err then
        envoy.logErr(msg)
        return
    end
    local res = ""
    local expected_len = 10240
    while true do
        local err, msg, data = envoy.socket.recv()
        if err then
            envoy.logErr(msg)
            return
        else
            res = res .. data
        end
        envoy.logInfo(res)
        if #res >= expected_len then
            break
        end
    end
end

return exampleHandler
