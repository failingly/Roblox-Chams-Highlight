
getgenv().chams = {
    enabled = false, -- Toggle the chams feature
    outlineColor = Color3.fromRGB(0, 0, 0), -- White outline
    fillTransparency = 0, -- Make the inside of the outline transparent
    outlineTransparency = 0 -- Make the outline fully visible
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function createHighlight(character)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = character
    highlight.FillTransparency = getgenv().chams.fillTransparency -- Use setting for transparency
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
