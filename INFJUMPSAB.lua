
-- KAI MOVEMENT GUI
-- Place in StarterPlayer > StarterPlayerScripts
-- Use as a LocalScript in your own Roblox game

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character, humanoid, rootPart
local infiniteJump = true
local flying = false
local flySpeed = 45
local walkSpeed = 30

-- Character setup
local function setupCharacter(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    humanoid.WalkSpeed = walkSpeed
    flying = false
end

if player.Character then
    setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "KaiMovementGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(260, 275)
frame.Position = UDim2.new(0, 20, 0.5, -137)
frame.BackgroundColor3 = Color3.fromRGB(20, 22, 32)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 42)
title.BackgroundTransparency = 1
title.Text = "KAI MOVEMENT"
title.TextColor3 = Color3.fromRGB(0, 220, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 19
title.Parent = frame

local function makeButton(text, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -24, 0, 38)
    button.Position = UDim2.fromOffset(12, y)
    button.BackgroundColor3 = Color3.fromRGB(39, 44, 61)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Text = text
    button.Parent = frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    button.MouseButton1Click:Connect(callback)
    return button
end

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -24, 0, 24)
speedLabel.Position = UDim2.fromOffset(12, 48)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "WalkSpeed: 30 / 60"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 14
speedLabel.Parent = frame

local minus = makeButton("-  Speed", 76, function()
    walkSpeed = math.max(16, walkSpeed - 5)
    if humanoid then humanoid.WalkSpeed = walkSpeed end
    speedLabel.Text = "WalkSpeed: " .. walkSpeed .. " / 60"
end)

local plus = makeButton("+  Speed", 120, function()
    walkSpeed = math.min(60, walkSpeed + 5)
    if humanoid then humanoid.WalkSpeed = walkSpeed end
    speedLabel.Text = "WalkSpeed: " .. walkSpeed .. " / 60"
end)

local jumpButton
jumpButton = makeButton("Infinite Jump: ON", 164, function()
    infiniteJump = not infiniteJump
    jumpButton.Text = "Infinite Jump: " .. (infiniteJump and "ON" or "OFF")
end)

local flyButton
flyButton = makeButton("Fly: OFF (hold Space)", 208, function()
    flying = not flying
    flyButton.Text = "Fly: " .. (flying and "ON" or "OFF")
end)

-- Infinite jump
UIS.JumpRequest:Connect(function()
    if infiniteJump and humanoid and rootPart and humanoid.Health > 0 then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        local v = rootPart.AssemblyLinearVelocity
        rootPart.AssemblyLinearVelocity = Vector3.new(
            v.X, math.max(v.Y, 35) * 1.5, v.Z
        )
    end
end)

-- Fly upward while enabled and Space is held
RunService.RenderStepped:Connect(function()
    if flying and UIS:IsKeyDown(Enum.KeyCode.Space)
        and humanoid and rootPart and humanoid.Health > 0 then
        local v = rootPart.AssemblyLinearVelocity
        rootPart.AssemblyLinearVelocity = Vector3.new(v.X, flySpeed, v.Z)
    end
end)
