
getgenv().chams = {
    enabled = false,
    outlineColor = Color3.fromRGB(255, 255, 255),
    fillColor = Color3.fromRGB(0, 0, 0)
    fillTransparency = 1, 
    outlineTransparency = 0 
}
    
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function createHighlight(character)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = character
    highlight.FillTransparency = getgenv().chams.fillTransparency 
    highlight.FillColor = getgenv().chams.fillColor
    highlight.OutlineColor = getgenv().chams.outlineColor 
    highlight.OutlineTransparency = getgenv().chams.outlineTransparency 
    highlight.Parent = character
    return highlight
end

local function onCharacterAdded(character)
    -- Ensure any existing highlight is removed to prevent duplicates
    if character:FindFirstChildOfClass("Highlight") then
        character:FindFirstChildOfClass("Highlight"):Destroy()
    end

    createHighlight(character)
end

local function trackPlayer(player)
    if player == LocalPlayer then return end

    -- Connect to CharacterAdded event
    player.CharacterAdded:Connect(function(character)
        onCharacterAdded(character)
    end)

    -- If the player's character already exists, apply the highlight
    if player.Character then
        onCharacterAdded(player.Character)
    end
end

-- Apply highlights to all existing players
for _, player in ipairs(Players:GetPlayers()) do
    trackPlayer(player)
end

-- Apply highlights to new players joining the game
Players.PlayerAdded:Connect(trackPlayer)
