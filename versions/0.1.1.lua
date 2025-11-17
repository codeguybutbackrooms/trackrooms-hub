local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("ModernUI") then
    playerGui.ModernUI:Destroy()
end

local modernScreenGui = Instance.new("ScreenGui")
modernScreenGui.Name = "ModernUI"
modernScreenGui.ResetOnSpawn = false
modernScreenGui.Parent = playerGui

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

local floatingCorner = Instance.new("UICorner")
floatingCorner.CornerRadius = UDim.new(0, 100)
floatingCorner.Parent = floatingMinimizedIcon

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

local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 14)
mainFrameCorner.Parent = mainUIFrame

local shadow = Instance.new("ImageLabel")
shadow.Parent = mainUIFrame
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0.5, -20, 0.5, -20)
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.4
shadow.ZIndex = -1

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

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeButton

minimizeButton.MouseButton1Click:Connect(function()
    mainUIFrame.Visible = false
    floatingMinimizedIcon.Visible = true
end)

floatingMinimizedIcon.MouseButton1Click:Connect(function()
    floatingMinimizedIcon.Visible = false
    mainUIFrame.Visible = true
end)

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

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = button

    button.Parent = parentFrame
    return button
end

local function CreateTextInput(parentFrame, placeholder, pos)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 150, 0, 36)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.Text = ""
    box.ClearTextOnFocus = false
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextScaled = true
    box.BorderSizePixel = 0

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = box

    box.Parent = parentFrame
    return box
end

local walkSpeedInput = CreateTextInput(mainUIFrame, "WalkSpeed", UDim2.new(0, 20, 0, 60))
local jumpHeightInput = CreateTextInput(mainUIFrame, "JumpHeight", UDim2.new(0, 20, 0, 110))

local setWalkSpeedButton = CreateButton(mainUIFrame, "SetWalkSpeed", "Set WalkSpeed", UDim2.new(0, 190, 0, 60))
local setJumpHeightButton = CreateButton(mainUIFrame, "SetJumpHeight", "Set JumpHeight", UDim2.new(0, 190, 0, 110))
local infiniteJumpButton = CreateButton(mainUIFrame, "InfiniteJump", "Infinite Jump", UDim2.new(0, 20, 0, 170))
local dashButton = CreateButton(mainUIFrame, "Dash", "Dash (Beta)", UDim2.new(0, 190, 0, 170))

setWalkSpeedButton.MouseButton1Click:Connect(function()
    local n = tonumber(walkSpeedInput.Text)
    if n and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = n
    end
end)

setJumpHeightButton.MouseButton1Click:Connect(function()
    local n = tonumber(jumpHeightInput.Text)
    if n and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.JumpHeight = n
    end
end)

infiniteJumpButton.MouseButton1Click:Connect(function()
    UserInputService.JumpRequest:Connect(function()
        local c = localPlayer.Character
        if c and c:FindFirstChild("Humanoid") then
            c.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

dashButton.MouseButton1Click:Connect(function()
    local c = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local h = c:WaitForChild("Humanoid")
    local r = c:WaitForChild("HumanoidRootPart")

    local anims = {
        Front = "rbxassetid://15938993207",
        Left = "rbxassetid://15938982197",
        Right = "rbxassetid://15939000875",
        Back = "rbxassetid://15939009229"
    }

    local function playDashAnimation(dir)
        local a = Instance.new("Animation")
        a.AnimationId = anims[dir]
        local track = h:LoadAnimation(a)
        track:Play()
    end

    local dir = h.MoveDirection
    if dir.Magnitude == 0 then
        playDashAnimation("Front")
    else
        local lv = c.PrimaryPart.CFrame.LookVector
        local rv = c.PrimaryPart.CFrame.RightVector
        local f = lv:Dot(dir)
        local rdot = rv:Dot(dir)

        if f > 0.7 then
            playDashAnimation("Front")
        elseif f < -0.7 then
            playDashAnimation("Back")
        elseif rdot > 0 then
            playDashAnimation("Right")
        else
            playDashAnimation("Left")
        end
    end

    local dist = 20
    local time = 0.2
    local target = r.Position + dir.Unit * dist

    local tween = TweenService:Create(r, TweenInfo.new(time, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(target, target + r.CFrame.LookVector)
    })
    tween:Play()
end)
