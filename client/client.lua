ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('VehSpawn')
AddEventHandler('VehSpawn', function(vehicle)

	local model = GetHashKey('CHGR')
	local playerPed = PlayerPedId()
	local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)

	ESX.Game.SpawnVehicle(model, coords + 3, heading, function(vehicle)
	end)

end)


RegisterCommand('sv', function(source, args, user)
	if PlayerData.job.name == 'police' then

		if tostring(args[1]) == nil then
			return
		else
			if tostring(args[1]) ~= nil then
				local argh = tostring(args[1])

				if argh == '1' then
					local model = GetHashKey(Config.VehList[1])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '2' then
					local model = GetHashKey(Config.VehList[2])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '3' then
					local model = GetHashKey(Config.VehList[3])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '4' then
					local model = GetHashKey(Config.VehList[4])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '5' then
					local model = GetHashKey(Config.VehList[5])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '6' then
					local model = GetHashKey(Config.VehList[6])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '7' then
					local model = GetHashKey(Config.VehList[7])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 6.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '8' then -- Boat
					local model = GetHashKey(Config.VehList[8])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 2.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				elseif argh == '9' then -- Heli
					local model = GetHashKey(Config.VehList[9])
					local playerPed = PlayerPedId()
					local coords    = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 10.0, 1.0)
					local heading = GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
					end)
				end
			end
		end

	end
end)




RegisterCommand('impound', function(source)
	if PlayerData.job.name == 'police' then

		TriggerEvent('impoundVeh', source)
	end
end)




RegisterNetEvent('impoundVeh')
AddEventHandler('impoundVeh', function()

	local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0


	while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(vehicle)
		attempt = attempt + 1
	end

	if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
		TriggerEvent("mythic_progressbar:client:progress", {
        name = "Impounding",
        duration = 1500,
        label = "Impounding Vehicle",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        },
		}, function(status)
			if not status then
				-- Do Something If Event Wasn't Cancelled
			end
	end)
		Citizen.Wait(1500)
		ESX.Game.DeleteVehicle(vehicle)
	end
end)
