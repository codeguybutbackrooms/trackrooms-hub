--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Remove existing UI
if playerGui:FindFirstChild("ModernUI") then
    playerGui.ModernUI:Destroy()
end

--// ScreenGui
local modernScreenGui = Instance.new("ScreenGui")
modernScreenGui.Name = "ModernUI"
modernScreenGui.ResetOnSpawn = false
modernScreenGui.Parent = playerGui

--// Floating minimized icon
local floatingMinimizedIcon = Instance.new("TextButton")
floatingMinimizedIcon.Name = "FloatingIcon"
floatingMinimizedIcon.Size = UDim2.new(0, 60, 0, 60)
floatingMinimizedIcon.Position = UDim2.new(0, 20, 0, 20)
floatingMinimizedIcon.Text = "UI"
floatingMinimizedIcon.TextScaled = true
floatingMinimizedIcon.TextColor3 = Color3.fromRGB(255,255,255)
floatingMinimizedIcon.Font = Enum.Font.GothamBold
floatingMinimizedIcon.Visible = false
floatingMinimizedIcon.BackgroundTransparency = 0
floatingMinimizedIcon.Parent = modernScreenGui
floatingMinimizedIcon.Active = true
floatingMinimizedIcon.Draggable = true
floatingMinimizedIcon.BorderSizePixel = 0
floatingMinimizedIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

-- Floating icon styling
Instance.new("UICorner", floatingMinimizedIcon).CornerRadius = UDim.new(0, 100)

local iconStroke = Instance.new("UIStroke", floatingMinimizedIcon)
iconStroke.Color = Color3.fromRGB(0, 140, 255)
iconStroke.Thickness = 2
iconStroke.Transparency = 0.25

local iconGradient = Instance.new("UIGradient", floatingMinimizedIcon)
iconGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25,25,35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40,40,50))
}

---------------------------------------------------------------------
-- MAIN FRAME
---------------------------------------------------------------------
local mainUIFrame = Instance.new("Frame")
mainUIFrame.Name = "MainFrame"
mainUIFrame.Size = UDim2.new(0, 360, 0, 260)
mainUIFrame.Position = UDim2.new(0.5, -180, 0.5, -130)
mainUIFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
mainUIFrame.BorderSizePixel = 0
mainUIFrame.Parent = modernScreenGui
mainUIFrame.Active = true
mainUIFrame.Draggable = true
mainUIFrame.ClipsDescendants = true
mainUIFrame.AnchorPoint = Vector2.new(0.5, 0.5)
---------------------------------------------------------------------
-- SCROLLABLE CONTENT AREA
---------------------------------------------------------------------
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentScroll"
contentFrame.Parent = mainUIFrame
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 6
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local list = Instance.new("UIListLayout")
list.Parent = contentFrame
list.Padding = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder

local padding = Instance.new("UIPadding", contentFrame)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingTop = UDim.new(0, 10)

-- Auto resize scroll
list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 20)
end)
Instance.new("UICorner", mainUIFrame).CornerRadius = UDim.new(0, 18)

-- Frame glow stroke
local frameStroke = Instance.new("UIStroke", mainUIFrame)
frameStroke.Color = Color3.fromRGB(0, 120, 255)
frameStroke.Thickness = 2
frameStroke.Transparency = 0.35

-- Frame gradient
local frameGradient = Instance.new("UIGradient", mainUIFrame)
frameGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15,15,20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30,30,35))
}

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Parent = mainUIFrame
shadow.BackgroundTransparency = 1
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0.5, -20, 0.5, -20)
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.new(0,0,0)
shadow.ImageTransparency = 0.45
shadow.ZIndex = -1

---------------------------------------------------------------------
-- MINIMIZE BUTTON
---------------------------------------------------------------------
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinButton"
minimizeButton.Size = UDim2.new(0, 32, 0, 32)
minimizeButton.Position = UDim2.new(1, -40, 0, 8)
minimizeButton.Text = "–"
minimizeButton.TextScaled = true
minimizeButton.BackgroundColor3 = Color3.fromRGB(30,30,40)
minimizeButton.TextColor3 = Color3.new(1,1,1)
minimizeButton.Font = Enum.Font.Gotham
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = mainUIFrame

Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 8)

