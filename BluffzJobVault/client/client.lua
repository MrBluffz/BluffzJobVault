local ESX
local playerData
local createdVaults = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob',function(j)
  playerData.job = j
end)

function getClosestVault(pos)
  local closest,dist

  for k,v in pairs(Config.Vaults) do
    local d = #(v.Coords - pos)
    if not dist or d < dist then
      closest = k
      dist = d
    end
  end

  return closest,dist
end

function setupVaults()
  for k,v in pairs(Config.Vaults) do
    if v.ShowBlip then
      local blip = AddBlipForCoord(v.Coords)
      SetBlipSprite (blip, v.Type)
      SetBlipScale  (blip, v.Size)
      SetBlipColour (blip, v.Color)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName('STRING')
      AddTextComponentSubstringPlayerName(v.Label)
      EndTextCommandSetBlipName(blip)
    end

    if v.ShowProp == true then
      ESX.Game.SpawnObject(v.Prop, v.Coords, function(obj)
        SetEntityAsMissionEntity(obj,true,true)
        SetEntityHeading(obj,v.Heading-180)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj,true)
        table.insert(createdVaults,obj)
      end)
    end
  end
end

function showHelpNotification(msg)
  AddTextEntry('vaultsHelpNotif', msg)
  DisplayHelpTextThisFrame('vaultsHelpNotif', false)
end

function setupEsx()
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) 
      ESX = obj 
    end)

    Wait(100)
  end

  while not ESX.IsPlayerLoaded() do
    Wait(500)
  end

  playerData = ESX.GetPlayerData()
end

function notify(title, msg, duration, type)
  if Config.Notify == 'ns' then
    exports['ns_notify']:sendNotify(title, msg, duration, type)
  elseif Config.Notify == 'mythic_old' then
    exports['mythic_notify']:DoCustomHudText(type, msg, duration)
  elseif Config.Notify == 'mythic_new' then
    exports['mythic_notify']:SendAlert(type, msg, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
  elseif Config.Notify == 'esx' then
    ESX.ShowNotification(msg)
  elseif Config.Notify == 'chat' then
    TriggerEvent('chatMessage', msg)
  elseif Config.Notify == 'custom' then
    -- Insert Custom Notification here
  end
end

Citizen.CreateThread(function()
  local lastVault
  local helpLabel = _U('vault_menu')
  local IsInMarker, AlreadyInMarker = false, false
  setupEsx()
  setupVaults()

  while true do
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    local closestVault,vaultDist = getClosestVault(pos)
    local vault = Config.Vaults[closestVault]

      if not lastVault or lastVault ~= closestVault then
      if lastVault then
        AlreadyInMarker = false
      end
    end
      
    if vaultDist <= Config.InteractDist then
      lastVault = closestVault
      IsInMarker = true
      if not AlreadyInMarker and IsInMarker then
        if vault.ReqJob and not vault.ReqJob['identifier'] and not vault.ReqJob[playerData.job.name] then
          notify("Wrong Job", "You do not have the correct job to access this vault!", 5000, 'error')
        end
      end
      AlreadyInMarker = true
      if not vault.ReqJob or vault.ReqJob[playerData.job.name] then
        showHelpNotification(helpLabel)

        if IsControlJustPressed(0,38) then
          exports["mf-inventory"]:openOtherInventory(closestVault)
        end
      elseif vault.ReqJob['identifier'] then
        showHelpNotification(helpLabel)

        if IsControlJustPressed(0,38) then
          exports["mf-inventory"]:openOtherInventory(closestVault..playerData.identifier)
        end
      end
    end

    Wait(vaultDist < 10.0 and 0 or 500)
  end
end)
