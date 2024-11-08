# Roblox-Chams-Highlight
basic script that you can change outline aka chams ( using highlight function ) aswell as fill color of. no gui.

> [!IMPORTANT]
> Script is disabled by default. You must run getgenv().chams.Settings.Enabled = true to turn it on.

 --// Used in [untitled project](https://github.com/Stratxgy/Untitled-Project)
## Feel free to use this in a script.

## Load the script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))()
```

## Configurable settings
```lua
local ChamsSettings = {
    Enabled = false, -- Toggle chams on/off
    TeamCheck = false, -- Enable or disable team checks
    VisibleColor = Color3.fromRGB(255, 0, 0), -- Color when visible
    HiddenColor = Color3.fromRGB(0, 255, 0), -- Color when hidden
    FillTransparency = 0.5, -- Transparency of the fill
    OutlineTransparency = 0, -- Transparency of the outline
}
```

## Example use of the Script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))() -- load the script
ChamsSettings.Enabled = true
ChamsSettings.TeamCheck = true
ChamsSettings.VisibleColor = Color3.fromRGB(0, 0, 255)
ChamsSettings.HiddenColor = Color3.fromRGB(255, 255, 0)
```
