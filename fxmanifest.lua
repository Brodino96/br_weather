fx_version "cerulean"
game "gta5"
lua54 "yes"

author "Brodino"
description "Clima a zone"

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua",
}

server_scripts {
    "server/*",
}

client_scripts {
    "@PolyZone/client.lua",
    "client/*",
}