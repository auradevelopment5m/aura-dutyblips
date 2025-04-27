local function CreateFallbackBridge()
    return {
        GetFrameworkName = function() return "fallback" end,
        Client = {
            GetPlayerData = function() return {} end,
            GetJob = function() return {name = "unemployed", onduty = false} end,
            IsPlayerOnDuty = function() return false end
        },
        Server = {
            GetPlayers = function() return {} end,
            GetPlayer = function() return nil end,
            GetPlayerJob = function() return {name = "unemployed", onduty = false} end,
            IsPlayerOnDuty = function() return false end,
            GetPlayersOnDutyForJob = function() return 0 end
        }
    }
end

local function InitializeBridge()
    -- Load config
    _G.Config = LoadModule('config.lua')
    local framework = Config.Framework:lower()
    LogInfo("Initializing " .. framework .. " bridge")
    
    local bridgePath = 'bridge/frameworks/' .. framework .. '.lua'
    local loadedBridge = LoadModule(bridgePath)
    
    if loadedBridge and type(loadedBridge) == 'table' and loadedBridge.GetFrameworkName then
        LogSuccess("Loaded " .. framework .. " bridge")
        return loadedBridge
    else
        LogError("Failed to load " .. framework .. " bridge, using fallback")
        return CreateFallbackBridge()
    end
end

local Bridge = InitializeBridge()
_G.DutyBlipsBridge = Bridge
return Bridge
