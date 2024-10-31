
--// Function to highlight a player’s character
local function highlightPlayer(player)
    if player.Character then
        -- Check if a Highlight already exists to avoid duplicates
        if not player.Character:FindFirstChildOfClass("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)  --// Change FillColor Here 
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255) --// Change OutlineColor Here
            highlight.Parent = player.Character
        end
    end
end

-- Highlight all players currently in the game
for _, player in pairs(game.Players:GetPlayers()) do
    highlightPlayer(player)
end

--// Set up a listener to highlight new players who join
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        highlightPlayer(player)
    end)
end)

--// Update highlights if a player respawns
game.Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        local highlight = player.Character:FindFirstChildOfClass("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end)
