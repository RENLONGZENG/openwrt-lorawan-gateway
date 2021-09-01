module("luci.controller.admin.gateway", package.seeall)

function index()
  local uci = luci.model.uci.cursor()
  local sys = require("luci.sys")
  local board_file = io.open("/etc/board.info", "r")
  if nil == board_file then
    f_board = nil
  else
    f_board = board_file:read("*l")
  end
  local string = string
  entry({"admin", "gateway"}, alias("admin", "gateway", "gateway"), _("Lorawan"), 60).index = true
  if f_board == "MC7628_GAS" then
    entry({"admin", "gateway", "gateway"}, cbi("admin_gateway/MC7628_GAS"), _("Gateway"), 1)
  elseif f_board == "QUECTEL_SX1302" then
    entry({"admin", "gateway", "gateway"}, cbi("admin_gateway/QUECTEL_SX1302"), _("Gateway"), 1)
  end
  entry({"admin", "gateway", "lgwlog"}, template("admin_status/lgwlog"), _("Gateway Statistics"), 20).leaf = true
  entry({"admin", "gateway", "lgwlog_status"}, call("lgwlog_action")).leaf = true
end

function lgwlog_action()
  local gw = require "luci.gw"
  luci.http.prepare_content("application/json")
  luci.http.write("{ statistics: ")
  local data = gw.net.gw_get_data()
  luci.http.write(data[#data])
  luci.http.write(" }")
end
