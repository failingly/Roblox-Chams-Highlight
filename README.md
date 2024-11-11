#  Make sure to drop a ⭐ if you liked the script
basic script that you can change outline aka chams ( using highlight function ) aswell as fill color of. no gui.

 --// Used in aura
## Feel free to use this in a script.

## Load the script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))()
```

## Configurable settings
```lua
getgenv().chams = {
    enabled = false,  -- Whether highlights are enabled
    teamcheck = false,  -- Whether to apply highlights based on the player's team
    fillcolor = Color3.fromRGB(255, 0, 4),  -- Default fill color (red)
    outlinecolor = Color3.fromRGB(255, 255, 255)  -- Default outline color (white)
}
```
> [!IMPORTANT]
> Script is disabled by default. You must run chams.enabled = true to turn it on.

## Example use of the Script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))() -- load the script
chams.enabled = true
chams.teamcheck = true
chams.fillcolor = Color3.fromRGB(0, 0, 255)
chams.outlinecolor = Color3.fromRGB(255, 255, 0)
```
