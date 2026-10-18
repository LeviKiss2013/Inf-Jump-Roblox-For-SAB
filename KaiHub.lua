
-- KAI HUB | CINEMATIC INTRO + MOVEMENT GUI
-- For your own Roblox Studio experience
-- Location: StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local speed = 30
local infiniteJump = false

--==================================================
-- CINEMATIC INTRO
--==================================================

local intro = Instance.new("ScreenGui")
intro.Name = "KaiHubIntro"
intro.IgnoreGuiInset = true
intro.DisplayOrder = 1000
intro.ResetOnSpawn = false
intro.Parent = playerGui

local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.fromRGB(3, 6, 15)
bg.BorderSizePixel = 0
bg.Parent = intro

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(2, 5, 15)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8, 24, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 5, 13))
})
gradient.Rotation = 35
gradient.Parent = bg

local line = Instance.new("Frame")
line.AnchorPoint = Vector2.new(0.5, 0.5)
line.Position = UDim2.new(0.5, 0, 0.24, 0)
line.Size = UDim2.new(0, 0, 0, 3)
line.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
line.BorderSizePixel = 0
line.Parent = bg

local lineStroke = Instance.new("UIStroke")
lineStroke.Color = Color3.fromRGB(0, 150, 255)
lineStroke.Thickness = 4
lineStroke.Transparency = 0.35
lineStroke.Parent = line

local logo = Instance.new("TextLabel")
logo.AnchorPoint = Vector2.new(0.5, 0.5)
logo.Position = UDim2.new(0.5, 0, 0.39, 0)
logo.Size = UDim2.new(0.9, 0, 0, 90)
logo.BackgroundTransparency = 1
logo.Text = "KAI HUB"
logo.TextColor3 = Color3.fromRGB(0, 220, 255)
logo.TextTransparency = 1
logo.Font = Enum.Font.GothamBlack
logo.TextScaled = true
logo.Parent = bg

local logoSize = Instance.new("UITextSizeConstraint")
logoSize.MaxTextSize = 66
logoSize.MinTextSize = 24
logoSize.Parent = logo

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = Color3.fromRGB(0, 100, 255)
logoStroke.Thickness = 1.5
logoStroke.Transparency = 0.2
logoStroke.Parent = logo

local subtitle = Instance.new("TextLabel")
subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
subtitle.Position = UDim2.new(0.5, 0, 0.47, 0)
subtitle.Size = UDim2.new(0.9, 0, 0, 30)
subtitle.BackgroundTransparency = 1
subtitle.Text = "B E T T E R .  F A S T E R .  S T R O N G E R ."
subtitle.TextColor3 = Color3.fromRGB(160, 210, 240)
subtitle.TextTransparency = 1
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextScaled = true
subtitle.Parent = bg

local subSize = Instance.new("UITextSizeConstraint")
subSize.MaxTextSize = 14
subSize.MinTextSize = 9
subSize.Parent = subtitle

local barBack = Instance.new("Frame")
barBack.AnchorPoint = Vector2.new(0.5, 0.5)
barBack.Position = UDim2.new(0.5, 0, 0.59, 0)
barBack.Size = UDim2.new(0.65, 0, 0, 6)
barBack.BackgroundColor3 = Color3.fromRGB(27, 40, 61)
barBack.BorderSizePixel = 0
barBack.Parent = bg

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBack

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBack

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = barFill

local status = Instance.new("TextLabel")
status.AnchorPoint = Vector2.new(0.5, 0.5)
status.Position = UDim2.new(0.5, 0, 0.64, 0)
status.Size = UDim2.new(0.9, 0, 0, 25)
status.BackgroundTransparency = 1
status.Text = "INITIALIZING KAI HUB..."
status.TextColor3 = Color3.fromRGB(130, 170, 205)
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.Parent = bg

TweenService:Create(line, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {
    Size = UDim2.new(0.32, 0, 0, 3)
}):Play()

task.wait(0.3)

TweenService:Create(logo, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {
    TextTransparency = 0
}):Play()

TweenService:Create(subtitle, TweenInfo.new(0.8), {
    TextTransparency = 0
}):Play()

status.Text = "LOADING MOVEMENT MODULES..."

TweenService:Create(barFill, TweenInfo.new(1.8, Enum.EasingStyle.Quint), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

task.wait(1.8)
status.Text = "KAI HUB READY"
task.wait(0.5)

for _, object in ipairs(bg:GetDescendants()) do
    if object:IsA("TextLabel") then
        TweenService:Create(object, TweenInfo.new(0.45), {
            TextTransparency = 1
        }):Play()
    elseif object:IsA("Frame") then
        TweenService:Create(object, TweenInfo.new(0.45), {
            BackgroundTransparency = 1
        }):Play()
    elseif object:IsA("UIStroke") then
        TweenService:Create(object, TweenInfo.new(0.45), {
            Transparency = 1
        }):Play()
    end
end

TweenService:Create(bg, TweenInfo.new(0.5), {
    BackgroundTransparency = 1
}):Play()

task.wait(0.55)
intro:Destroy()

--==================================================
-- MAIN KAI HUB GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "KaiHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(340, 290)
main.Position = UDim2.new(0.5, -170, 0.5, -145)
main.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(0, 190, 255)
outline.Transparency = 0.4
outline.Thickness = 1.2
outline.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundColor3 = Color3.fromRGB(25, 29, 41)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -65, 1, 0)
title.Position = UDim2.fromOffset(16, 0)
title.BackgroundTransparency = 1
title.Text = "KAI HUB"
title.TextColor3 = Color3.fromRGB(0, 220, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 21
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32, 32)
close.Position = UDim2.new(1, -43, 0, 11)
close.BackgroundColor3 = Color3.fromRGB(48, 53, 69)
close.Text = "×"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextSize = 22
close.Parent = header
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Drag window using the header
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

