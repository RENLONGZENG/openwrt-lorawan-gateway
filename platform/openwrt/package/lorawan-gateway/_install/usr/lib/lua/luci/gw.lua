local fs = require "nixio.fs"
local io = require "io"

module "luci.gw"

net = {}

function net.gw_get_data()
    local connt = {}
    if fs.access("/var/log/lorawan_gateway/gw_js_data.log", "r") then
        for line in io.lines("/var/log/lorawan_gateway/gw_js_data.log") do
            connt[#connt + 1] = line
        end
    end
    return connt
end
