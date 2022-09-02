require("rider.v2")

local envoy = envoy

local exampleHandler = {}

exampleHandler.version = "v2"

function exampleHandler:on_request_header()
    local status, body = envoy.grpcCall(
      "web_service",
      "hello.HelloService",
      "SayHello",
      {
      },
      "",
      5000)
    envoy.logInfo("response status: "..status)
    envoy.logInfo("response message: "..body)
end

return exampleHandler
