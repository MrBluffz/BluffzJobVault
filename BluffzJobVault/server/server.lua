Citizen.CreateThread(function()
  exports["mf-inventory"]:onReady(function()
    for id,data in pairs(Config.Vaults) do
      local inv = exports["mf-inventory"]:getInventory(id)
      if not inv then
        print(string.format("creating new vault inventory for identifier '%s'",id))

        exports["mf-inventory"]:createInventory(
          id,
          "inventory",
          "vault",
          "vault_storage",
          data.MaxWeight or 500.0,
          data.MaxSlots or 50
        )
      end
    end
  end)
end)

RegisterServerEvent('BluffzVaults:checkCreate')
AddEventHandler('BluffzVaults:checkCreate', function(id)
  local inv = exports["mf-inventory"]:getInventory(id)
  local data = Config.Vaults[id]
  if not inv then
    print(string.format("creating new vault inventory for identifier '%s'",id))

    exports["mf-inventory"]:createInventory(
      id,
      "inventory",
      "vault",
      "vault_storage",
      data.MaxWeight or 500.0,
      data.MaxSlots or 50
    )
  end
  TriggerClientEvent('BluffzVaults:open', source, id)
end)
