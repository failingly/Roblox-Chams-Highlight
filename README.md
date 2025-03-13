 --// Used in aura
## Feel free to use this in a script.

## Load the script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))()
```

## Configurable settings
```lua
getgenv().chams = {
    enabled = false, 
    outlineColor = Color3.fromRGB(255, 255, 255),
    fillColor = Color3.fromRGB(0, 0, 0),
    fillTransparency = 1,
    outlineTransparency = 0, 
    teamCheck = false 
}
```
> [!IMPORTANT]
> Script is disabled by default. You must run chams.enabled = true to turn it on automatically.

## Example use of the Script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))() -- load the script
chams.enabled = true
chams.teamcheck = true
chams.fillcolor = Color3.fromRGB(0, 0, 255)
chams.outlinecolor = Color3.fromRGB(255, 255, 0)
```
