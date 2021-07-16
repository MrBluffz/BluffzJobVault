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
