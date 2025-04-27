function LoadModule(modulePath)
    if not modulePath then
        LogError("Invalid module path")
        return {}
    end
    
    LogInfo("Loading module: " .. modulePath)
    
    local content = LoadResourceFile(GetCurrentResourceName(), modulePath)
    if not content then
        LogError("Failed to load module file: " .. modulePath)
        return {}
    end
    
    local chunk, err = load(content, modulePath, 't')
    if not chunk then
        LogError("Failed to compile module: " .. modulePath .. " - " .. tostring(err))
        return {}
    end
    
    local success, result = pcall(chunk)
    if not success then
        LogError("Failed to execute module: " .. modulePath .. " - " .. tostring(result))
        return {}
    end
    
    LogSuccess("Loaded module: " .. modulePath)
    return result or {}
end
