fx_version 'cerulean'
game 'gta5'

author 'Aura Development'
description 'Dynamic Duty Blips System According To Duty Count for QBCore and ESX'
version '2.0'

shared_scripts {
    'modules/loader.lua',
    'modules/debug.lua',
    'config.lua',
    'bridge/shared.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'bridge/frameworks/*.lua'
}

lua54 'yes'
