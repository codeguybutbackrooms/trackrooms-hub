local Players = game:GetService("Players")

local TweenService = game:GetService("TweenService")

local UserInputService = game:GetService("UserInputService")


local localPlayer = Players.LocalPlayer

local playerGui = localPlayer:WaitForChild("PlayerGui")


local modernScreenGui = Instance.new("ScreenGui")

modernScreenGui.Name = "ModernUI"

modernScreenGui.ResetOnSpawn = false

modernScreenGui.Parent = playerGui


local floatingMinimizedIcon = Instance.new("TextButton")

floatingMinimizedIcon.Size = UDim2.new(0, 60, 0, 60)

floatingMinimizedIcon.Position = UDim2.new(0, 20, 0, 20)

floatingMinimizedIcon.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

floatingMinimizedIcon.Text = "UI"

floatingMinimizedIcon.TextScaled = true

floatingMinimizedIcon.TextColor3 = Color3.new(1, 1, 1)

floatingMinimizedIcon.Font = Enum.Font.SourceSansBold

floatingMinimizedIcon.Visible = false

floatingMinimizedIcon.Parent = modernScreenGui

floatingMinimizedIcon.Active = true

floatingMinimizedIcon.Draggable = true

floatingMinimizedIcon.BorderSizePixel = 0

floatingMinimizedIcon.BackgroundTransparency = 0.1

floatingMinimizedIcon.Name = "FloatingIcon"


local mainUIFrame = Instance.new("Frame")

mainUIFrame.Size = UDim2.new(0, 320, 0, 240)

mainUIFrame.Position = UDim2.new(0.5, -160, 0.5, -120)

mainUIFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

mainUIFrame.BorderSizePixel = 0

mainUIFrame.Parent = modernScreenGui

mainUIFrame.Active = true

mainUIFrame.Draggable = true

mainUIFrame.ClipsDescendants = true

mainUIFrame.AnchorPoint = Vector2.new(0.5, 0.5)

mainUIFrame.Visible = true

mainUIFrame.Name = "MainFrame"


local mainFrameCorner = Instance.new("UICorner")

mainFrameCorner.CornerRadius = UDim.new(0, 12)

mainFrameCorner.Parent = mainUIFrame


local minimizeButton = Instance.new("TextButton")

minimizeButton.Size = UDim2.new(0, 30, 0, 30)

minimizeButton.Position = UDim2.new(1, -35, 0, 5)

minimizeButton.Text = "–"

minimizeButton.TextScaled = true

minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)

minimizeButton.TextColor3 = Color3.fromRGB(50, 50, 50)

minimizeButton.Font = Enum.Font.SourceSans

minimizeButton.Parent = mainUIFrame

minimizeButton.BorderSizePixel = 0


local minimizeButtonCorner = Instance.new("UICorner")

minimizeButtonCorner.CornerRadius = UDim.new(0, 6)

minimizeButtonCorner.Parent = minimizeButton


minimizeButton.MouseButton1Click:Connect(function()

    mainUIFrame.Visible = false

    floatingMinimizedIcon.Visible = true

end)


floatingMinimizedIcon.MouseButton1Click:Connect(function()

    floatingMinimizedIcon.Visible = false

    mainUIFrame.Visible = true

end)


local function CreateButton(parentFrame, buttonName, buttonText, buttonPosition)

    local button = Instance.new("TextButton")

    button.Name = buttonName

    button.Size = UDim2.new(0, 140, 0, 40)

    button.Position = buttonPosition

    button.Text = buttonText

    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    button.Font = Enum.Font.SourceSansBold

    button.TextScaled = true

    button.BorderSizePixel = 0

    local buttonCorner = Instance.new("UICorner")

    buttonCorner.CornerRadius = UDim.new(0, 8)

    buttonCorner.Parent = button

    button.Parent = parentFrame

    return button

end


local function CreateTextInput(parentFrame, placeholderText, inputPosition)

    local textBox = Instance.new("TextBox")

    textBox.Size = UDim2.new(0, 140, 0, 35)

    textBox.Position = inputPosition

    textBox.PlaceholderText = placeholderText

    textBox.ClearTextOnFocus = false

    textBox.Text = ""

    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    textBox.Font = Enum.Font.SourceSans

    textBox.TextScaled = true

    textBox.BorderSizePixel = 0

    local textBoxCorner = Instance.new("UICorner")

    textBoxCorner.CornerRadius = UDim.new(0, 8)

    textBoxCorner.Parent = textBox

    textBox.Parent = parentFrame

    return textBox

end


local walkSpeedInput = CreateTextInput(mainUIFrame, "WalkSpeed", UDim2.new(0, 10, 0, 50))

