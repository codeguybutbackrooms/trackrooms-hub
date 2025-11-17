local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Remove existing UI
if playerGui:FindFirstChild("ModernUI") then
    playerGui.ModernUI:Destroy()
end

local modernScreenGui = Instance.new("ScreenGui")
modernScreenGui.Name = "ModernUI"
modernScreenGui.ResetOnSpawn = false
modernScreenGui.Parent = playerGui

-- Floating icon
local floatingMinimizedIcon = Instance.new("TextButton")
floatingMinimizedIcon.Name = "FloatingIcon"
floatingMinimizedIcon.Size = UDim2.new(0, 60, 0, 60)
floatingMinimizedIcon.Position = UDim2.new(0, 20, 0, 20)
floatingMinimizedIcon.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
floatingMinimizedIcon.Text = "UI"
floatingMinimizedIcon.TextScaled = true
floatingMinimizedIcon.TextColor3 = Color3.new(1, 1, 1)
floatingMinimizedIcon.Font = Enum.Font.GothamBold
floatingMinimizedIcon.Visible = false
floatingMinimizedIcon.Parent = modernScreenGui
floatingMinimizedIcon.Active = true
floatingMinimizedIcon.Draggable = true
floatingMinimizedIcon.BorderSizePixel = 0
floatingMinimizedIcon.BackgroundTransparency = 0.15

Instance.new("UICorner", floatingMinimizedIcon).CornerRadius = UDim.new(0, 100)

-- Main frame
local mainUIFrame = Instance.new("Frame")
mainUIFrame.Name = "MainFrame"
mainUIFrame.Size = UDim2.new(0, 360, 0, 260)
mainUIFrame.Position = UDim2.new(0.5, -180, 0.5, -130)
mainUIFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainUIFrame.BorderSizePixel = 0
mainUIFrame.Parent = modernScreenGui
mainUIFrame.Active = true
mainUIFrame.Draggable = true
mainUIFrame.ClipsDescendants = true
mainUIFrame.AnchorPoint = Vector2.new(0.5, 0.5)
Instance.new("UICorner", mainUIFrame).CornerRadius = UDim.new(0, 14)

local shadow = Instance.new("ImageLabel")
shadow.Parent = mainUIFrame
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0.5, -20, 0.5, -20)
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.4
shadow.ZIndex = -1

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinButton"
minimizeButton.Size = UDim2.new(0, 32, 0, 32)
minimizeButton.Position = UDim2.new(1, -40, 0, 8)
minimizeButton.Text = "–"
minimizeButton.TextScaled = true
minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = mainUIFrame
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

minimizeButton.MouseButton1Click:Connect(function()
    mainUIFrame.Visible = false
    floatingMinimizedIcon.Visible = true
end)

floatingMinimizedIcon.MouseButton1Click:Connect(function()
    floatingMinimizedIcon.Visible = false
    mainUIFrame.Visible = true
end)

-- UI helper functions
local function CreateButton(parentFrame, name, text, pos)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 150, 0, 40)
    button.Position = pos
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.BorderSizePixel = 0
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)
    button.Parent = parentFrame
    return button
end

local function CreateTextInput(parentFrame, placeholder, pos)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 150, 0, 36)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.ClearTextOnFocus = false
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextScaled = true
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)
    box.Parent = parentFrame
    return box
end

-- Inputs
local walkSpeedInput = CreateTextInput(mainUIFrame, "WalkSpeed", UDim2.new(0, 20, 0, 60))
local jumpHeightInput = CreateTextInput(mainUIFrame, "JumpHeight", UDim2.new(0, 20, 0, 110))

-- Buttons
local setWalkSpeedButton = CreateButton(mainUIFrame, "SetWalkSpeed", "Set WalkSpeed", UDim2.new(0, 190, 0, 60))
local setJumpHeightButton = CreateButton(mainUIFrame, "SetJumpHeight", "Set JumpHeight", UDim2.new(0, 190, 0, 110))
local infiniteJumpButton = CreateButton(mainUIFrame, "InfiniteJump", "Infinite Jump", UDim2.new(0, 20, 0, 170))
local dashButton = CreateButton(mainUIFrame, "Dash", "Dash", UDim2.new(0, 190, 0, 170))

-- WalkSpeed
setWalkSpeedButton.MouseButton1Click:Connect(function()
    local n = tonumber(walkSpeedInput.Text)
    local char = localPlayer.Character
    if n and char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = n
    end
end)

-- Jump Height
setJumpHeightButton.MouseButton1Click:Connect(function()
    local n = tonumber(jumpHeightInput.Text)
    local char = localPlayer.Character
    if n and char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpHeight = n
    end
end)

--------------------------------------------------------
-- SAFE INFINITE JUMP (no event stacking)
--------------------------------------------------------
local infiniteJumpEnabled = false
local infiniteJumpConnection

infiniteJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled

    if infiniteJumpEnabled then
        infiniteJumpButton.Text = "Infinite Jump: ON"
        infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            local c = localPlayer.Character
            local h = c and c:FindFirstChild("Humanoid")
            if h then
                h:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        infiniteJumpButton.Text = "Infinite Jump"
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
        end
    end
end)

--------------------------------------------------------
-- DASH (safer, no nil Unit errors)
--------------------------------------------------------
dashButton.MouseButton1Click:Connect(function()
    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")

    local move = humanoid.MoveDirection
    if move.Magnitude < 0.1 then
        move = root.CFrame.LookVector
    end

    -- Dash animation selection
    local dotF = root.CFrame.LookVector:Dot(move)
    local dotR = root.CFrame.RightVector:Dot(move)

    local anims = {
        Front = "rbxassetid://15938993207",
        Left  = "rbxassetid://15938982197",
        Right = "rbxassetid://15939000875",
        Back  = "rbxassetid://15939009229"
    }

    local animName =
        (dotF >  0.6 and "Front") or
        (dotF < -0.6 and "Back")  or
        (dotR >  0   and "Right") or
        "Left"

    local anim = Instance.new("Animation")
    anim.AnimationId = anims[animName]
    humanoid:LoadAnimation(anim):Play()

    -- Tween Dash
    local distance = 20
    local time = 0.2
    local target = root.Position + move.Unit * distance

    local tween = TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(target, target + root.CFrame.LookVector)
    })
    tween:Play()
end)
