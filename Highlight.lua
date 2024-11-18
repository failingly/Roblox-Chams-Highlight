
getgenv().chams = {
    enabled = false, -- Toggle the chams feature
    outlineColor = Color3.fromRGB(255, 255, 255), -- White outline
    fillColor = Color3.fromRGB(0, 0, 0), -- Black fill (default, can be changed)
    fillTransparency = 1, -- Make the inside of the outline transparent
    outlineTransparency = 0, -- Make the outline fully visible
    teamCheck = false -- Toggle team checking (true = skip highlighting teammates)
}

-- Ensure the script does nothing if chams are disabled
if not getgenv().chams.enabled then
    print("Aura Loaded!")
    return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function isOnSameTeam(player)
    if getgenv().chams.teamCheck then
        return player.TeamColor == LocalPlayer.TeamColor
    end
    return false
end

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

local function onCharacterAdded(character, player)
    -- Skip highlighting teammates if teamCheck is enabled
    if isOnSameTeam(player) then
        return
    end

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
        onCharacterAdded(character, player)
    end)


    if player.Character then
        onCharacterAdded(player.Character, player)
    end
end


for _, player in ipairs(Players:GetPlayers()) do
    trackPlayer(player)
end


Players.PlayerAdded:Connect(trackPlayer)
