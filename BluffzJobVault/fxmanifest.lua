--####################################################################################
--#                                   DISCORD:                                       #
--#                                Mr Bluffz#0001                                    #
--####################################################################################

fx_version 'cerulean'
game 'gta5'

author 'Matt Bluffz'
description "Making progress. This thing doesn't break!"
version '0.1.0'

client_scripts {
    '@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
    '@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'config.lua',
	'server/server.lua'
}

dependency 'es_extended'