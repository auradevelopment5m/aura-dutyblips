local ESX = exports["es_extended"]:getSharedObject()
local Bridge = {}

Bridge.GetFrameworkName = function()
    return 'esx'
end

Bridge.Client = {
    GetPlayerData = function()
        if not ESX then return {} end
        return ESX.GetPlayerData()
    end,
    
    GetJob = function()
        if not ESX then return {name = "unemployed"} end
        local playerData = ESX.GetPlayerData()
        return playerData.job
    end,
    
    IsPlayerOnDuty = function()
        if not ESX then return false end
        local playerData = ESX.GetPlayerData()
        return playerData.job.name ~= 'unemployed'
    end
}

Bridge.Server = {
    GetPlayers = function()
        if not ESX then return {} end
        return ESX.GetPlayers()
    end,
    
    GetPlayer = function(source)
        if not ESX then return nil end
        return ESX.GetPlayerFromId(source)
    end,
    
    GetPlayerJob = function(player)
        if not player then return {name = "unemployed"} end
        return player.getJob()
    end,
    
    IsPlayerOnDuty = function(player)
        if not player then return false end
        local job = Bridge.Server.GetPlayerJob(player)
        return job and job.name ~= 'unemployed'
    end,
    
    GetPlayersOnDutyForJob = function(jobName)
        if not ESX then return 0 end
        
        local players = Bridge.Server.GetPlayers()
        local onDutyCount = 0
        
        for _, playerId in ipairs(players) do
            local player = Bridge.Server.GetPlayer(playerId)
            if player then
                local job = Bridge.Server.GetPlayerJob(player)
                if job and job.name == jobName then
                    onDutyCount = onDutyCount + 1
                end
            end
        end
        
        return onDutyCount
    end
}

return Bridge
