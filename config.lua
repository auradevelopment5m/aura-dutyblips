return {
    Framework = 'esx',  -- 'qbcore' or 'esx'
    Debug = false,         -- Enable debug logging
    RefreshTime = 1,      -- Refresh interval in seconds

    DefaultBlipColors = {
        OnDuty = 2,  -- Green when enough players are on duty
        OffDuty = 1  -- Red when not enough players are on duty
    },

    Blips = {
        {
            name = "Police Station",
            coords = vec3(-1094.030762, -809.274719, 19.271118),
            sprite = 60,
            scale = 0.8,
            color = 1,
            job = "ambulance",
            requiredOnDuty = 1,
            customColors = {
                onDuty = 2,
                offDuty = 1,
            },
            display = 4,
            shortRange = true,
        },
        {
            name = "Hospital",
            coords = vector3(306.9, -587.86, 43.28),
            sprite = 61,
            scale = 0.8,
            color = 1,
            job = "ambulance",
            requiredOnDuty = 1,
            display = 4,
            shortRange = true,
        },
        {
            name = "Mechanic Shop",
            coords = vector3(-347.41, -133.48, 39.01),
            sprite = 446,
            scale = 0.7,
            color = 1,
            job = "mechanic",
            requiredOnDuty = 1,
            display = 4,
            shortRange = true,
        },
    }
}
