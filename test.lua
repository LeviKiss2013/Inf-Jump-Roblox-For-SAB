-- Safe Roblox Studio script to adjust walk speed in your own game
local Players = game:GetService("Players")

-- Change walk speed for all players when they spawn
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 30 -- Default is 16, increase for faster movement
        end
    end)
end)
