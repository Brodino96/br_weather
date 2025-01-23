--------------------- # --------------------- # --------------------- # ---------------------

function IsAllowed(id)
    return IsPlayerAceAllowed(id, "admin")
end

--------------------- # --------------------- # --------------------- # ---------------------

RegisterCommand("tempo", function (source)
    if IsAllowed(source) then
        TriggerClientEvent("br_zoneWeather:openUI", source)
    end
end, false)

--------------------- # --------------------- # --------------------- # ---------------------