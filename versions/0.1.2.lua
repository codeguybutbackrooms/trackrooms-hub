local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("ModernUI") then
    playerGui.ModernUI:Destroy()
end

local modernScreenGui = Instance.new("ScreenGui")
modernScreenGui.Name = "ModernUI"
modernScreenGui.ResetOnSpawn = false
modernScreenGui.Parent = playerGui
modernScreenGui.IgnoreGuiInset = true

local function NewUICorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function NewUIStroke(parent, thickness, color, transparency)
    local s = Instance.new("UIStroke")
    s.Thickness = thickness or 2
    s.Color = color or Color3.fromRGB(0, 255, 255)
    s.Transparency = transparency or 0
    s.Parent = parent
    return s
end

local function NewGradient(parent, colorSequence, rotation)
    local g = Instance.new("UIGradient")
    g.Color = colorSequence
    if rotation then
        g.Rotation = rotation
    end
    g.Parent = parent
    return g
end

local floatingMinimizedIcon = Instance.new("TextButton")
floatingMinimizedIcon.Name = "FloatingIcon"
floatingMinimizedIcon.Size = UDim2.new(0, 64, 0, 64)
floatingMinimizedIcon.Position = UDim2.new(0, 16, 0, 18)
floatingMinimizedIcon.AnchorPoint = Vector2.new(0, 0)
floatingMinimizedIcon.BackgroundTransparency = 0
floatingMinimizedIcon.BackgroundColor3 = Color3.fromRGB(10,10,10)
floatingMinimizedIcon.Text = "Tech"
floatingMinimizedIcon.Font = Enum.Font.GothamBold
floatingMinimizedIcon.TextScaled = true
floatingMinimizedIcon.TextColor3 = Color3.fromRGB(255,255,255)
floatingMinimizedIcon.Parent = modernScreenGui
floatingMinimizedIcon.ZIndex = 10
floatingMinimizedIcon.AutoButtonColor = false
floatingMinimizedIcon.Active = true
floatingMinimizedIcon.Draggable = true
NewUICorner(floatingMinimizedIcon, 100)
NewUIStroke(floatingMinimizedIcon, 2, Color3.fromRGB(85, 200, 255), 0)
NewGradient(floatingMinimizedIcon, ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 180))
}, 45)

local mainUIFrame = Instance.new("Frame")
mainUIFrame.Name = "MainFrame"
mainUIFrame.Size = UDim2.new(0, 420, 0, 300)
mainUIFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
mainUIFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainUIFrame.BackgroundTransparency = 0
mainUIFrame.BackgroundColor3 = Color3.fromRGB(12,12,12)
mainUIFrame.BorderSizePixel = 0
mainUIFrame.Parent = modernScreenGui
mainUIFrame.Active = true
mainUIFrame.Draggable = true
mainUIFrame.ClipsDescendants = true
mainUIFrame.Visible = true
NewUICorner(mainUIFrame, 18)

local blurFrame = Instance.new("Frame")
blurFrame.Name = "Glass"
blurFrame.Size = UDim2.new(1, -20, 1, -20)
blurFrame.Position = UDim2.new(0, 10, 0, 10)
blurFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
blurFrame.BackgroundTransparency = 0.15
blurFrame.BorderSizePixel = 0
blurFrame.Parent = mainUIFrame
NewUICorner(blurFrame, 14)

local glassGradient = NewGradient(blurFrame, ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 10, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 200))
}, 90)
glassGradient.Transparency = NumberSequence.new(0.78, 0.88)

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundTransparency = 1
header.Parent = blurFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0.6, -20, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TECH HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(220, 245, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Size = UDim2.new(0.4, -20, 1, 0)
subtitle.Position = UDim2.new(0.6, 12, 0, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Neon · Modern · Smooth"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextColor3 = Color3.fromRGB(160, 220, 255)
subtitle.TextXAlignment = Enum.TextXAlignment.Right
subtitle.Parent = header

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Size = UDim2.new(0, 36, 0, 36)
minimizeButton.Position = UDim2.new(1, -46, 0, 12)
minimizeButton.AnchorPoint = Vector2.new(1,0)
minimizeButton.BackgroundTransparency = 0
minimizeButton.BackgroundColor3 = Color3.fromRGB(20,20,30)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "—"
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.TextSize = 22
minimizeButton.TextColor3 = Color3.fromRGB(200, 240, 255)
minimizeButton.Parent = header
NewUICorner(minimizeButton, 8)
NewUIStroke(minimizeButton, 1.5, Color3.fromRGB(85,200,255), 0.25)
local minGrad = NewGradient(minimizeButton, ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,80,200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,160,220))
}, 45)
minGrad.Transparency = NumberSequence.new(0.6)

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -24, 1, -84)
content.Position = UDim2.new(0, 12, 0, 72)
content.BackgroundTransparency = 1
content.Parent = blurFrame