local minStroke = Instance.new("UIStroke", minimizeButton)
minStroke.Color = Color3.fromRGB(0,150,255)
minStroke.Thickness = 1.6
minStroke.Transparency = 0.3

-- Hover animation
minimizeButton.MouseEnter:Connect(function()
    TweenService:Create(minimizeButton, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(40,40,55)
    }):Play()
end)

minimizeButton.MouseLeave:Connect(function()
    TweenService:Create(minimizeButton, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(30,30,40)
    }):Play()
end)

minimizeButton.MouseButton1Click:Connect(function()
    mainUIFrame.Visible = false
    floatingMinimizedIcon.Visible = true
end)

floatingMinimizedIcon.MouseButton1Click:Connect(function()
    floatingMinimizedIcon.Visible = false
    mainUIFrame.Visible = true
end)

---------------------------------------------------------------------
-- UI HELPERS
---------------------------------------------------------------------

local function CreateButton(parent, name, text, pos)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 150, 0, 42)
    button.Position = pos
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- BRIGHT WHITE
    button.TextTransparency = 0                          -- fully visible
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    button.BorderSizePixel = 0
    button.Parent = parent

    -- Rounded corners
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 12)

    -- Stroke for glow
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = Color3.fromRGB(0, 150, 255)
    stroke.Thickness = 1.8
    stroke.Transparency = 0.25

    -- Background gradient

    local bgFrame = Instance.new("Frame")
    bgFrame.Size = UDim2.new(1,0,1,0)
    bgFrame.Position = UDim2.new(0,0,0,0)
    bgFrame.BackgroundTransparency = 1
    bgFrame.Parent = button

    local gradient = Instance.new("UIGradient", bgFrame)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40,40,55))
    }
    -- Hover animation
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        }):Play()
    end)

    return button
end

local function CreateTextInput(parent, placeholder, pos)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 150, 0, 38)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.BackgroundColor3 = Color3.fromRGB(25,25,30)
    box.ClearTextOnFocus = false
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
    box.Font = Enum.Font.Gotham
    box.TextScaled = true
    box.BorderSizePixel = 0
    box.Parent = parent
    
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Color3.fromRGB(90,90,90)
    stroke.Thickness = 1.6
    stroke.Transparency = 0.4

    -- Focus animation
    box.Focused:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.15), {
            Color = Color3.fromRGB(0,150,255),
            Transparency = 0.15
        }):Play()
    end)

    box.FocusLost:Connect(function()
        TweenService:Create(stroke, TweenInfo.new(0.15), {
            Color = Color3.fromRGB(90,90,90),
            Transparency = 0.4
        }):Play()
    end)

    return box
end

---------------------------------------------------------------------
-- INPUTS + BUTTONS
---------------------------------------------------------------------
local walkSpeedInput = CreateTextInput(contentFrame, "WalkSpeed", UDim2.new(0, 20, 0, 60))
local jumpHeightInput = CreateTextInput(contentFrame, "JumpHeight", UDim2.new(0, 20, 0, 110))

local setWalkSpeedButton = CreateButton(contentFrame, "SetWalkSpeed", "Set WalkSpeed", UDim2.new(0, 190, 0, 60))
local setJumpHeightButton = CreateButton(contentFrame, "SetJumpHeight", "Set JumpHeight", UDim2.new(0, 190, 0, 110))
local infiniteJumpButton = CreateButton(contentFrame, "InfiniteJump", "Infinite Jump", UDim2.new(0, 20, 0, 170))
local dashButton = CreateButton(contentFrame, "Dash", "Dash", UDim2.new(0, 190, 0, 170))
local fovInput = CreateTextInput(contentFrame, "Enter FOV", UDim2.new(0, 20, 0, 220))
local setFOVButton = CreateButton(contentFrame, "SetFOV", "Set FOV", UDim2.new(0, 190, 0, 220))
local antiAFKButton = CreateButton(contentFrame, "AntiAFK", "Anti-AFK", UDim2.new(0,0,0,0))
local noclipButton = CreateButton(contentFrame, "Btn_Noclip", "Noclip", UDim2.new(0,0,0,0))
local instantInteractButton = CreateButton(contentFrame, "InstantInteract", "Instant Interact", UDim2.new(0, 20, 0, 280))