UIS.InputChanged:Connect(function(input)
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

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local section = Instance.new("TextLabel")
section.Size = UDim2.new(1, -32, 0, 25)
section.Position = UDim2.fromOffset(16, 65)
section.BackgroundTransparency = 1
section.Text = "MOVEMENT SETTINGS"
section.TextColor3 = Color3.fromRGB(145, 160, 183)
section.Font = Enum.Font.GothamBold
section.TextSize = 11
section.TextXAlignment = Enum.TextXAlignment.Left
section.Parent = main

-- Speed display
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -32, 0, 28)
speedLabel.Position = UDim2.fromOffset(16, 94)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(240, 243, 255)
speedLabel.Font = Enum.Font.GothamSemibold
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = main

-- Slider
local track = Instance.new("Frame")
track.Size = UDim2.new(1, -40, 0, 8)
track.Position = UDim2.fromOffset(20, 134)
track.BackgroundColor3 = Color3.fromRGB(47, 53, 68)
track.BorderSizePixel = 0
track.Parent = main
Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

local fill = Instance.new("Frame")
fill.Size = UDim2.new(speed / 60, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
fill.BorderSizePixel = 0
fill.Parent = track
Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

local knob = Instance.new("TextButton")
knob.Size = UDim2.fromOffset(18, 18)
knob.AnchorPoint = Vector2.new(0.5, 0.5)
knob.Position = UDim2.new(speed / 60, 0, 0.5, 0)
knob.BackgroundColor3 = Color3.new(1, 1, 1)
knob.Text = ""
knob.Parent = track
Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

local draggingSlider = false

local function setSpeed(value)
    speed = math.clamp(math.round(value), 1, 60)

    speedLabel.Text = "WalkSpeed                         "
        .. speed .. " / 60"

    fill.Size = UDim2.new(speed / 60, 0, 1, 0)
    knob.Position = UDim2.new(speed / 60, 0, 0.5, 0)

    -- Works for the character in your own experience.
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = speed
    end
end

local function updateSlider(x)
    local ratio = math.clamp(
        (x - track.AbsolutePosition.X) / track.AbsoluteSize.X,
        0, 1
    )
    setSpeed(1 + ratio * 59)
end

knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
        updateSlider(input.Position.X)
    end
end)

track.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
        updateSlider(input.Position.X)
    end
end)

UIS.InputChanged:Connect(function(input)
    if draggingSlider and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        updateSlider(input.Position.X)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false
    end
end)

-- Infinite jump toggle
local jumpEnabled = false

local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(1, -32, 0, 43)
jumpButton.Position = UDim2.fromOffset(16, 164)
jumpButton.BackgroundColor3 = Color3.fromRGB(35, 41, 54)
jumpButton.Text = "  Infinite Jump                              OFF"
jumpButton.TextColor3 = Color3.fromRGB(220, 226, 238)
jumpButton.Font = Enum.Font.GothamSemibold
jumpButton.TextSize = 13
jumpButton.TextXAlignment = Enum.TextXAlignment.Left
jumpButton.Parent = main
Instance.new("UICorner", jumpButton).CornerRadius = UDim.new(0, 9)

local indicator = Instance.new("Frame")
indicator.Size = UDim2.fromOffset(8, 8)
indicator.Position = UDim2.new(1, -25, 0.5, -4)
indicator.BackgroundColor3 = Color3.fromRGB(110, 117, 132)
indicator.Parent = jumpButton
Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

jumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled

    jumpButton.Text = "  Infinite Jump                              "
        .. (jumpEnabled and "ON" or "OFF")

    indicator.BackgroundColor3 = jumpEnabled
        and Color3.fromRGB(0, 230, 160)
        or Color3.fromRGB(110, 117, 132)

    jumpButton.BackgroundColor3 = jumpEnabled
        and Color3.fromRGB(24, 58, 55)
        or Color3.fromRGB(35, 41, 54)
end)

UIS.JumpRequest:Connect(function()
    if not jumpEnabled then return end

    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid and humanoid.Health > 0 then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speed
end)

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -32, 0, 20)
footer.Position = UDim2.fromOffset(16, 239)
footer.BackgroundTransparency = 1
footer.Text = "KAI HUB  •  BETTER. FASTER. STRONGER."
footer.TextColor3 = Color3.fromRGB(100, 112, 133)
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.TextXAlignment = Enum.TextXAlignment.Left
footer.Parent = main

-- Set the initial display and speed.
setSpeed(speed)

