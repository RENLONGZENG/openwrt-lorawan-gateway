
local m, s, o

m = Map("lwgw", translate("LoRa Gateway Settings"), translate("Configuration to communicate with LoRa devices and LoRaWAN server"))

m:chain("luci")

s = m:section(NamedSection, "general", translate("Gateway Properties"))
s.anonymous = true
s.addremove = false

s:tab("general",  translate("General Settings"))
s:tab("radios",  translate("Radio Settings"))
s:tab("channels", translate("Channels Settings"))

----
---- General Settings
----
o = s:taboption("general", ListValue, "server_type", translate("Type Service"))
o.placeholder = "Select Type service"
o.default = "lorawan"
o:value("disabled",  "Disabled") 
o:value("lorawan",  "LoRaWan Service")        

local sp = s:taboption("general",ListValue, "provider", translate("Service Provider"))
sp.default = "local"
sp:value("remote", "Remote LoRaWAN Server")
sp:value("local", "Local LoRaWAN Server")
sp:value("custom", "--custom--")

o = s:taboption("general", Value, "custom_server", translate("LoraWAN server Address"))
o.optional = true
o.placeholder = "Domain or IP"
o.datatype    = "host"
o:depends("provider", "custom")

o = s:taboption("general", ListValue, "remote_server", translate("Server Address"))
o:depends("provider","remote")
o.default = "223.5.5.5"
o:value("223.5.5.5", "eg-server")

local local_addr = s:taboption("general",ListValue, "local_server",translate("Server Address"))
local_addr:depends("provider","local")
local_addr.default = "127.0.0.1"
local_addr:value("127.0.0.1", "127.0.0.1")

o = s:taboption("general", Value, "upp", translate("Server port for upstream"))
o.optional = true
o.placeholder = "port"
o.datatype    = "port"
o.default = "1700"

o = s:taboption("general", Value, "dpp", translate("Server port for downstream"))
o.optional = true
o.placeholder = "port"
o.datatype    = "port"
o.default = "1700"

o = s:taboption("general", Value, "GWID", translate("Gateway ID"))
o.optional = true
o.placeholder = "GatewayID"
o.datatype = "rangelength(16,16)"

o = s:taboption("general", Value, "stat", translate("Status keepalive in seconds"))
o.optional = true
o.default = "30"
o.placeholder = "seconds"
o.datatype    = "integer"

o = s:taboption("general", ListValue, "interface_type", translate("Hardware Interface Type"))
o.default = "SPI"
o:value("SPI", "SPI")
o:value("USB", "USB")

o = s:taboption("general", Flag, "default_config_enable", translate("Is Use Default Config"))
o.default = 0
o.disable = 0
o.enable = 1

o = s:taboption("general", ListValue, "frequency_band", translate("Frequency Plan"), translate("Frequency Plan Table"))
o.default = "CN490"
o.optional = true
o.placeholder = "Frequency Plan"
o:value("EU868", "Europe 868Mhz(863~870)-- EU868")
o:value("CN490", "China 490MHz -- CN490")
o:value("US", "United States 915Mhz(902~928) -- US915")
o:value("AS923", "Asia 920~923MHz -- AS923")
o:value("CUS", "Customized Bands")

-- o = s:taboption("general", ListValue, "subband", translate("Frequency Sub Band"))
-- o.optional = true
-- o.placeholder = "Frequency Sub Band"
-- o:value("1", "1: US915(902.3~903.7) / AU915(915.2~916.6)")
-- o:value("2", "2: US915(903.9~905.3) / AU915(916.8~918.2)")
-- o:value("3", "3: US915(905.5~906.9) / AU915(918.4~919.8)")
-- o:value("4", "4: US915(907.1~908.5) / AU915(920.0~921.4)")
-- o:value("5", "5: US915(908.7~910.1) / AU915(921.6~923.0)")
-- o:value("6", "6: US915(910.3~911.7) / AU915(923.2~924.6)")
-- o:value("7", "7: US915(911.9~913.3) / AU915(924.8~926.2)")
-- o:value("8", "8: US915(913.5~914.9) / AU915(926.4~927.8)")
-- o:depends("gwcfg", "US")
-- o:depends("gwcfg", "AU")
-- o.default = "2"

