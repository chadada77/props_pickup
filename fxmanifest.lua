fx_version "cerulean"

game "gta5"

author 'chadada77'

description "props_pickup"

version "1.0.0"

client_scripts {
    "@utility_lib/client/native.lua",
    'main.lua'
}

shared_script "config.lua"

dependencies {
    "utility_lib"    
}