local leftCol = Instance.new("Frame")
leftCol.Name = "Left"
leftCol.Size = UDim2.new(0, 200, 1, 0)
leftCol.Position = UDim2.new(0, 0, 0, 0)
leftCol.BackgroundTransparency = 1
leftCol.Parent = content

local rightCol = Instance.new("Frame")
rightCol.Name = "Right"
rightCol.Size = UDim2.new(1, -210, 1, 0)
rightCol.Position = UDim2.new(0, 210, 0, 0)
rightCol.BackgroundTransparency = 1
rightCol.Parent = content

local function CreateCard(parent, posY, titleText)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 72)
    card.Position = UDim2.new(0, 0, 0, posY)
    card.BackgroundColor3 = Color3.fromRGB(18,18,24)
    card.BorderSizePixel = 0
    card.Parent = parent
    NewUICorner(card, 12)
    NewUIStroke(card, 1, Color3.fromRGB(60,160,255), 0.5)
    local g = NewGradient(card, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30,10,80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,120,200))
    }, 90)
    g.Transparency = NumberSequence.new(0.8, 0.9)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -16, 1, -12)
    t.Position = UDim2.new(0, 12, 0, 8)
    t.BackgroundTransparency = 1
    t.Text = titleText
    t.Font = Enum.Font.GothamSemibold
    t.TextSize = 16
    t.TextColor3 = Color3.fromRGB(220,240,255)
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = card
    return card
end

local card1 = CreateCard(leftCol, 0, "Movement")
local card2 = CreateCard(leftCol, 86, "Toggles")
local card3 = CreateCard(leftCol, 172, "Settings")

local function CreateInput(parent, y, placeholder)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -12, 0, 36)
    box.Position = UDim2.new(0, 6, 0, y)
    box.BackgroundColor3 = Color3.fromRGB(12,12,18)
    box.BorderSizePixel = 0
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Font = Enum.Font.Gotham
    box.TextSize = 16
    box.TextColor3 = Color3.fromRGB(220,240,255)
    box.ClearTextOnFocus = false
    box.Parent = rightCol
    NewUICorner(box, 10)
    NewUIStroke(box, 1, Color3.fromRGB(60,160,255), 0.6)
    local g = NewGradient(box, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,50,120)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,140,200))
    }, 90)
    g.Transparency = NumberSequence.new(0.85)
    return box
end

local function CreateBigButton(parent, y, text)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 44)
    b.Position = UDim2.new(0, 6, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(0,0,0)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.TextColor3 = Color3.fromRGB(220,240,255)
    b.Parent = parent
    NewUICorner(b, 10)
    NewUIStroke(b, 2, Color3.fromRGB(85,200,255), 0.35)
    local g = NewGradient(b, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30,0,130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,160,220))
    }, 45)
    g.Transparency = NumberSequence.new(0.4, 0.1)
    return b
end

local walkSpeedInput = CreateInput(rightCol, 4, "WalkSpeed (numeric)")
local jumpHeightInput = CreateInput(rightCol, 50, "JumpHeight (numeric)")
local setWalkSpeedButton = CreateBigButton(rightCol, 98, "Set WalkSpeed")
local setJumpHeightButton = CreateBigButton(rightCol, 150, "Set JumpHeight")
local infiniteJumpButton = CreateBigButton(rightCol, 202, "Toggle Infinite Jump")
local dashButton = CreateBigButton(rightCol, 254, "Dash (Beta)")

local function tweenButtonHover(btn, enter)
    local goal = {}
    if enter then
        goal.BackgroundTransparency = 0
        goal.Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset + 6, btn.Size.Y.Scale, btn.Size.Y.Offset + 6)
        goal.TextColor3 = Color3.fromRGB(255,255,255)
    else
        goal.BackgroundTransparency = 0
        goal.Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset - 6, btn.Size.Y.Scale, btn.Size.Y.Offset - 6)
        goal.TextColor3 = Color3.fromRGB(220,240,255)
    end
    TweenService:Create(btn, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
end

local function attachHover(btn)
    btn.MouseEnter:Connect(function()
        tweenButtonHover(btn, true)
    end)
    btn.MouseLeave:Connect(function()
        tweenButtonHover(btn, false)
    end)
end

attachHover(setWalkSpeedButton)
attachHover(setJumpHeightButton)
attachHover(infiniteJumpButton)
attachHover(dashButton)
attachHover(minimizeButton)
attachHover(floatingMinimizedIcon)

local function showMain()
    mainUIFrame.Visible = true
    floatingMinimizedIcon.Visible = false
    mainUIFrame.Size = UDim2.new(0, 420, 0, 300)
    TweenService:Create(mainUIFrame, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Rotation = 0}):Play()
