
-- KAI HUB
-- LocalScript > StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character
local humanoid
local rootPart

local movementEnabled = false
local jumpBoost = 1.5
local flySpeed = 45
local walkSpeed = 30

-- Character setup
local function setupCharacter(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	rootPart = char:WaitForChild("HumanoidRootPart")
	humanoid.WalkSpeed = walkSpeed
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)

-- Intro GUI
local introGui = Instance.new("ScreenGui")
introGui.Name = "KaiHubIntro"
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.Parent = player:WaitForChild("PlayerGui")

local introBg = Instance.new("Frame")
introBg.Size = UDim2.fromScale(1, 1)
introBg.BackgroundColor3 = Color3.fromRGB(8, 12, 20)
introBg.BorderSizePixel = 0
introBg.Parent = introGui

local introGradient = Instance.new("UIGradient")
introGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 12, 25)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 90, 110))
})
introGradient.Rotation = 35
introGradient.Parent = introBg

local introTitle = Instance.new("TextLabel")
introTitle.Size = UDim2.new(1, 0, 0, 65)
introTitle.Position = UDim2.fromScale(0, 0.36)
introTitle.BackgroundTransparency = 1
introTitle.Text = "KAI HUB"
introTitle.TextColor3 = Color3.fromRGB(80, 230, 255)
introTitle.Font = Enum.Font.GothamBlack
introTitle.TextSize = 44
introTitle.Parent = introBg

local introStatus = Instance.new("TextLabel")
introStatus.Size = UDim2.new(1, 0, 0, 30)
introStatus.Position = UDim2.fromScale(0, 0.47)
introStatus.BackgroundTransparency = 1
introStatus.Text = "INITIALIZING..."
introStatus.TextColor3 = Color3.fromRGB(200, 220, 235)
introStatus.Font = Enum.Font.Gotham
introStatus.TextSize = 13
introStatus.Parent = introBg

local barBack = Instance.new("Frame")
barBack.Size = UDim2.new(0, 260, 0, 5)
barBack.Position = UDim2.new(0.5, -130, 0.55, 0)
barBack.BackgroundColor3 = Color3.fromRGB(30, 45, 60)
barBack.BorderSizePixel = 0
barBack.Parent = introBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.fromScale(0, 1)
barFill.BackgroundColor3 = Color3.fromRGB(50, 220, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBack

TweenService:Create(
	barFill,
	TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Size = UDim2.fromScale(1, 1)}
):Play()

task.wait(1.5)
introStatus.Text = "WELCOME"
task.wait(0.4)

TweenService:Create(
	introBg,
	TweenInfo.new(0.5),
	{BackgroundTransparency = 1}
):Play()

for _, obj in ipairs(introBg:GetDescendants()) do
	if obj:IsA("TextLabel") then
		TweenService:Create(
			obj,
			TweenInfo.new(0.5),
			{TextTransparency = 1}
		):Play()
	elseif obj:IsA("Frame") then
		TweenService:Create(
			obj,
			TweenInfo.new(0.5),
			{BackgroundTransparency = 1}
		):Play()
	end
end

task.wait(0.55)
introGui:Destroy()

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "KaiHub"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(360, 300)
main.Position = UDim2.new(0.5, -180, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(14, 19, 29)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 190, 220)
stroke.Thickness = 1.5
stroke.Parent = main

