
getgenv().chams = {
    enabled = false, 
    outlineColor = Color3.fromRGB(255, 255, 255), 
    fillColor = Color3.fromRGB(0, 0, 0),
    fillTransparency = 1,
    outlineTransparency = 0,
    teamCheck = false 
}



if not getgenv().chams.enabled then
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

    if isOnSameTeam(player) then
        return
    end


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
