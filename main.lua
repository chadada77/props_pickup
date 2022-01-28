local lastEntity = 0
CreateLoop(function(loopId)
    local playerPed = PlayerPedId()
    lastEntity = 0

    if not IsPedInAnyVehicle(playerPed, true) and not IsPedDeadOrDying(playerPed) and GetOnHandObject() == 0 then
        for i = 1, #Config["Props"] do
            local playerCoords = GetEntityCoords(playerPed)
            local entity = GetClosestObjectOfType(playerCoords, 1.5, GetHashKey(Config["Props"][i]))
            
            if entity ~= 0 then
                lastEntity = entity
                CreateMarker("props_pickup", GetEntityCoords(entity) + vector3(0.0, 0.0, 1.0), 1.0, 1.0, Strings["Pickup"])
            end
        end

        if lastEntity == 0 then
            DeleteMarker("props_pickup")
        end
    end
end, 1000)

IsControlJustPressed("E", function()    
    local playerPed = PlayerPedId()
    local onhand = GetOnHandObject()

    if onhand == 0 then
        if lastEntity ~= 0 then
            TakeObjectOnHand(playerPed, lastEntity)
            DeleteMarker("props_pickup")
        end
    else
        DropObjectFromHand(onhand, false)
        CreateMarker("props_pickup", GetEntityCoords(onhand) + vector3(0.0, 0.0, 1.0), 1.0, 1.0, Strings["Pickup"])
    end
end)
