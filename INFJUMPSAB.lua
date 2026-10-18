
-- Infinite Jump + Fly
-- Place in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local character
local humanoid
local rootPart

local flying = false
local jumpBoost = 1.5
local flySpeed = 45

local function setupCharacter(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
	rootPart = char:WaitForChild("HumanoidRootPart")
	flying = false
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed or input.KeyCode ~= Enum.KeyCode.Space then
		return
	end

	if not humanoid or not rootPart then
		return
	end

	-- Jump again, even while airborne
	humanoid.Jump = true

	-- Give the jump extra airtime
	local velocity = rootPart.AssemblyLinearVelocity
	rootPart.AssemblyLinearVelocity = Vector3.new(
		velocity.X,
		math.max(velocity.Y, 35) * jumpBoost,
		velocity.Z
	)

	flying = true
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Space then
		flying = false
	end
end)

RunService.RenderStepped:Connect(function()
	if not flying or not rootPart or not humanoid then
		return
	end

	if humanoid.Health <= 0 then
		flying = false
		return
	end

	-- Hold Space to fly upward
	local velocity = rootPart.AssemblyLinearVelocity
	rootPart.AssemblyLinearVelocity = Vector3.new(
		velocity.X,
		flySpeed,
		velocity.Z
	)
end)
