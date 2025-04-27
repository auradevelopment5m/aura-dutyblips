local dutyData = {}
local isResourceStopping = false

local function UpdateDutyData()
    if isResourceStopping then return end
    
    local newDutyData = {}
    local hasChanges = false
    
    for _, blipConfig in ipairs(Config.Blips) do
        local jobName = blipConfig.job
        if jobName then
            local onDutyCount = DutyBlipsBridge.Server.GetPlayersOnDutyForJob(jobName)
            newDutyData[jobName] = onDutyCount
            
            if dutyData[jobName] ~= onDutyCount then
                hasChanges = true
                Debug('Job: ' .. jobName .. ' | On Duty: ' .. onDutyCount)
            end
        end
    end
    
    if hasChanges then
        dutyData = newDutyData
        TriggerClientEvent('aura-dutyblips:client:updateDutyData', -1, dutyData)
    end
    
    return hasChanges
end

RegisterNetEvent('aura-dutyblips:server:requestDutyData', function()
    if isResourceStopping then return end
    
    local source = source
    if not source then return end
    
    UpdateDutyData()
    TriggerClientEvent('aura-dutyblips:client:updateDutyData', source, dutyData)
end)

local function RegisterFrameworkEvents()
    local framework = DutyBlipsBridge.GetFrameworkName()
    
    if framework == 'qbcore' then
        AddEventHandler('QBCore:Server:OnJobUpdate', function(_, _)
            Wait(500)
            UpdateDutyData()
        end)
        
        AddEventHandler('QBCore:Server:SetDuty', function(_, _)
            Wait(500)
            UpdateDutyData()
        end)
    elseif framework == 'esx' then
        AddEventHandler('esx:setJob', function(_, _)
            Wait(500)
            UpdateDutyData()
        end)
    end
end

AddEventHandler('playerJoining', function()
    Wait(1000)
    UpdateDutyData()
end)

AddEventHandler('playerDropped', function()
    Wait(1000)
    UpdateDutyData()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    Wait(5000)
    RegisterFrameworkEvents()
    UpdateDutyData()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    isResourceStopping = true
end)

CreateThread(function()
    while not isResourceStopping do
        Wait(Config.RefreshTime * 1000)
        UpdateDutyData()
    end
end)

exports('GetDutyData', function()
    return dutyData
end)

exports('GetPlayersOnDutyForJob', function(jobName)
    return dutyData[jobName] or 0
end)
 