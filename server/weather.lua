--------------------- # --------------------- # --------------------- # ---------------------

local allWeathers = {}

allWeathers["default"] = Config.defaultWeather
allWeathers["zones"] = {}

for _, i in pairs(Config.zones) do
    allWeathers["zones"][_] = i.weather
end

--------------------- # --------------------- # --------------------- # ---------------------

function UpdateWeather(zone, weather)
    if zone == "default" then
        allWeathers["default"] = weather
    else
        allWeathers["zones"][zone] = weather
    end

    TriggerClientEvent("br_zoneWeather:sync", -1, allWeathers)
end

--------------------- # --------------------- # --------------------- # ---------------------

RegisterNetEvent("br_zoneWeather:requestSync")
AddEventHandler("br_zoneWeather:requestSync", function ()
    TriggerClientEvent("br_zoneWeather:sync", source, allWeathers)
end)

RegisterNetEvent("br_zoneWeather:updateWeather")
AddEventHandler("br_zoneWeather:updateWeather", function (zone, weather)
    if IsAllowed(source) then
        UpdateWeather(zone, weather)
    end
end)

--------------------- # --------------------- # --------------------- # ---------------------