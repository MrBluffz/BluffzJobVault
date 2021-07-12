ESX = nil
local createdVaults = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	for k,v in pairs(Config.Vaults) do
		if v.ShowBlip then
		    local blip = AddBlipForCoord(v.coords)
		    SetBlipSprite (blip, v.Type)
		    SetBlipScale  (blip, v.Size)
		    SetBlipColour (blip, v.Color)
		    SetBlipAsShortRange(blip, true)
		    BeginTextCommandSetBlipName('STRING')
		    AddTextComponentSubstringPlayerName(v.Label)
		    EndTextCommandSetBlipName(blip)
	    end

        if v.ShowProp == true then
			ESX.Game.SpawnObject(v.Prop, v.coords, function(obj)
				SetEntityHeading(obj, (v.h - 180))
				PlaceObjectOnGroundProperly(obj)
				FreezeEntityPosition(obj, true)
                table.insert(createdVaults, obj)
			end)
		end
	end
end)

AddEventHandler('onResourceStop', function()
    for x,y in pairs(createdVaults) do
        DeleteEntity(y)
    end
end)



AddEventHandler('BluffzJobVault:hasEnteredMarker', function(zone)
	currentAction     = 'vault'
	currentActionMsg  = _U('vault_menu')
	currentActionData = {zone = zone}
end)

AddEventHandler('BluffzJobVault:hasExitedMarker', function(zone)
	currentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, false
		local ReqJob, HasJob
		local VCoords = {}

		for k,v in pairs(Config.Vaults) do
			table.insert(VCoords, v.coords)
			for i = 1, #VCoords, 1 do
				local distance = #(playerCoords - VCoords[i])
				if distance < 2.0 then
					isInMarker  = true
					currentZone = k
					lastZone    = k
					ReqJob		= v.ReqJob
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			if ReqJob ~= nil then
				for _,y in pairs(ReqJob) do
					if y == ESX.GetPlayerData().job.name then
						HasJob = true
					end
				end
				if HasJob then						
					TriggerEvent('BluffzJobVault:hasEnteredMarker', currentZone)
				else
					if Config.notify == 'esx' then
						ESX.ShowNotification('You do not have the required job to use this vault!')
					elseif Config.notify == 'ns' then
						exports['ns_notify']:sendNotify("Wrong Job", "You do not have the required job to use this vault!", 5000, 'error')
					elseif Config.notify == 'custom' then
						--Insert Custom Notification Here
					end	
				end
			else
				TriggerEvent('BluffzJobVault:hasEnteredMarker', currentZone)	
			end
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('BluffzJobVault:hasExitedMarker', lastZone)
			HasJob = false
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)        
 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if currentAction then
			ESX.ShowHelpNotification(currentActionMsg)

			if IsControlJustReleased(0, 38) then
				if currentAction == 'vault' then
                    exports["mf-inventory"]:openOtherInventory(currentActionData.zone)
				end
				currentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)