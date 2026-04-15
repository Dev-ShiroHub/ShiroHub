--// Shiro Hub | Speed & Jump
--// Made By TenshiDevelopment Team

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local originalWalkSpeed = humanoid.WalkSpeed
local originalJumpHeight = humanoid.JumpHeight

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShiroHubController"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local menuToggle = Instance.new("TextButton")
menuToggle.Name = "SpeedMenuToggle"
menuToggle.Size = UDim2.new(0, 50, 0, 50)
menuToggle.Position = UDim2.new(0.02, 0, 0.85, 0)
menuToggle.Text = "🐺"
menuToggle.TextSize = 24
menuToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
menuToggle.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
menuToggle.BorderSizePixel = 0
menuToggle.Parent = screenGui

local speedMenu = Instance.new("Frame")
speedMenu.Name = "SpeedMenu"
speedMenu.Size = UDim2.new(0, 220, 0, 320)
speedMenu.Position = UDim2.new(0.02, 0, 0.85, -330)
speedMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
speedMenu.BackgroundTransparency = 0.1
speedMenu.BorderSizePixel = 0
speedMenu.Visible = false
speedMenu.Parent = screenGui

local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 40)
titleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = speedMenu

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.Text = "ShiroHub | Speed & Jump"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.BackgroundTransparency = 1
titleText.Parent = titleFrame

local currentSpeedDisplay = Instance.new("Frame")
currentSpeedDisplay.Size = UDim2.new(1, -20, 0, 50)
currentSpeedDisplay.Position = UDim2.new(0, 10, 0, 50)
currentSpeedDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
currentSpeedDisplay.BorderSizePixel = 0
currentSpeedDisplay.Parent = speedMenu

local currentSpeedLabel = Instance.new("TextLabel")
currentSpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
currentSpeedLabel.Position = UDim2.new(0, 10, 0, 0)
currentSpeedLabel.Text = "Current Speed"
currentSpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
currentSpeedLabel.TextSize = 14
currentSpeedLabel.Font = Enum.Font.Gotham
currentSpeedLabel.BackgroundTransparency = 1
currentSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
currentSpeedLabel.Parent = currentSpeedDisplay

local currentSpeedValue = Instance.new("TextLabel")
currentSpeedValue.Size = UDim2.new(0.5, -10, 1, 0)
currentSpeedValue.Position = UDim2.new(0.5, 0, 0, 0)
currentSpeedValue.Text = tostring(math.floor(humanoid.WalkSpeed))
currentSpeedValue.TextColor3 = Color3.fromRGB(255, 255, 0)
currentSpeedValue.TextSize = 20
currentSpeedValue.Font = Enum.Font.GothamBold
currentSpeedValue.BackgroundTransparency = 1
currentSpeedValue.TextXAlignment = Enum.TextXAlignment.Right
currentSpeedValue.Parent = currentSpeedDisplay

local speedInputFrame = Instance.new("Frame")
speedInputFrame.Size = UDim2.new(1, -20, 0, 50)
speedInputFrame.Position = UDim2.new(0, 10, 0, 110)
speedInputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
speedInputFrame.BorderSizePixel = 0
speedInputFrame.Parent = speedMenu

local speedInputLabel = Instance.new("TextLabel")
speedInputLabel.Size = UDim2.new(0.4, 0, 1, 0)
speedInputLabel.Position = UDim2.new(0, 10, 0, 0)
speedInputLabel.Text = "WalkSpeed"
speedInputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedInputLabel.TextSize = 14
speedInputLabel.Font = Enum.Font.Gotham
speedInputLabel.BackgroundTransparency = 1
speedInputLabel.TextXAlignment = Enum.TextXAlignment.Left
speedInputLabel.Parent = speedInputFrame

local speedInputBox = Instance.new("TextBox")
speedInputBox.Size = UDim2.new(0.6, -20, 0.7, 0)
speedInputBox.Position = UDim2.new(0.4, 0, 0.15, 0)
speedInputBox.Text = "50"
speedInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedInputBox.TextSize = 16
speedInputBox.Font = Enum.Font.Gotham
speedInputBox.Parent = speedInputFrame

