-- Customizable Settings
getgenv().chams = {
    Settings = {
        Enabled = false,                     -- Enable or disable the highlighting
        Color = {255, 0, 0},                -- RGB values for the fill color
        OutlineColor = {255, 255, 255},     -- RGB values for the outline color
        TeamCheck = false                   -- Enable or disable team check
    }
}

-- Function to highlight a player's character
local function highlightPlayer(player)
    if player.Character and getgenv().chams.Settings.Enabled then
        -- Team Check (optional)
        if getgenv().chams.Settings.TeamCheck and player.Team == game.Players.LocalPlayer.Team then
            return
        end
        
        -- Check if a Highlight already exists to avoid duplicates
        if not player.Character:FindFirstChildOfClass("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = player.Character
            
            -- Apply FillColor from settings
            local color = getgenv().chams.Settings.Color
            highlight.FillColor = Color3.fromRGB(color[1], color[2], color[3])

            -- Apply OutlineColor from settings
            local outlineColor = getgenv().chams.Settings.OutlineColor
            highlight.OutlineColor = Color3.fromRGB(outlineColor[1], outlineColor[2], outlineColor[3])
            
            highlight.Parent = player.Character
        end
    end
end

-- Highlight all players currently in the game
for _, player in pairs(game.Players:GetPlayers()) do
    highlightPlayer(player)
end

-- Set up a listener to highlight new players who join
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        highlightPlayer(player)
    end)
end)

-- Update highlights if a player respawns
game.Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        local highlight = player.Character:FindFirstChildOfClass("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end)

-- Connect to the CharacterAdded event to handle respawning players
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        highlightPlayer(player)
    end)
end)

-- Ensure highlights are applied when the player respawns
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    highlightPlayer(game.Players.LocalPlayer)
end)
