Config = {}
Config.Locale = 'en'
Config.notify = 'esx'									-- OPTIONS: 'esx', 'ns', 'custom'. esx is default notification, ns is for ns_notify, custom is for you to add your own on line 92 of client.lua
Config.Vaults = {

	evidenceMRPD1 = {									-- Inventory Name (MUST BE UNIQUE). Script will auto search if this inventory exists, and if it doesn't, it will create it for you.
        ShowProp = true,								-- set to true if you want to see the vault prop. set to false if you do not want to see the vault prop. (Default: true)
        Prop = 'p_v_43_safe_s',                         -- Vault Prop Name
        coords = vector3(415.5, -1004.94, 29.29),		-- These coords are used for your vault prop location, and your blip location.
		h = 358.1,                                      -- Heading for prop. Make it the same heading your player is standing.
        ShowBlip = true,								-- Set to true if you want blip, set to false if you do NOT want map blip (default: true)
		Size  = 1.0,									-- How big the blip will be on the map/minimap.
		Type  = 59,										-- Which blip to display 		See: https://docs.fivem.net/docs/game-references/blips/
		Color = 25,										-- What color Blip you want		See: https://docs.fivem.net/docs/game-references/blips/
		Label = 'MRPD Evidence Locker 1',				-- This will be the Blip name if you have ShowBlip = true. 
		ReqJob = {'police', 'ambulance'}				-- Delete entire line if you don't want a job check, otherwise make sure your job/jobs are in { } like this example {'insertjob', 'insertjob2'}
	},

	evidenceMRPD2 = {									-- Inventory Name. Script will auto search if this inventory exists, and if it doesn't, it will create it for you.
        ShowProp = true,								-- set to true if you want to see the vault prop. set to false if you do not want to see the vault prop. (Default: true)
        Prop = 'p_v_43_safe_s',                          -- Vault Prop Name
        coords = vector3(415.17, -992.75, 29.39),          -- Coords for Blip and Prop
        h = 189.61,                                         -- Heading for prop
        ShowBlip = true,								-- Set to true if you want blip, set to false if you do NOT want map blip (default: true)
		Size  = 1.0,									-- How big the blip will be on the map/minimap.
		Type  = 59,										-- Which blip to display 		See: https://docs.fivem.net/docs/game-references/blips/
		Color = 25,										-- What color Blip you want		See: https://docs.fivem.net/docs/game-references/blips/
		Label = 'MRPD Evidence Locker 2',				-- This will be the Blip name if you have ShowBlip = true. 
		ReqJob = {'police', 'ambulance'}				-- Delete entire line if you don't want a job check, otherwise make sure your job/jobs are in { } like this example {'insertjob', 'insertjob2'}
	},
}