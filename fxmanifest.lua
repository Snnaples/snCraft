fx_version "cerulean"
game  'gta5' 

lua54 'TC168'

ui_page 'nui/index.html'

shared_script 'config.lua'

client_scripts { "@vrp/client/Tunnel.lua", "@vrp/client/Proxy.lua", 'client.lua' }

server_scripts { "@vrp/lib/utils.lua", 'server.lua'	}

files { 'nui/styles.css', 'nui/handler.js', 'nui/index.html' } 
