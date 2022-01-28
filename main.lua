local isDead, inVehicle = nil, nil

local function DrawText3D(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 45, 45, 45, 150)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        isDead = IsPedDeadOrDying(playerPed)
        inVehicle = IsPedInAnyVehicle(playerPed, true)
        Citizen.Wait(1500)
    end
end)

Citizen.CreateThread(function()
    local handsFull = false
    while true do
        local wait = 1550
        if not inVehicle and not isDead then
            local playerPed = PlayerPedId()
            for i = 1, #Config["Props"] do
                local playerCoords = GetEntityCoords(playerPed) 
                local entity = GetClosestObjectOfType(playerCoords, 0.7, GetHashKey(Config["Props"][i]), false, false, false)
                if DoesEntityExist(entity) then
                    wait = 5

                    if handsFull then 
                        --ADD NOTIFICATION HERE IF YOU WANT
                    else
                        --COMMENT THIS TO HIDE Strings["Pickup"]
                        local entityCoords = GetEntityCoords(entity)
                        DrawText3D(entityCoords + vector3(0.0, 0.0, 1.5), Strings["Pickup"])
                    end

                    if IsControlJustReleased(0, 38) or IsDisabledControlJustReleased(0, 38) and GetLastInputMethod(0) then
                        if handsFull == false then
                            TakeObjectOnHand(playerPed, entity)
                            handsFull = true

                        else
                            DropObjectFromHand(entity, false)
                            Citizen.Wait(10)
                            handsFull = false
                        end

                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)
