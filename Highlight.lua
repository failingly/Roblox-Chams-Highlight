-- Configuration for the visual effect (chams)
getgenv().chams = {
    enabled = false,                         -- Master toggle for the entire functionality
    outlineColor = Color3.fromRGB(255, 255, 255), -- Color of the outline (white)
    fillColor = Color3.fromRGB(255, 255, 255),    -- Color of the fill (changed from black to white)
    fillTransparency = 1,                    -- How transparent the fill is (1 = completely transparent)
    outlineTransparency = 0,                 -- How transparent the outline is (0 = fully visible)
    teamCheck = false                        -- Whether to ignore players on the same team
}

-- Get necessary game services
local Players = game:GetService("Players")   -- Access to all players in the game
local LocalPlayer = Players.LocalPlayer      -- Reference to your own player
local activeHighlights = {}                  -- Table to track all created highlights for easy management

-- Determine if a player is on the same team as the local player
-- Returns true if teamCheck is enabled and players share team color
local function isOnSameTeam(player)
    return getgenv().chams.teamCheck and player.TeamColor == LocalPlayer.TeamColor
end

-- Creates or updates a highlight effect on a character
-- This handles both creating new highlights and updating existing ones
local function applyHighlightToCharacter(character, player)
    -- Safety check - make sure character exists
    if not character then return end
    
    -- Try to find an existing highlight on this character
    local highlight = character:FindFirstChildOfClass("Highlight")
    
    -- If no highlight exists, create a new one
    if not highlight then
        highlight = Instance.new("Highlight")    -- Create the visual effect object
        highlight.Parent = character             -- Attach it to the character
        highlight.Adornee = character            -- Set which object to highlight
    end
    
    -- Apply current settings from the chams configuration
    highlight.FillTransparency = getgenv().chams.fillTransparency       -- How see-through the fill is
    highlight.FillColor = getgenv().chams.fillColor                     -- Color inside the outline
    highlight.OutlineColor = getgenv().chams.outlineColor               -- Color of the border
    highlight.OutlineTransparency = getgenv().chams.outlineTransparency -- How see-through the outline is
    
    -- Return the highlight for tracking
    return highlight
end

-- Manages the highlight for a specific player
-- Decides whether to apply or remove highlights based on team and settings
local function applyHighlight(player)
    -- Skip highlighting yourself or teammates (if teamCheck is enabled)
    if player == LocalPlayer or isOnSameTeam(player) then 
        -- Remove existing highlight if player is now ineligible (e.g., switched to your team)
        if activeHighlights[player] then
            removeHighlight(player.Character)
            activeHighlights[player] = nil
        end
        return 
    end
    
    -- If player has a character, apply the highlight effect
    if player.Character then
        activeHighlights[player] = applyHighlightToCharacter(player.Character, player)
    end
end

-- Removes a highlight effect from a character
-- Used when disabling chams or when a player becomes ineligible
local function removeHighlight(character)
    -- Safety check - make sure character exists
    if not character then return end
    
    -- Find and destroy any existing highlight
    local highlight = character:FindFirstChildOfClass("Highlight")
    if highlight then highlight:Destroy() end
end

-- Removes all active highlights from all players
-- Used when disabling the chams feature entirely
local function removeAllHighlights()
    -- Loop through all tracked highlights
    for player, _ in pairs(activeHighlights) do
        -- Remove highlight if character exists
        if player.Character then
            removeHighlight(player.Character)
        end
    end
    -- Clear the tracking table
    activeHighlights = {}
end

-- Handles when a player's character is added to the game
-- This happens when players spawn or respawn
local function onCharacterAdded(player, character)
    -- Only apply highlight if:
    -- 1. Chams are enabled
    -- 2. It's not your own character
    -- 3. Player is not on your team (if teamCheck is enabled)
    if getgenv().chams.enabled and player ~= LocalPlayer and not isOnSameTeam(player) then
        activeHighlights[player] = applyHighlightToCharacter(character, player)
    end
end

-- Sets up tracking for a new player that joins the game
local function onPlayerAdded(player)
    -- Set up a listener for when this player spawns or respawns
    player.CharacterAdded:Connect(function(character)
        onCharacterAdded(player, character)
    end)
    
    -- If player already has a character, handle it immediately
    if player.Character then
        onCharacterAdded(player, character)
    end
end

-- Cleans up when a player leaves the game
local function onPlayerRemoving(player)
    -- Check if we're tracking a highlight for this player
    if activeHighlights[player] then
        -- Remove the highlight if character exists
        if player.Character then
            removeHighlight(player.Character)
        end
        -- Remove player from tracking table
        activeHighlights[player] = nil
    end
end

-- Main loop that periodically updates all highlights
-- This ensures changes to settings are applied to all players
task.spawn(function()
    while task.wait(0.25) do  -- Run 4 times per second (reduced from 10 times for better performance)
        if getgenv().chams.enabled then
            -- If enabled, apply highlights to all players
            for _, player in ipairs(Players:GetPlayers()) do
                applyHighlight(player)
            end
        else
            -- If disabled, remove all highlights
            removeAllHighlights()
        end
    end
end)

-- Initialize highlights for all existing players when script starts
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Set up event listeners for players joining and leaving
Players.PlayerAdded:Connect(onPlayerAdded)       -- When a new player joins
Players.PlayerRemoving:Connect(onPlayerRemoving) -- When a player leaves
