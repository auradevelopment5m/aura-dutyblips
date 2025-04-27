# Aura Development Links

- [Discord](https://discord.gg/5hsXHxeXVX)

- [Github](https://github.com/auradevelopment5m)

- [Youtube](https://www.youtube.com/@aura_development)

- [Tebex](https://auradevelopment.tebex.io/)

- [Ko-fi](https://ko-fi.com/auradevelopment)

- [Portfolio](https://auradevelopment5m.github.io/)

- [Preview](https://streamable.com/7nl9ge)
## Aura Duty Blips

A comprehensive duty blips system for FiveM servers that supports both QBCore and ESX frameworks.

### Features

- Dynamic blips that change color based on how many players are on duty for specific jobs
- Support for both QBCore and ESX frameworks via a bridge system
- Configurable duty thresholds for each blip
- Custom colors for on-duty and off-duty states
- Regular refresh of duty status
- Fully Optimized, and secured.

### Configuration

The `config.lua` file contains all the settings for the resource:

- `Framework`: Choose between 'qbcore' or 'esx'
- `Debug`: Enable/disable debug prints
- `RefreshTime`: How often to refresh blips (in seconds)
- `DefaultBlipColors`: Default colors for on-duty and off-duty states
- `Blips`: Array of blip configurations

#### Blip Configuration Options

Each blip in the config can have the following properties:

- `name`: Display name of the blip
- `coords`: Location of the blip (vector3)
- `sprite`: Blip sprite ID 
- `scale`: Size of the blip
- `color`: Default color (will change based on duty)
- `job`: Job name to check for duty status
- `requiredOnDuty`: How many players need to be on duty for the blip to turn green
- `customColors`: Optional custom colors for on-duty and off-duty states
- `display`: Blip display mode
- `shortRange`: Whether the blip should only show when nearby
