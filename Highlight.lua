-- Add settings using getgenv()
getgenv().chams = {
    enabled = false, -- Toggle the chams feature
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
    highlight.FillTransparency = getgenv().chams.fillTransparency -- Use setting for transparency
    highlight.FillColor = getgenv().chams.fillColor -- Use setting for fill color
    highlight.OutlineColor = getgenv().chams.outlineColor -- Use setting for outline color
    highlight.OutlineTransparency = getgenv().chams.outlineTransparency -- Use setting for outline transparency
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
