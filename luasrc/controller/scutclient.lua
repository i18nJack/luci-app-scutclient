--[[
                 _       _ _            _   
  ___  ___ _   _| |_ ___| (_) ___ _ __ | |_ 
 / __|/ __| | | | __/ __| | |/ _ \ '_ \| __|
 \__ \ (__| |_| | || (__| | |  __/ | | | |_ 
 |___/\___|\__,_|\__\___|_|_|\___|_| |_|\__|
                                            
--]]

module("luci.controller.scutclient", package.seeall)

http = require "luci.http"
fs = require "nixio.fs"
sys  = require "luci.sys"

log_file = "/tmp/scutclient.log"
log_file_backup = "/tmp/scutclient.log.backup.log"

function index()
	if not fs.access("/etc/config/scutclient") then
		return
	end
	local uci = require "luci.model.uci".cursor()
    
    entry({"admin", "network", "scutclient"},
        alias("admin", "network", "scutclient", "status"), "华工无线", 0
    )

    entry({"admin", "network", "scutclient", "status"},
        call("action_status"), "状态", 10
    ).leaf = true

    entry({"admin", "network", "scutclient", "settings"},
        cbi("scutclient/scutclient"), "设置", 20
    ).leaf = true
    
	entry({"admin", "network", "scutclient", "logs"}, 
        template("scutclient/logs"), "日志", 30
    ).leaf = true
    
    entry({"admin", "network", "scutclient", "about"}, 
        call("action_about"), "关于", 40
    ).leaf = true
	
    entry({"admin", "network", "scutclient", "get_log"}, call("get_log"))
	entry({"admin", "network", "scutclient", "netstat"}, call("get_netstat"))
end


function get_log()
	if fs.access(log_file) then
		client_log = sys.exec("tail -n 60 " .. log_file)
	else
		client_log = "Unable to access the log file!"
	end

	http.prepare_content("text/plain; charset=gbk")
	http.write(client_log)
	http.close()
end

function action_status()
	luci.template.render("scutclient/status")
	if luci.http.formvalue("logoff") == "1" then
		luci.sys.call("/etc/init.d/scutclient stop > /dev/null")
	end
	if luci.http.formvalue("redial") == "1" then
		luci.sys.call("/etc/init.d/scutclient stop > /dev/null")
		luci.sys.call("/etc/init.d/scutclient start > /dev/null")
	end
end

function action_about()
	luci.template.render("scutclient/about")
end

function get_netstat()
	local hcontent = sys.exec("wget -O- http://whatismyip.akamai.com 2>/dev/null | head -n1")
	local nstat = {}
	if hcontent == '' then
		nstat.stat = 'no_internet'
	elseif hcontent:find("(%d+)%.(%d+)%.(%d+)%.(%d+)") then
		nstat.stat = 'internet'
	else
		nstat.stat = 'no_login'
	end
	http.prepare_content("application/json")
	http.write_json(nstat)
	http.close()
end
