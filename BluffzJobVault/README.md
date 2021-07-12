# BluffzJobVaults
## Job Vault system built for mf-inventory

# Dependencies
- mysql-async
- es_extended (Tested on v1 final)

# Instructions
Drag and drop to your resources folder

add to your server.cfg `ensure BluffzJobVault`.

add `vault_storage = "Vault"` to your mf-inventory locales. You can change Vault to anything you want for your language. It is what will be displayed.

## Adding new vaults with inventory

This resource will automatically create the inventory in your database. All you need to do is add a new vault to your config, and restart the resource or your server.

## Deleting existing vaults

Remove the vault from the config, then go into your database and manually delete the inventory there.

# Misc

You can add as many vaults to your config as you would like. Make sure they follow the exact same format. If you want it to be an open locker, you can delete the ReqJobs section and it should still work. Make sure they don't have the same name, or else you will break the script.

Read the config carefully with all the notes. There should not be any confusion.
