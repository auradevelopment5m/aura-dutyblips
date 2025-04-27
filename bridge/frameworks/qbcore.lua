local QBCore = exports['qb-core']:GetCoreObject()
local Bridge = {}

Bridge.GetFrameworkName = function()
    return 'qbcore'
end

Bridge.Client = {
    GetPlayerData = function()
        return QBCore.Functions.GetPlayerData()
    end,
    
    GetJob = function()
        local playerData = QBCore.Functions.GetPlayerData()
        return playerData.job
    end,
    
    IsPlayerOnDuty = function()
        local playerData = QBCore.Functions.GetPlayerData()
        return playerData.job.onduty
    end
}

Bridge.Server = {
    GetPlayers = function()
        return QBCore.Functions.GetPlayers()
    end,
    
    GetPlayer = function(source)
        return QBCore.Functions.GetPlayer(source)
    end,
    
    GetPlayerJob = function(player)
        if not player then return nil end
        return player.PlayerData.job
    end,
    
    IsPlayerOnDuty = function(player)
        if not player then return false end
        return player.PlayerData.job.onduty
    end,
    
    GetPlayersOnDutyForJob = function(jobName)
        local players = Bridge.Server.GetPlayers()
        local onDutyCount = 0
        
        for _, playerId in ipairs(players) do
            local player = Bridge.Server.GetPlayer(playerId)
            if player then
                local job = Bridge.Server.GetPlayerJob(player)
                if job and job.name == jobName and Bridge.Server.IsPlayerOnDuty(player) then
                    onDutyCount = onDutyCount + 1
                end
            end
        end
        
        return onDutyCount
    end
}

return Bridge