-- o = s:taboption("general", Value, "fportnum", translate("Fport Filter"), translate("0~243, 0 means no filter"))
-- o.optional = true
-- o.placeholder = "fport"
-- o.datatype    = "range(0,243)"
-- o.default = "0"

--[[
o = s:taboption("general", Flag, "sx1276", translate("use sx1276 for tx"))
o.optional = true
o.default = 0
o.disable = 0
o.enable = 1

o = s:taboption("general", Value, "sxtxpw", translate("Tx power for SX1276"))
o.default = 0
o.placeholder = "range 5 ~ 20 dBm"
o.datatype = "rangelength(1,2)"
o:depends("sx1276", "1")
--]]

----
---- Radio Settings
----

o = s:taboption("radios", Flag, "radio0_enable", translate("radio 0 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("radios", Value, "radio0_freq", translate("Radio_0 frequency"))
o.optional = true
o.default = 471400000
o.placeholder = "9 digits Frequency, etc:471400000"
o.datatype = "rangelength(9,9)"
o:depends("radio0_enable", "1")

o = s:taboption("radios", Flag, "radio0_tx_enable", translate("Radio_0 for tx"))
o.optional = true
o.default = 1
o.disable = 0
o.enable = 1
o:depends("radio0_enable", "1")

o = s:taboption("radios", Value, "radio0_txfreq_min", translate("Radio_0 tx min frequency"))
o.optional = true
o.default = 500000000
o.placeholder = "9 digits Frequency, etc:500000000"
o.datatype = "rangelength(9,9)"
o:depends("radio0_tx_enable", "1")

o = s:taboption("radios", Value, "radio0_txfreq_max", translate("Radio_0 tx max frequency"))
o.optional = true
o.default = 510000000
o.placeholder = "9 digits Frequency, etc:510000000"
o.datatype = "rangelength(9,9)"
o:depends("radio0_tx_enable", "1")

o = s:taboption("radios", Flag, "radio1_enable", translate("radio 1 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("radios", Value, "radio1_freq", translate("Radio_1 frequency"))
o.optional = true
o.default = 475000000
o.placeholder = "9 digits Frequency, etc:475000000"
o.datatype = "rangelength(9,9)"
o:depends("radio1_enable", "1")

o = s:taboption("radios", Flag, "radio1_tx_enable", translate("Radio_1 for tx"))
o.optional = true
o.default = 0
o.disable = 0
o.enable = 1
o:depends("radio1_enable", "1")

-- o = s:taboption("radios", Value, "radio1_txfreq_min", translate("Radio_1 tx min frequency"))
-- o.optional = true
-- o.placeholder = "9 digits Frequency, etc:868100000"
-- o.datatype = "rangelength(9,9)"
-- o:depends("radio1_tx", "1")

-- o = s:taboption("radios", Value, "radio1_txfreq_max", translate("Radio_1 tx max frequency"))
-- o.optional = true
-- o.placeholder = "9 digits Frequency, etc:868100000"
-- o.datatype = "rangelength(9,9)"
-- o:depends("radio1_tx", "1")

----
---- Channels Settings
----
o = s:taboption("channels", Flag, "chan0_enable", translate("multiSF channel 0 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan0_radio", translate("multiSF channel 0 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("0", "radio0")
o:value("1", "radio1")
o:depends("chan0_enable", "1")

o = s:taboption("channels", Value, "chan0", translate("multiSF channel 0 IF"))
o.optional = true
o.default = -300000
o.placeholder = "bandwidth: -300000"
o:depends("chan0_enable", "1")

o = s:taboption("channels", Flag, "chan1_enable", translate("multiSF channel 1 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan1_radio", translate("multiSF channel 1 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("0", "radio0")
o:value("1", "radio1")
o:depends("chan1_enable", "1")

o = s:taboption("channels", Value, "chan1", translate("multiSF channel 1 IF"))
o.optional = true
o.default = -100000
o.placeholder = "bandwidth: -100000"
o:depends("chan1_enable", "1")

o = s:taboption("channels", Flag, "chan2_enable", translate("multiSF channel 2 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan2_radio", translate("multiSF channel 2 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("0", "radio0")
o:value("1", "radio1")
o:depends("chan2_enable", "1")

o = s:taboption("channels", Value, "chan2", translate("multiSF channel 2 IF"))
o.optional = true
o.default = 100000
o.placeholder = "bandwidth: 100000"
o:depends("chan2_enable", "1")

o = s:taboption("channels", Flag, "chan3_enable", translate("multiSF channel 3 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan3_radio", translate("multiSF channel 3 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("0", "radio0")
o:value("1", "radio1")
o:depends("chan3_enable", "1")

o = s:taboption("channels", Value, "chan3", translate("multiSF channel 3 IF"))
o.optional = true
o.default = 300000
o.placeholder = "bandwidth: 300000"
o:depends("chan3_enable", "1")

o = s:taboption("channels", Flag, "chan4_enable", translate("multiSF channel 4 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan4_radio", translate("multiSF channel 4 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("1", "radio1")
o:value("0", "radio0")
o:depends("chan4_enable", "1")

o = s:taboption("channels", Value, "chan4", translate("multiSF channel 4 IF"))
o.optional = true
o.default = -300000
o.placeholder = "bandwidth: -300000"
o:depends("chan4_enable", "1")

o = s:taboption("channels", Flag, "chan5_enable", translate("multiSF channel 5 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan5_radio", translate("multiSF channel 5 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("1", "radio1")
o:value("0", "radio0")
o:depends("chan5_enable", "1")

o = s:taboption("channels", Value, "chan5", translate("multiSF channel 5 IF"))
o.optional = true
o.default = -100000
o.placeholder = "bandwidth: -100000"
o:depends("chan5_enable", "1")

o = s:taboption("channels", Flag, "chan6_enable", translate("multiSF channel 6 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan6_radio", translate("multiSF channel 6 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("1", "radio1")
o:value("0", "radio0")
o:depends("chan6_enable", "1")

o = s:taboption("channels", Value, "chan6", translate("multiSF channel 6 IF"))
o.optional = true
o.default = -100000
o.placeholder = "bandwidth: -100000"
o:depends("chan6_enable", "1")

o = s:taboption("channels", Flag, "chan7_enable", translate("multiSF channel 7 enable"))
o.default = 1
o.disable = 0
o.enable = 1

o = s:taboption("channels", ListValue, "chan7_radio", translate("multiSF channel 7 radio"))
o.optional = true
o.placeholder = "select radio module"
o:value("1", "radio1")
o:value("0", "radio0")
o:depends("chan7_enable", "1")

o = s:taboption("channels", Value, "chan7", translate("multiSF channel 7 IF"))
o.optional = true
o.default = 300000
o.placeholder = "bandwidth: 300000"
o:depends("chan7_enable", "1")

-- o = s:taboption("channels", Flag, "lorachan_enable", translate("lorastd channel enable"))
-- o.default = 1
-- o.disable = 0
-- o.enable = 1

-- o = s:taboption("channels", ListValue, "lorachan_radio", translate("LoRa channel radio"))
-- o.optional = true
-- o.placeholder = "select radio module"
-- o:value("0", "radio0")
-- o:value("1", "radio1")
-- o:depends("lorachan_enable", "1")

-- o = s:taboption("channels", Value, "lorachan", translate("LoRa channel IF"))
-- o.optional = true
-- o.placeholder = "IF, etc:400000, -400000"
-- o:depends("lorachan_enable", "1")

-- o = s:taboption("channels", Value, "lorachan_sf", translate("LoRa channel SF"))
-- o.optional = true
-- o.placeholder = "SF, 6/7/8/9/10"
-- o.datatype = "uinteger"
-- o:depends("lorachan_enable", "1")

-- o = s:taboption("channels", ListValue, "lorachan_bw", translate("LoRa channel BW"))
-- o.optional = true
-- o.placeholder = "select bandwidth"
-- o:value("125000", "125k")
-- o:value("250000", "250k")
-- o:value("500000", "500k")
-- o:depends("lorachan_enable", "1")

--
-- info
--

local apply = luci.http.formvalue("cbi.apply")
if apply then
  io.popen("/etc/init.d/lwgw_service reload")
end

return m
