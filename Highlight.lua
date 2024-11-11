getgenv().ChamsSettings = {
    Enabled = false, -- Toggle chams on/off
    TeamCheck = false, -- Enable or disable team checks
    VisibleColor = Color3.fromRGB(255, 0, 0), -- Color when visible
    HiddenColor = Color3.fromRGB(0, 255, 0), -- Color when hidden
    FillTransparency = 0.5, -- Transparency of the fill
    OutlineTransparency = 0, -- Transparency of the outline
}

local client = game.Players.LocalPlayer
local players = game:GetService("Players")
local rs = game:GetService("RunService")

-- Function to check if a player is on the same team
local function isOnSameTeam(player)
    if not ChamsSettings.TeamCheck then
        return false -- Ignore teams if TeamCheck is disabled
    end
    return player.Team == client.Team
end

-- Function to create chams for a character
local function createChams(character, player)
    if not ChamsSettings.Enabled or isOnSameTeam(player) then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "Chams"
    highlight.Parent = character
    highlight.FillTransparency = ChamsSettings.FillTransparency
    highlight.OutlineTransparency = ChamsSettings.OutlineTransparency
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    -- Update visibility based on occlusion
    local function updateVisibility()
        if character:FindFirstChild("Head") and character.Head:IsDescendantOf(workspace) then
            local isVisible = workspace.CurrentCamera:WorldToViewportPoint(character.Head.Position).Z > 0
            highlight.FillColor = isVisible and ChamsSettings.VisibleColor or ChamsSettings.HiddenColor
        else
            highlight:Destroy()
        end
    end

    local connection
    connection = rs.RenderStepped:Connect(function()
        if not character:IsDescendantOf(workspace) or not ChamsSettings.Enabled then
            highlight:Destroy()
            connection:Disconnect()
        else
            updateVisibility()
        end
    end)
end

-- Handle existing and new players
local function setupPlayer(player)
    if player == client then return end

    if player.Character then
        createChams(player.Character, player)
    end

    player.CharacterAdded:Connect(function(character)
        createChams(character, player)
    end)
end

-- Check for players already in the game
local function initializeChams()
    for _, player in ipairs(players:GetPlayers()) do
        setupPlayer(player)
    end
    -- Listen for new players
    players.PlayerAdded:Connect(setupPlayer)
end

-- Check for players and characters that spawn later
local function monitorCharacters()
    rs.Heartbeat:Connect(function()
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= client and player.Character and not player.Character:FindFirstChild("Chams") then
                createChams(player.Character, player)
            end
        end
    end)
end

-- Initialize
initializeChams()
monitorCharacters()
