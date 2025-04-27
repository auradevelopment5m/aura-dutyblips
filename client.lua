local createdBlips = {}
local dutyData = {}
local isResourceStopping = false

-- Forward declare functions
local UpdateBlipColors

local function RemoveBlips()
    for i, blip in pairs(createdBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    createdBlips = {}
end

-- Update blip colors based on duty status
UpdateBlipColors = function()
    if isResourceStopping then return end
    
    for i, blipConfig in ipairs(Config.Blips) do
        local blip = createdBlips[i]
        if blip and DoesBlipExist(blip) then
            local jobName = blipConfig.job
            local requiredOnDuty = blipConfig.requiredOnDuty or 1
            local onDutyCount = dutyData[jobName] or 0
            
            local color
            if onDutyCount >= requiredOnDuty then
                color = blipConfig.customColors and blipConfig.customColors.onDuty or Config.DefaultBlipColors.OnDuty
                Debug(blipConfig.name .. ' blip is ON DUTY (' .. onDutyCount .. '/' .. requiredOnDuty .. ')')
            else
                color = blipConfig.customColors and blipConfig.customColors.offDuty or Config.DefaultBlipColors.OffDuty
                Debug(blipConfig.name .. ' blip is OFF DUTY (' .. onDutyCount .. '/' .. requiredOnDuty .. ')')
            end
            
            if GetBlipColour(blip) ~= color then
                SetBlipColour(blip, color)
            end
        end
    end
end

local function CreateBlips()
    for i, blipConfig in ipairs(Config.Blips) do
        if createdBlips[i] and DoesBlipExist(createdBlips[i]) then
            RemoveBlip(createdBlips[i])
        end
        
        local blip = AddBlipForCoord(blipConfig.coords.x, blipConfig.coords.y, blipConfig.coords.z)
        
        SetBlipSprite(blip, blipConfig.sprite)
        SetBlipDisplay(blip, blipConfig.display or 4)
        SetBlipScale(blip, blipConfig.scale or 0.8)
        SetBlipColour(blip, blipConfig.color or 1)
        SetBlipAsShortRange(blip, blipConfig.shortRange or true)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipConfig.name)
        EndTextCommandSetBlipName(blip)
        
        createdBlips[i] = blip
    end
    
    UpdateBlipColors()
end

RegisterNetEvent('aura-dutyblips:client:updateDutyData', function(data)
    if isResourceStopping then return end
    
    dutyData = data
    UpdateBlipColors()
end)

CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(100)
    end
    
    Wait(1000)
    CreateBlips()
    
    TriggerServerEvent('aura-dutyblips:server:requestDutyData')
    
    while not isResourceStopping do
        Wait(Config.RefreshTime * 1000)
        TriggerServerEvent('aura-dutyblips:server:requestDutyData')
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    isResourceStopping = true
    RemoveBlips()
end)

exports('RefreshBlips', function()
    if isResourceStopping then return end
    TriggerServerEvent('aura-dutyblips:server:requestDutyData')
end)

exports('AddCustomBlip', function(blipData)
    if isResourceStopping or type(blipData) ~= 'table' then return 0 end
    
    table.insert(Config.Blips, blipData)
    CreateBlips()
    
    return #Config.Blips
end)
