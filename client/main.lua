--------------------- # --------------------- # --------------------- # ---------------------

local allZones = {}

--------------------- # --------------------- # --------------------- # ---------------------

---@param isInside boolean If the player entered the zone
---@param name string The name of the zone
local function positionUpdated(isInside, name)
    if not isInside then
        ChangeWeather(DefaultWeather)
    else
        ChangeWeather(Config.zones[name].weather)
    end
end

--------------------- # --------------------- # --------------------- # ---------------------

local function createZones()

    if #allZones > 0 then
        return
    end

    for _, i in pairs(Config.zones) do
        local currentZone = PolyZone:Create(
            i.coords, {
                name = _,
                minZ = i.z.min,
                maxZ = i.z.max,
                debugGrid = Config.debugMode,
                debugColors = {
                    walls = { 242, 7, 219 },
                    grid = { 153, 11, 139 }
                }
            }
        )

        currentZone:onPlayerInOut(function (isInside)
            positionUpdated(isInside, _)
        end)

        allZones[_] = currentZone
    end
end

--------------------- # --------------------- # --------------------- # ---------------------

function IsPlayerInAZone()
    local pCoords = GetEntityCoords(PlayerPedId()) ---@type vector3
    for _, i in pairs(allZones) do
        if i:isPointInside(pCoords) then
            return true
        end
    end
    return false
end

--------------------- # --------------------- # --------------------- # ---------------------

function UpdateZone(zone, newWeather)
    Config.zones[zone].weather = newWeather

    if PlayerPedId() == 0 then
        return
    end

    if not allZones[zone]:isPointInside(GetEntityCoords(PlayerPedId())) then
        return
    end

    ChangeWeather(Config.zones[zone].weather)
end

--------------------- # --------------------- # --------------------- # ---------------------

RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", createZones)

RegisterNetEvent("onResourceStart")
AddEventHandler("onResourceStart", function (name)
    if name ~= GetCurrentResourceName() or not PlayerPedId() then
        return
    end
    createZones()
end)

--------------------- # --------------------- # --------------------- # ---------------------