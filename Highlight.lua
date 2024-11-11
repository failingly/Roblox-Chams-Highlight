-- Settings Table
getgenv().chams = {
    enabled = false,  -- Whether highlights are enabled
    teamcheck = false,  -- Whether to apply highlights based on the player's team
    fillcolor = Color3.fromRGB(255, 0, 4),  -- Default fill color (red)
    outlinecolor = Color3.fromRGB(255, 255, 255)  -- Default outline color (white)
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local warnedPlayers = {}  -- Table to keep track of players who have been warned

local function applyHighlight(player)
    -- Check if highlights are enabled based on settings
    if not getgenv().chams.enabled then return end

    local function onCharacterAdded(character)
        -- Wait for the HumanoidRootPart and other parts to ensure the character is fully loaded
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not humanoidRootPart then
            -- Only warn once per player
            if not warnedPlayers[player.UserId] then
                warn("HumanoidRootPart not found for player: " .. player.Name)
                warnedPlayers[player.UserId] = true  -- Mark this player as warned
            end
            return
        end

        -- If team check is enabled, check if the player's team matches before applying highlight
        if getgenv().chams.teamcheck and player.Team ~= nil and player.Team ~= game.Teams[teamName] then
            return
        end

        -- Check if a Highlight already exists
        local existingHighlight = character:FindFirstChildOfClass("Highlight")
        if existingHighlight then
            -- If the highlight exists, ensure it's enabled and use the correct colors
            existingHighlight.Enabled = true
            existingHighlight.FillColor = getgenv().chams.fillcolor
            existingHighlight.OutlineColor = getgenv().chams.outlinecolor
            return
        end

        -- Create a new Highlight instance and set properties
        local highlight = Instance.new("Highlight", character)
        highlight.Archivable = true
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop  -- Ensure it's visible above all other parts
        highlight.Enabled = true  -- Make the highlight visible
        highlight.FillColor = getgenv().chams.fillcolor  -- Set the fill color based on settings
        highlight.OutlineColor = getgenv().chams.outlinecolor  -- Set the outline color based on settings
        highlight.FillTransparency = 0.5  -- Set fill transparency
        highlight.OutlineTransparency = 0  -- No transparency on the outline

        -- Ensure the highlight stays enabled
        highlight:GetPropertyChangedSignal("Enabled"):Connect(function()
            if not highlight.Enabled then
                highlight.Enabled = true
            end
        end)

        -- If there was a problem parenting, we can manually ensure it's in the correct place.
        if not highlight.Parent then
            highlight.Parent = character
        end
    end

    -- If the player's character already exists, apply the highlight
    if player.Character then
        onCharacterAdded(player.Character)
    end

    -- Connect to CharacterAdded to ensure highlight is added when character respawns
    player.CharacterAdded:Connect(onCharacterAdded)
end

-- Function to verify that each player has a highlight
local function checkHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local highlight = player.Character:FindFirstChildOfClass("Highlight")
            -- If no highlight is found, apply it
            if not highlight then
                applyHighlight(player)
            else
                -- Ensure highlight stays enabled and the correct colors are applied
                if not highlight.Enabled then
                    highlight.Enabled = true
                end
                highlight.FillColor = getgenv().chams.fillcolor
                highlight.OutlineColor = getgenv().chams.outlinecolor
            end
        end
    end
end

-- Apply the highlight to all current players on initial run
for _, player in pairs(Players:GetPlayers()) do
    applyHighlight(player)
end

-- Listen for new players joining and apply highlight
Players.PlayerAdded:Connect(function(player)
    applyHighlight(player)
end)

-- Continuously check and apply highlights using RenderStepped
RunService.RenderStepped:Connect(function()
    checkHighlights()
end)
