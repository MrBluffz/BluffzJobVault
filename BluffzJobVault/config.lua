---------------------------------------------------------------------
--                             Discord:                            --
--                          Mr Bluffz#0001                         --
---------------------------------------------------------------------

Config = {
  Locale = 'en',                                  -- Options: 'de' (german), 'en' (english), 'fr' (french), 'ru' (russian), 'sp' (spanish) I used google translate, feel free to DM me with better translation.
  Notify = 'esx',                                 -- OPTIONS: 'esx', 'ns', 'mythic_old', 'mythic_new', 'chat', 'custom'. Adjust custom notification on line 82 of client.lua, change notification message on line 111
  InteractDist = 2.0,                             -- Distance from vaults to interact
  Vaults = {
    evidenceMRPD1 = {                             -- Inventory Name (MUST BE UNIQUE). Script will auto search if this inventory exists, and if it doesn't, it will create it for you.
      ShowProp = false,                            -- Set to true if you want to see the vault prop. set to false if you do not want to see the vault prop. (Default: true)
      Prop = 'p_v_43_safe_s',                     -- Vault Prop Name
      Coords = vector3(474.8671, -996.9033, 26.2734),   -- These coords are used for your vault prop location, and your blip location.
      Heading = 358.1,                            -- Heading for prop. Make it the same heading your player is standing.
      ShowBlip = false,                            -- Set to true if you want blip, set to false if you do NOT want map blip (default: true)
      Size  = 1.0,                                -- How big the blip will be on the map/minimap.
      Type  = 59,                                 -- Which blip to display    See: https://docs.fivem.net/docs/game-references/blips/
      Color = 25,                                 -- What color Blip you want   See: https://docs.fivem.net/docs/game-references/blips/
      Label = 'MRPD Evidence Locker 1',           -- This will be the Blip name if you have ShowBlip = true. 
      ReqJob = {'police', 'ambulance'},           -- Delete entire line if you don't want a job check, otherwise make sure your job/jobs are in { } like this example {'insertjob', 'insertjob2'}
      Steam = {'steam:000000000000000', 'steam:000000000000000'}, -- Delete entire line if you don't want a steam id check, otherwise make sure your steam id(s) are in { } like this example {'insertsteamid', 'insertsteamid2'}
      MaxWeight = 500.0,                          -- The max weight for this inventory container.
      MaxSlots = 50,                              -- The slot count for this inventory
    },

    evidenceMRPD2 = {                             -- Inventory Name. Script will auto search if this inventory exists, and if it doesn't, it will create it for you.
      ShowProp = false,                            -- set to true if you want to see the vault prop. set to false if you do not want to see the vault prop. (Default: true)
      Prop = 'p_v_43_safe_s',                     -- Vault Prop Name
      Coords = vector3(472.5785, -995.2488, 26.2734),   -- Coords for Blip and Prop
      Heading = 189.61,                           -- Heading for prop
      ShowBlip = false,                            -- Set to true if you want blip, set to false if you do NOT want map blip (default: true)
      Size  = 1.0,                                -- How big the blip will be on the map/minimap.
      Type  = 59,                                 -- Which blip to display    See: https://docs.fivem.net/docs/game-references/blips/
      Color = 25,                                 -- What color Blip you want   See: https://docs.fivem.net/docs/game-references/blips/
      Label = 'MRPD Evidence Locker 2',           -- This will be the Blip name if you have ShowBlip = true. 
      ReqJob = {'police', 'ambulance'},           -- Delete entire line if you don't want a job check, otherwise make sure your job/jobs are in { } like this example {'insertjob', 'insertjob2'}
      Steam = {'steam:000000000000000', 'steam:000000000000000'}, -- Delete entire line if you don't want a steam id check, otherwise make sure your steam id(s) are in { } like this example {'insertsteamid', 'insertsteamid2'}
      MaxWeight = 500.0,                          -- The max weight for this inventory container.
      MaxSlots = 50,                              -- The slot count for this inventory
    },
  }
}

-- DO NOT TOUCH BELOW THIS LINE

for k,v in pairs(Config.Vaults) do
  if v.ReqJob then
    local jobLookup = {}

    for _,name in ipairs(v.ReqJob) do
      jobLookup[name] = true
    end

    v.ReqJob = jobLookup
  end
end

for k,v in pairs(Config.Vaults) do
  if v.Steam then
    local steamLookup = {}

    for _,steam in ipairs(v.Steam) do
      steamLookup[steam] = true
    end

    v.Steam = steamLookup
  end
end
