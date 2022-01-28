handsFull = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)        
        for i = 1, #Config["Props"] do
            
            local entity = GetClosestObjectOfType(playerCoords, 0.7, GetHashKey(Config["Props"][i]), false, false, false)
            local entityCoords = GetEntityCoords(entity)
            if DoesEntityExist(entity) then

                if handsFull then 
                    --ADD NOTIFICATION HERE IF YOU WANT
                else
                    --COMMENT THIS TO HIDE Strings["Pickup"]
                    DrawText3D(entityCoords + vector3(0.0, 0.0, 1.5), Strings["Pickup"])
                end

                if IsControlJustReleased(0, 38) or IsDisabledControlJustReleased(0, 38) and GetLastInputMethod(0) then
                    if handsFull == false then
                        TakeObjectOnHand(PlayerPedId(), entity)
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
end)


DrawText3D = function(coords, text)
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