local jumpInputFrame = Instance.new("Frame")
jumpInputFrame.Size = UDim2.new(1, -20, 0, 50)
jumpInputFrame.Position = UDim2.new(0, 10, 0, 170)
jumpInputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
jumpInputFrame.BorderSizePixel = 0
jumpInputFrame.Parent = speedMenu

local jumpInputLabel = Instance.new("TextLabel")
jumpInputLabel.Size = UDim2.new(0.4, 0, 1, 0)
jumpInputLabel.Position = UDim2.new(0, 10, 0, 0)
jumpInputLabel.Text = "JumpHeight"
jumpInputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
jumpInputLabel.TextSize = 14
jumpInputLabel.Font = Enum.Font.Gotham
jumpInputLabel.BackgroundTransparency = 1
jumpInputLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpInputLabel.Parent = jumpInputFrame

local jumpInputBox = Instance.new("TextBox")
jumpInputBox.Size = UDim2.new(0.6, -20, 0.7, 0)
jumpInputBox.Position = UDim2.new(0.4, 0, 0.15, 0)
jumpInputBox.Text = tostring(math.floor(humanoid.JumpHeight))
jumpInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpInputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
jumpInputBox.TextSize = 16
jumpInputBox.Font = Enum.Font.Gotham
jumpInputBox.Parent = jumpInputFrame

local setButton = Instance.new("TextButton")
setButton.Size = UDim2.new(1, -20, 0, 45)
setButton.Position = UDim2.new(0, 10, 0, 230)
setButton.Text = "APPLY SPEED & JUMP"
setButton.TextColor3 = Color3.fromRGB(255, 255, 255)
setButton.TextSize = 16
setButton.Font = Enum.Font.GothamBold
setButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
setButton.BorderSizePixel = 0
setButton.Parent = speedMenu

local resetButton = Instance.new("TextButton")
resetButton.Size = UDim2.new(1, -20, 0, 30)
resetButton.Position = UDim2.new(0, 10, 0, 285)
resetButton.Text = "RESET TO DEFAULT"
resetButton.TextColor3 = Color3.fromRGB(255, 200, 200)
resetButton.TextSize = 12
resetButton.Font = Enum.Font.Gotham
resetButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
resetButton.BorderSizePixel = 0
resetButton.Parent = speedMenu

local notificationFrame = Instance.new("Frame")
notificationFrame.Size = UDim2.new(0, 280, 0, 60)
notificationFrame.Position = UDim2.new(0.5, -140, 0.8, 0)
notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 40, 30)
notificationFrame.BackgroundTransparency = 1
notificationFrame.Visible = false
notificationFrame.Parent = screenGui

local notificationText = Instance.new("TextLabel")
notificationText.Size = UDim2.new(1, -20, 1, -20)
notificationText.Position = UDim2.new(0, 10, 0, 10)
notificationText.Text = ""
notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
notificationText.TextSize = 14
notificationText.Font = Enum.Font.Gotham
notificationText.BackgroundTransparency = 1
notificationText.TextWrapped = true
notificationText.Parent = notificationFrame

local isMenuOpen = false
local currentSpeed = humanoid.WalkSpeed

local function showNotification(message, color)
    notificationText.Text = message
    notificationFrame.BackgroundColor3 = color or Color3.fromRGB(30, 40, 30)
    notificationFrame.Visible = true
    TweenService:Create(notificationFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    
    task.delay(2.5, function()
        TweenService:Create(notificationFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        notificationFrame.Visible = false
    end)
end

local function applySpeedAndJump()
    if not humanoid then return end
    
    local speed = tonumber(speedInputBox.Text)
    local jump = tonumber(jumpInputBox.Text)
    
    if speed then
        speed = math.clamp(speed, 0, 500)
        humanoid.WalkSpeed = speed
        currentSpeed = speed
        currentSpeedValue.Text = tostring(math.floor(speed))
    end
    
    if jump and jump > 0 then
        humanoid.JumpHeight = jump
    end
    
    showNotification("Applied! Speed: " .. (speed or "—") .. " | Jump: " .. (jump or "—"), Color3.fromRGB(30, 60, 30))
end

local function resetToDefault()
    if not humanoid then return end
    humanoid.WalkSpeed = originalWalkSpeed
    humanoid.JumpHeight = originalJumpHeight
    currentSpeed = originalWalkSpeed
    
    currentSpeedValue.Text = tostring(math.floor(originalWalkSpeed))
    speedInputBox.Text = tostring(originalWalkSpeed)
    jumpInputBox.Text = tostring(math.floor(originalJumpHeight))
    
    showNotification("Reset to Default", Color3.fromRGB(40, 40, 60))
end

local function toggleMenu()
    isMenuOpen = not isMenuOpen
    speedMenu.Visible = isMenuOpen
    
    if isMenuOpen then
        menuToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        TweenService:Create(speedMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.02, 0, 0.85, -320)
        }):Play()
    else
        menuToggle.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
        TweenService:Create(speedMenu, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.02, 0, 0.85, -330)
        }):Play()
    end
