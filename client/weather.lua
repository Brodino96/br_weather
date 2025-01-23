--------------------- # --------------------- # --------------------- # ---------------------

DefaultWeather = Config.defaultWeather ---@type string
local currentWeather = DefaultWeather ---@type string
local lastWeather = DefaultWeather ---@type string

--------------------- # --------------------- # --------------------- # ---------------------
-- Changes the wather to the new one

CreateThread(function()
    while true do
        if lastWeather ~= currentWeather then
            lastWeather = currentWeather
            SetWeatherTypeOvertimePersist(currentWeather, 15.0)
            Wait(15000)
        end
        Wait(100)

        ClearOverrideWeather()
        ClearWeatherTypePersist()

        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)

        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

---@param newWeather string
function ChangeWeather(newWeather)
    currentWeather = newWeather
end

--------------------- # --------------------- # --------------------- # ---------------------

local function updateDefault(weather)
    DefaultWeather = weather

    if PlayerPedId() == 0 or IsPlayerInAZone() then
        return
    end

    if DefaultWeather ~= currentWeather then
        ChangeWeather(DefaultWeather)
    end
end

--------------------- # --------------------- # --------------------- # ---------------------

TriggerServerEvent("br_zoneWeather:requestSync")

RegisterNetEvent("br_zoneWeather:sync")
AddEventHandler("br_zoneWeather:sync", function (allWeathers)
    updateDefault(allWeathers["default"])

    for _, i in pairs(allWeathers.zones) do
        UpdateZone(_, i)
    end
end)

--------------------- # --------------------- # --------------------- # ---------------------