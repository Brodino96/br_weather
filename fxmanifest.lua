fx_version "cerulean"
game "gta5"
lua54 "yes"

author "Brodino"
description "Dynamic zone weather for FiveM"
version "1.0"

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

dependencies {
    "ox_lib",
    "PolyZone",
}