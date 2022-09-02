require("rider.v2")

local envoy = envoy

local networkHandler = {}

networkHandler.version = "v2"

function networkHandler:on_new_connection()
end

function networkHandler:on_data()
    local downstream_data = envoy.get_downstream_data()
    if downstream_data ~= nil then
        envoy.logInfo("downstream_data: "..downstream_data);
    end
end

function networkHandler:on_write()
    local upstream_data = envoy.get_upstream_data()
    if upstream_data ~= nil then
        envoy.logInfo("upstream_data: "..upstream_data);
    end
end

return networkHandler