local jumpHeightInput = CreateTextInput(mainUIFrame, "JumpHeight", UDim2.new(0, 10, 0, 100))


local setWalkSpeedButton = CreateButton(mainUIFrame, "SetWalkSpeedButton", "Set WalkSpeed", UDim2.new(0, 170, 0, 50))

local setJumpHeightButton = CreateButton(mainUIFrame, "SetJumpHeightButton", "Set JumpHeight", UDim2.new(0, 170, 0, 100))

local infiniteJumpButton = CreateButton(mainUIFrame, "InfiniteJumpButton", "Infinite Jump", UDim2.new(0, 10, 0, 160))

local dashButton = CreateButton(mainUIFrame, "DashButton", "Dash (Beta)", UDim2.new(0, 170, 0, 160))


setWalkSpeedButton.MouseButton1Click:Connect(function()

    local walkSpeed = tonumber(walkSpeedInput.Text)

    if walkSpeed and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then

        localPlayer.Character.Humanoid.WalkSpeed = walkSpeed

    end

end)


setJumpHeightButton.MouseButton1Click:Connect(function()

    local jumpHeight = tonumber(jumpHeightInput.Text)

    if jumpHeight and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then

        localPlayer.Character.Humanoid.JumpHeight = jumpHeight

    end

end)


infiniteJumpButton.MouseButton1Click:Connect(function()

    localPlayer = Players.LocalPlayer

    UserInputService.JumpRequest:Connect(function()

        local character = localPlayer.Character

        if character and character:FindFirstChild("Humanoid") then

            character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

        end

    end)

end)


dashButton.MouseButton1Click:Connect(function()

    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

    local humanoid = character:WaitForChild("Humanoid")

    local rootPart = character:WaitForChild("HumanoidRootPart")

   

    local dashAnimations = {

        Front = "rbxassetid://15938993207",

        Left = "rbxassetid://15938982197",

        Right = "rbxassetid://15939000875",

        Back = "rbxassetid://15939009229"

    }


    local function playDashAnimation(direction)

        local animation = Instance.new("Animation")

        animation.AnimationId = dashAnimations[direction]

        local track = humanoid:LoadAnimation(animation)

        track:Play()

    end


    local moveDirection = humanoid.MoveDirection

    if moveDirection.Magnitude == 0 then

        playDashAnimation("Front")

    else

        local lookVector = character.PrimaryPart.CFrame.LookVector

        local rightVector = character.PrimaryPart.CFrame.RightVector

        local forwardDot = lookVector:Dot(moveDirection)

        local rightDot = rightVector:Dot(moveDirection)

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

    local dashTime = 0.2

    local targetPosition = rootPart.Position + moveDirection.Unit * dashDistance

    local dashTween = TweenService:Create(rootPart, TweenInfo.new(dashTime, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPosition, targetPosition + rootPart.CFrame.LookVector)})

    dashTween:Play()

end)

floatingMinimizedIcon.BorderSizePixel = 0

floatingMinimizedIcon.BackgroundTransparency = 0.1

floatingMinimizedIcon.Name = "FloatingIcon"


local mainUIFrame = Instance.new("Frame")

mainUIFrame.Size = UDim2.new(0, 320, 0, 240)

mainUIFrame.Position = UDim2.new(0.5, -160, 0.5, -120)

mainUIFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

mainUIFrame.BorderSizePixel = 0

mainUIFrame.Parent = modernScreenGui

mainUIFrame.Active = true

mainUIFrame.Draggable = true

mainUIFrame.ClipsDescendants = true

mainUIFrame.AnchorPoint = Vector2.new(0.5, 0.5)

mainUIFrame.Visible = true

mainUIFrame.Name = "MainFrame"


local mainFrameCorner = Instance.new("UICorner")

mainFrameCorner.CornerRadius = UDim.new(0, 12)

mainFrameCorner.Parent = mainUIFrame


local minimizeButton = Instance.new("TextButton")

minimizeButton.Size = UDim2.new(0, 30, 0, 30)

minimizeButton.Position = UDim2.new(1, -35, 0, 5)

minimizeButton.Text = "–"

minimizeButton.TextScaled = true

minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)

minimizeButton.TextColor3 = Color3.fromRGB(50, 50, 50)

minimizeButton.Font = Enum.Font.SourceSans

minimizeButton.Parent = mainUIFrame

minimizeButton.BorderSizePixel = 0


local minimizeButtonCorner = Instance.new("UICorner")

minimizeButtonCorner.CornerRadius = UDim.new(0, 6)

minimizeButtonCorner.Parent = minimizeButton