end

local function hideMain()
    mainUIFrame.Visible = false
    floatingMinimizedIcon.Visible = true
end

minimizeButton.MouseButton1Click:Connect(hideMain)
floatingMinimizedIcon.MouseButton1Click:Connect(showMain)

local function safeNumber(text)
    if not text then return nil end
    local n = tonumber(text)
    return n
end

setWalkSpeedButton.MouseButton1Click:Connect(function()
    local n = safeNumber(walkSpeedInput.Text)
    if n and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = n
        TweenService:Create(setWalkSpeedButton, TweenInfo.new(0.12), {BackgroundTransparency = 0.2}):Play()
        delay(0.18, function() TweenService:Create(setWalkSpeedButton, TweenInfo.new(0.12), {BackgroundTransparency = 0}):Play() end)
    end
end)

setJumpHeightButton.MouseButton1Click:Connect(function()
    local n = safeNumber(jumpHeightInput.Text)
    if n and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.JumpHeight = n
        TweenService:Create(setJumpHeightButton, TweenInfo.new(0.12), {BackgroundTransparency = 0.2}):Play()
        delay(0.18, function() TweenService:Create(setJumpHeightButton, TweenInfo.new(0.12), {BackgroundTransparency = 0}):Play() end)
    end
end)

local infiniteJumpEnabled = false
local jumpConnection

infiniteJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    if infiniteJumpEnabled then
        if not jumpConnection then
            jumpConnection = UserInputService.JumpRequest:Connect(function()
                local c = localPlayer.Character
                if c and c:FindFirstChild("Humanoid") then
                    c.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
        infiniteJumpButton.Text = "Infinite Jump: ON"
    else
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
        infiniteJumpButton.Text = "Infinite Jump: OFF"
    end
end)

local dashCooldown = false

dashButton.MouseButton1Click:Connect(function()
    if dashCooldown then return end
    dashCooldown = true
    delay(0.45, function() dashCooldown = false end)
    local c = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local h = c:WaitForChild("Humanoid")
    local r = c:WaitForChild("HumanoidRootPart")
    local moveDirection = h.MoveDirection
    local anims = {
        Front = "rbxassetid://15938993207",
        Left = "rbxassetid://15938982197",
        Right = "rbxassetid://15939000875",
        Back = "rbxassetid://15939009229"
    }
    local function playDashAnimation(direction)
        local a = Instance.new("Animation")
        a.AnimationId = anims[direction]
        local track = h:LoadAnimation(a)
        track:Play()
    end
    if moveDirection.Magnitude == 0 then
        playDashAnimation("Front")
    else
        local lv = c.PrimaryPart.CFrame.LookVector
        local rv = c.PrimaryPart.CFrame.RightVector
        local forwardDot = lv:Dot(moveDirection)
        local rightDot = rv:Dot(moveDirection)
        if forwardDot > 0.7 then
            playDashAnimation("Front")
        elseif forwardDot < -0.7 then
            playDashAnimation("Back")
        elseif rightDot > 0 then
            playDashAnimation("Right")
        else
            playDashAnimation("Left")
        end
    end
    local dashDistance = 20
    local dashTime = 0.18
    local safeDir = moveDirection.Magnitude > 0 and moveDirection.Unit or (c.PrimaryPart.CFrame.LookVector)
    local targetPos = r.Position + safeDir * dashDistance
    local tween = TweenService:Create(r, TweenInfo.new(dashTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = CFrame.new(targetPos, targetPos + r.CFrame.LookVector)
    })
    tween:Play()
end)

local function pulseFloating()
    while modernScreenGui.Parent and floatingMinimizedIcon do
        TweenService:Create(floatingMinimizedIcon, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 70, 0, 70)}):Play()
        wait(2)
    end
end

spawn(function()
    pcall(pulseFloating)
end)

local function safeDestroy()
    if modernScreenGui and modernScreenGui.Parent then
        modernScreenGui:Destroy()
    end
end

RunService:BindToRenderStep("ModernUIK", Enum.RenderPriority.First.Value, function() end)
