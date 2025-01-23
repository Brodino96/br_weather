--------------------- # --------------------- # --------------------- # ---------------------

local function openUI()

    local options = {}

    options[1] = {
        title = "Default",
        description = "Weather attuale ["..DefaultWeather.."]",
        onSelect = function ()
            OpenSelector("default")
        end
    }

    for _, i in pairs(Config.zones) do
        options[#options+1] = {
            title = _,
            description = "Weather attuale ["..i.weather.."]",
            onSelect = function ()
                OpenSelector(_)
            end
        }
    end

    lib.registerContext({
        id = "zoneWeather_main",
        title = "Zone Weather",
        canClose = true,
        options = options
    })

    lib.showContext("zoneWeather_main")
end

function OpenSelector(zone)

    local options = {}

    for i = 1, #Config.weatherTypes do

        local time = Config.weatherTypes[i]

        options[#options+1] = {
            title = time,
            onSelect = function ()

                local alert = lib.alertDialog({
                    header = "ATTENZIONE",
                    content = "Sei sicuro di voler impostare ["..time.."] come nuovo weather per la zona ["..zone.."]?",
                    centered = true,
                    cancel = true,
                    labels = {
                        confirm = "Sono sicuro",
                        cancel = "Ci ripenso"
                    }
                })

                if alert == "confirm" then
                    TriggerServerEvent("br_zoneWeather:updateWeather", zone, time)
                else
                    lib.showContext("zoneWeather_selector")
                end
            end
        }
    end

    lib.registerContext({
        id = "zoneWeather_selector",
        title = "Seleziona weather",
        canClose = true,
        onExit = function ()
            openUI()
        end,
        onBack = function ()
            openUI()
        end,
        options = options
    })

    lib.showContext("zoneWeather_selector")
end

--------------------- # --------------------- # --------------------- # ---------------------

RegisterNetEvent("br_zoneWeather:openUI")
AddEventHandler("br_zoneWeather:openUI", openUI)

--------------------- # --------------------- # --------------------- # ---------------------