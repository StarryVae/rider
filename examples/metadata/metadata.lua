require("rider.v2")

local envoy = envoy

local MetadataHandler = {}

MetadataHandler.version = "v2"

function MetadataHandler:on_request_header()
  envoy.req.set_dynamic_metadata("foo", "bar", "dynamic.metadata.test")

  local cluster_metadata = envoy.req.get_cluster_metadata("foo", "cluster.metadata.test")
  if (cluster_metadata == nil) then
      envoy.logErr("no cluster metadata value for cluster.metadata.test!")
      return
  end
  envoy.logInfo("cluster metadata value: "..cluster_metadata)
end

function MetadataHandler:on_response_header()
    local value = envoy.req.get_dynamic_metadata("foo", "dynamic.metadata.test")
    if (value == nil) then
        envoy.logErr("no dynamic metadata value for dynamic.metadata.test!")
        return
    end
    envoy.logInfo("dynamic metadata value: "..value)

    local host_metadata = envoy.req.get_upstream_host_metadata("foo", "host.metadata.test")
    if (host_metadata == nil) then
        envoy.logErr("no host metadata value for host.metadata.test!")
        return
    end
    envoy.logInfo("host metadata value: "..host_metadata)
end

return MetadataHandler
