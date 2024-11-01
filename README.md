# Roblox-Chams-Highlight
basic script that you can change outline aka chams ( using highlight function ) aswell as fill color of. no gui.

 --// Used in [untitled project](https://github.com/Stratxgy/Untitled-Project)
## Feel free to use this in a script.

## Load the script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))()
```

## Configurable settings
```lua
getgenv().chams = {
    Settings = {
        Enabled = true,                     -- Enable or disable the highlighting
        Color = {255, 0, 0},                -- RGB values for the fill color
        OutlineColor = {255, 255, 255},     -- RGB values for the outline color
        TeamCheck = false                   -- Enable or disable team check
    }
}
```

## Example use of the Script
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Roblox-Chams-Highlight/refs/heads/main/Highlight.lua"))() -- load the script
getgenv().chams.Settings.Color = {0, 255, 0}
getgenv().chams.Settings.TeamCheck = true
getgenv().chams.Settings.OutlineColor = {255, 255, 255}
```
