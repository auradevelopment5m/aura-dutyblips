function Debug(message)
    local config = _G.Config or {}
    if config.Debug then
        print('^3[DEBUG]^7 ' .. tostring(message))
    end
end

function LogInfo(message)
    print('^5[INFO]^7 ' .. tostring(message))
end

function LogSuccess(message)
    print('^2[SUCCESS]^7 ' .. tostring(message))
end

function LogError(message)
    print('^1[ERROR]^7 ' .. tostring(message))
end