-- Draggable header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(20, 30, 44)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.fromOffset(16, 0)
title.BackgroundTransparency = 1
title.Text = "KAI HUB"
title.TextColor3 = Color3.fromRGB(80, 230, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(36, 32)
close.Position = UDim2.new(1, -42, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(170, 55, 65)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.Parent = header
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPosition = main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- WalkSpeed label
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -32, 0, 28)
speedLabel.Position = UDim2.fromOffset(16, 68)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "WALK SPEED: 30"
speedLabel.TextColor3 = Color3.fromRGB(230, 240, 250)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = main

-- WalkSpeed slider
local sliderBack = Instance.new("Frame")
sliderBack.Size = UDim2.new(1, -32, 0, 8)
sliderBack.Position = UDim2.fromOffset(16, 108)
sliderBack.BackgroundColor3 = Color3.fromRGB(40, 52, 68)
sliderBack.BorderSizePixel = 0
sliderBack.Parent = main
Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new((walkSpeed - 1) / 59, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(50, 220, 255)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBack
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

local sliderButton = Instance.new("TextButton")
sliderButton.Size = UDim2.fromOffset(22, 22)
sliderButton.AnchorPoint = Vector2.new(0.5, 0.5)
sliderButton.Position = UDim2.new((walkSpeed - 1) / 59, 0, 0.5, 0)
sliderButton.BackgroundColor3 = Color3.fromRGB(240, 250, 255)
sliderButton.Text = ""
sliderButton.Parent = sliderBack
Instance.new("UICorner", sliderButton).CornerRadius = UDim.new(1, 0)

local sliding = false

local function updateSlider(inputX)
	local left = sliderBack.AbsolutePosition.X
	local width = sliderBack.AbsoluteSize.X
	local alpha = math.clamp((inputX - left) / width, 0, 1)

	walkSpeed = math.floor(1 + alpha * 59 + 0.5)

	sliderFill.Size = UDim2.new(alpha, 0, 1, 0)
	sliderButton.Position = UDim2.new(alpha, 0, 0.5, 0)
	speedLabel.Text = "WALK SPEED: " .. walkSpeed

	-- Directly set Humanoid.WalkSpeed
	if humanoid then
		humanoid.WalkSpeed = walkSpeed
	end
end

sliderButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		sliding = true
		updateSlider(input.Position.X)
	end
end)

sliderBack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		sliding = true
		updateSlider(input.Position.X)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
		updateSlider(input.Position.X)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		sliding = false
	end
end)

-- Infinite Jump + Fly toggle
local movementButton = Instance.new("TextButton")
movementButton.Size = UDim2.new(1, -32, 0, 48)
movementButton.Position = UDim2.fromOffset(16, 145)
movementButton.BackgroundColor3 = Color3.fromRGB(25, 100, 95)
movementButton.Text = "INFINITE JUMP + FLY: OFF"
movementButton.TextColor3 = Color3.new(1, 1, 1)
movementButton.Font = Enum.Font.GothamBold
movementButton.TextSize = 13
movementButton.Parent = main
Instance.new("UICorner", movementButton).CornerRadius = UDim.new(0, 8)

movementButton.MouseButton1Click:Connect(function()
	movementEnabled = not movementEnabled

	if movementEnabled then
		movementButton.Text = "INFINITE JUMP + FLY: ON"
		movementButton.BackgroundColor3 = Color3.fromRGB(0, 150, 125)
	else
		movementButton.Text = "INFINITE JUMP + FLY: OFF"
		movementButton.BackgroundColor3 = Color3.fromRGB(25, 100, 95)
	end
end)

local helpText = Instance.new("TextLabel")
helpText.Size = UDim2.new(1, -32, 0, 65)
helpText.Position = UDim2.fromOffset(16, 205)
helpText.BackgroundTransparency = 1
helpText.Text = "Hold SPACE to jump and fly upward while enabled.\nFor use in your own Roblox Studio experience."
helpText.TextColor3 = Color3.fromRGB(155, 175, 195)
helpText.Font = Enum.Font.Gotham
helpText.TextSize = 11
helpText.TextWrapped = true
helpText.TextXAlignment = Enum.TextXAlignment.Left
helpText.Parent = main

-- Combined Infinite Jump + Fly logic
local spaceHeld = false

UserInputService.InputBegan:Connect(function(input, processed)
	if processed or input.KeyCode ~= Enum.KeyCode.Space then
		return
	end

	spaceHeld = true

	if not movementEnabled or not humanoid or not rootPart then
		return
	end

	humanoid.Jump = true

	local velocity = rootPart.AssemblyLinearVelocity
	rootPart.AssemblyLinearVelocity = Vector3.new(
		velocity.X,
		math.max(velocity.Y, 35) * jumpBoost,
		velocity.Z
	)
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Space then
		spaceHeld = false
	end
end)

RunService.RenderStepped:Connect(function()
	if not movementEnabled or not spaceHeld or not rootPart or not humanoid then
		return
	end

	if humanoid.Health <= 0 then
		return
	end

	local velocity = rootPart.AssemblyLinearVelocity
	rootPart.AssemblyLinearVelocity = Vector3.new(
		velocity.X,
		flySpeed,
		velocity.Z
	)
end)