minimizeButton.MouseButton1Click:Connect(function()

    mainUIFrame.Visible = false

    floatingMinimizedIcon.Visible = true

end)


floatingMinimizedIcon.MouseButton1Click:Connect(function()

    floatingMinimizedIcon.Visible = false

    mainUIFrame.Visible = true

end)


local function CreateButton(parentFrame, buttonName, buttonText, buttonPosition)

    local button = Instance.new("TextButton")

    button.Name = buttonName

    button.Size = UDim2.new(0, 140, 0, 40)

    button.Position = buttonPosition

    button.Text = buttonText

    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    button.Font = Enum.Font.SourceSansBold

    button.TextScaled = true

    button.BorderSizePixel = 0

    local buttonCorner = Instance.new("UICorner")

    buttonCorner.CornerRadius = UDim.new(0, 8)

    buttonCorner.Parent = button

    button.Parent = parentFrame

    return button

end


local function CreateTextInput(parentFrame, placeholderText, inputPosition)

    local textBox = Instance.new("TextBox")

    textBox.Size = UDim2.new(0, 140, 0, 35)

    textBox.Position = inputPosition

    textBox.PlaceholderText = placeholderText

    textBox.ClearTextOnFocus = false

    textBox.Text = ""

    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    textBox.Font = Enum.Font.SourceSans

    textBox.TextScaled = true

    textBox.BorderSizePixel = 0

    local textBoxCorner = Instance.new("UICorner")

    textBoxCorner.CornerRadius = UDim.new(0, 8)

    textBoxCorner.Parent = textBox

    textBox.Parent = parentFrame

    return textBox

end


local walkSpeedInput = CreateTextInput(mainUIFrame, "WalkSpeed", UDim2.new(0, 10, 0, 50))

local jumpHeightInput = CreateTextInput(mainUIFrame, "JumpHeight", UDim2.new(0, 10, 0, 100))


local setWalkSpeedButton = CreateButton(mainUIFrame, "SetWalkSpeedButton", "Set WalkSpeed", UDim2.new(0, 170, 0, 50))

local setJumpHeightButton = CreateButton(mainUIFrame, "SetJumpHeightButton", "Set JumpHeight", UDim2.new(0, 170, 0, 100))

local infiniteJumpButton = CreateButton(mainUIFrame, "InfiniteJumpButton", "Infinite Jump", UDim2.new(0, 10, 0, 160))

local dashButton = CreateButton(mainUIFrame, "DashButton", "Dash (Beta)", UDim2.new(0, 170, 0, 160))


setWalkSpeedButton.MouseButton1Click:Connect(function()

    local walkSpeed = tonumber(walkSpeedInput.Text)

    if walkSpeed and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then

        localPlayer.Character.Humanoid.WalkSpeed = walkSpeed

    end

end)


setJumpHeightButton.MouseButton1Click:Connect(function()

    local jumpHeight = tonumber(jumpHeightInput.Text)

    if jumpHeight and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then

        localPlayer.Character.Humanoid.JumpHeight = jumpHeight

    end

end)


infiniteJumpButton.MouseButton1Click:Connect(function()

    localPlayer = Players.LocalPlayer

    UserInputService.JumpRequest:Connect(function()

        local character = localPlayer.Character

        if character and character:FindFirstChild("Humanoid") then

            character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

        end

    end)

end)


dashButton.MouseButton1Click:Connect(function()

    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

    local humanoid = character:WaitForChild("Humanoid")

    local rootPart = character:WaitForChild("HumanoidRootPart")

   

    local dashAnimations = {

        Front = "rbxassetid://15938993207",

        Left = "rbxassetid://15938982197",

        Right = "rbxassetid://15939000875",

        Back = "rbxassetid://15939009229"

    }


    local function playDashAnimation(direction)

        local animation = Instance.new("Animation")

        animation.AnimationId = dashAnimations[direction]

        local track = humanoid:LoadAnimation(animation)

        track:Play()

    end


    local moveDirection = humanoid.MoveDirection

    if moveDirection.Magnitude == 0 then

        playDashAnimation("Front")

    else

        local lookVector = character.PrimaryPart.CFrame.LookVector

        local rightVector = character.PrimaryPart.CFrame.RightVector

        local forwardDot = lookVector:Dot(moveDirection)

        local rightDot = rightVector:Dot(moveDirection)

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

    local dashTime = 0.2

    local targetPosition = rootPart.Position + moveDirection.Unit * dashDistance

    local dashTween = TweenService:Create(rootPart, TweenInfo.new(dashTime, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPosition, targetPosition + rootPart.CFrame.LookVector)})

    dashTween:Play()

end)