---------------------------------------------------------------------
-- WALK SPEED
---------------------------------------------------------------------
setWalkSpeedButton.MouseButton1Click:Connect(function()
    local n = tonumber(walkSpeedInput.Text)
    local char = localPlayer.Character
    if n and char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = n
    end
end)

---------------------------------------------------------------------
-- JUMP HEIGHT
---------------------------------------------------------------------
setJumpHeightButton.MouseButton1Click:Connect(function()
    local n = tonumber(jumpHeightInput.Text)
    local char = localPlayer.Character
    if n and char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpHeight = n
    end
end)

---------------------------------------------------------------------
-- INFINITE JUMP (safe)
---------------------------------------------------------------------
local infiniteJumpEnabled = false
local infiniteJumpConnection

infiniteJumpButton.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled

    infiniteJumpButton.Text = infiniteJumpEnabled and "Infinite Jump: ON" or "Infinite Jump"

    if infiniteJumpEnabled then
        infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            local c = localPlayer.Character
            local h = c and c:FindFirstChild("Humanoid")
            if h then
                h:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if infiniteJumpConnection then infiniteJumpConnection:Disconnect() end
    end
end)

---------------------------------------------------------------------
-- DASH
---------------------------------------------------------------------
dashButton.MouseButton1Click:Connect(function()
    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")

    local move = humanoid.MoveDirection
    if move.Magnitude < 0.1 then
        move = root.CFrame.LookVector
    end

    -- Choose animation direction
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
---------------------------------------------------------------------
-- FOV
---------------------------------------------------------------------
setFOVButton.MouseButton1Click:Connect(function()
    local n = tonumber(fovInput.Text)
    if n then
        n = math.clamp(n, 10, 120) -- Optional clamp to avoid extreme FOV values
        local camera = workspace.CurrentCamera
        if camera then
            camera.FieldOfView = n
        end
    end
end)
---------------------------------------------------------------------
-- ANTI-AFK SYSTEM
---------------------------------------------------------------------
local vu = game:GetService("VirtualUser")
local antiAFKEnabled = false
local antiAFKConnection = nil
antiAFKButton.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled

    antiAFKButton.Text = antiAFKEnabled and "Anti-AFK: ON" or "Anti-AFK"

    if antiAFKEnabled then
        antiAFKConnection = game:GetService("Players").LocalPlayer.Idle:Connect(function()
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
    end
end)
---------------------------------------------------------------------
-- NO-CLIP
---------------------------------------------------------------------
local noclipEnabled = false
local NoclipConnection = nil

noclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled

    if noclipEnabled then
        EnableNoclip()
        noclipButton.Text = "Noclip: ON"
    else
        DisableNoclip()
        noclipButton.Text = "Noclip"
    end
end)

function EnableNoclip()
    if NoclipConnection then return end

    NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if not char then return end

        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end)
end
function DisableNoclip()
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
end
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if noclipEnabled then
        task.wait(0.5)
        EnableNoclip()
    end
end)
---------------------------------------------------------------------
-- INSTANT INTERACT
---------------------------------------------------------------------
local ProximityPromptService = game:GetService("ProximityPromptService")
local instantInteractEnabled = false
local instantInteractConnection = nil

local function EnableInstantInteract()
    if instantInteractConnection then return end

    instantInteractConnection =
        ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
        end)
end

local function DisableInstantInteract()
    if instantInteractConnection then
        instantInteractConnection:Disconnect()
        instantInteractConnection = nil
    end
end

instantInteractButton.MouseButton1Click:Connect(function()
    instantInteractEnabled = not instantInteractEnabled

    if instantInteractEnabled then
        instantInteractButton.Text = "Instant Interact: ON"
        EnableInstantInteract()
    else
        instantInteractButton.Text = "Instant Interact"
        DisableInstantInteract()
    end
end)
