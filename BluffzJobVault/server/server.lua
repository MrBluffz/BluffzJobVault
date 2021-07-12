ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('onResourceStart', function()
  MySQL.Async.fetchAll('SELECT identifier FROM inventories', {}, function(result)
    local test = {}
    local exists = false
    for k,v in pairs(result) do
      for _,i in pairs(v) do
        table.insert(test, i)
      end
    end
    for x,y in pairs(Config.Vaults) do
      for i=1, #test, 1 do
        if test[i] == x then
          exists = true
        end
      end
      if exists == false then
        local uniqueIdentifier = x
        local inventoryType = "inventory"                                 -- Inventory type. Default is "inventory", other types are "shop" and "recipe".
        local inventorySubType = "housing"                                -- Inventory sub-type, used to modify degrade modifiers by the config table.
        local inventoryLabel = "vault_storage"                            -- The inventorys UI label index (which will pull the translation value).
        local maxWeight = 500.0                                           -- Max weight for the inventory.
        local maxSlots = 50                                               -- Max slots for the inventory.
    
        exports["mf-inventory"]:createInventory(uniqueIdentifier,inventoryType,inventorySubType,inventoryLabel,maxWeight,maxSlots)
      end
      print('This inventory already exists: ' .. x)
      exists = false
    end
  end)
end)