end

menuToggle.MouseButton1Click:Connect(toggleMenu)
setButton.MouseButton1Click:Connect(applySpeedAndJump)

resetButton.MouseButton1Click:Connect(resetToDefault)

speedInputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then applySpeedAndJump() end
end)

jumpInputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then applySpeedAndJump() end
end)

for _, box in pairs({speedInputBox, jumpInputBox}) do
    box:GetPropertyChangedSignal("Text"):Connect(function()
        local text = box.Text
        local filtered = text:gsub("[^0-9-]", "")
        if filtered \~= text then
            box.Text = filtered
        end
        if #filtered > 5 then
            box.Text = filtered:sub(1,5)
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.S and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        toggleMenu()
    elseif input.KeyCode == Enum.KeyCode.R and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        resetToDefault()
    elseif input.KeyCode == Enum.KeyCode.Return and isMenuOpen then
        applySpeedAndJump()
    end
end)

RunService.Heartbeat:Connect(function()
    if humanoid and math.abs(humanoid.WalkSpeed - currentSpeed) > 0.1 then
        currentSpeed = humanoid.WalkSpeed
        currentSpeedValue.Text = tostring(math.floor(currentSpeed))
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    originalWalkSpeed = humanoid.WalkSpeed
    originalJumpHeight = humanoid.JumpHeight
    currentSpeed = originalWalkSpeed
    
    currentSpeedValue.Text = tostring(math.floor(originalWalkSpeed))
    speedInputBox.Text = tostring(originalWalkSpeed)
    jumpInputBox.Text = tostring(math.floor(originalJumpHeight))
end)

local function addVisualEffects()
    local function corner(obj, r) 
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r or 8)
        c.Parent = obj 
    end
    local function stroke(obj)
        local s = Instance.new("UIStroke")
        s.Color = Color3.fromRGB(0,0,0)
        s.Thickness = 1.5
        s.Transparency = 0.4
        s.Parent = obj
    end

    corner(menuToggle, 12)
    stroke(menuToggle)
    corner(speedMenu, 12)
    stroke(speedMenu)
    corner(titleFrame, 0)
    corner(currentSpeedDisplay, 8)
    corner(speedInputFrame, 8)
    corner(jumpInputFrame, 8)
    corner(speedInputBox, 6)
    corner(jumpInputBox, 6)
    corner(setButton, 8)
    corner(resetButton, 6)
    corner(notificationFrame, 12)
end

addVisualEffects()

menuToggle.MouseEnter:Connect(function()
    TweenService:Create(menuToggle, TweenInfo.new(0.2), {BackgroundColor3 = isMenuOpen and Color3.fromRGB(220,80,80) or Color3.fromRGB(60,140,220)}):Play()
end)
menuToggle.MouseLeave:Connect(function()
    TweenService:Create(menuToggle, TweenInfo.new(0.2), {BackgroundColor3 = isMenuOpen and Color3.fromRGB(200,60,60) or Color3.fromRGB(40,120,200)}):Play()
end)

setButton.MouseEnter:Connect(function()
    TweenService:Create(setButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,180,255)}):Play()
end)
setButton.MouseLeave:Connect(function()
    TweenService:Create(setButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,150,255)}):Play()
end)

task.wait(1)
showNotification("Shiro Hub | Speed & Jump Controller Loaded Successfully!", Color3.fromRGB(40, 40, 60))

task.wait(1)
showNotification("Credits to: TenshiDevelopment Team", Color3.fromRGB(40, 40, 60))
