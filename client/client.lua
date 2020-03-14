--
-- Script Forked From StarBlazt - https://github.com/StarBlazt/SB-policesystems
-- User: Spike Scarlatti
-- Date: 14-03-20
-- Time: 11:41
--

local ESX

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

-- FUNCTIONS
function canSpawnModel(vehicleName)
    for iVehicle = 1, #Config.AllowedVehicles do
        if vehicleName == Config.AllowedVehicles[iVehicle] then
            return true
        end
    end

    return false
end

function jobIsAllowed()
    return ESX.PlayerData.job.name == 'police'
end

-- COMMANDS
RegisterCommand('sv', function(source, args, user)
    local vehicleName = tostring(args[1])

    if not jobIsAllowed() or vehicleName == nil or not canSpawnModel(vehicleName) then
        return
    else
        local playerPed = PlayerPedId()

        ESX.Game.SpawnVehicle(GetHashKey(vehicleName), GetOffsetFromEntityInWorldCoords(playerPed, 1.5, 6.0, 2.0), GetEntityHeading(playerPed), function(vehicle)

        end)
    end
end)

RegisterCommand('impound', function(source)
    if jobIsAllowed() then
        TriggerEvent('impoundVeh', source)
    end
end)

-- EVENTS
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
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
        }, function()
        end)

        Citizen.Wait(1500)

        ESX.Game.DeleteVehicle(vehicle)
    end
end)


