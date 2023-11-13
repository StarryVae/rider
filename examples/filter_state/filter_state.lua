require("rider.v2")

local envoy = envoy

local FilterStateHandler = {}

FilterStateHandler.version = "v2"

function FilterStateHandler:on_request_header()
  envoy.req.set_string_filter_state("foo", "bar", state_type.StateTypeReadOnly, life_span.LifeSpanRequest, stream_sharing.SharedWithUpstreamConnection)
  local value = envoy.req.get_string_filter_state("foo")
  if (value == nil) then
    envoy.logErr("no filter state value")
    return
  end
  envoy.logInfo("filter state value: "..value)
end

function FilterStateHandler:on_response_header()

end

return FilterStateHandler
