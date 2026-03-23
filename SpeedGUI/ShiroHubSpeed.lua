--// Shiro Hub | Speed Gui
--// made by TenshiDev

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local originalWalkSpeed = humanoid.WalkSpeed
local originalJumpPower = humanoid.JumpPower

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedControlGUI"
screenGui.Parent = player.PlayerGui

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
speedMenu.Size = UDim2.new(0, 200, 0, 250)
speedMenu.Position = UDim2.new(0.02, 0, 0.85, -260)
speedMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
speedMenu.BackgroundTransparency = 0.1
speedMenu.BorderSizePixel = 0
speedMenu.Visible = false
speedMenu.Parent = screenGui

local titleFrame = Instance.new("Frame")
titleFrame.Name = "Title"
titleFrame.Size = UDim2.new(1, 0, 0, 40)
titleFrame.Position = UDim2.new(0, 0, 0, 0)
titleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = speedMenu

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.Text = "ShiroHub | SpeedGUI"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.BackgroundTransparency = 1
titleText.Parent = titleFrame

local currentSpeedDisplay = Instance.new("Frame")
currentSpeedDisplay.Name = "CurrentSpeed"
currentSpeedDisplay.Size = UDim2.new(1, -20, 0, 50)
currentSpeedDisplay.Position = UDim2.new(0, 10, 0, 50)
currentSpeedDisplay.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
currentSpeedDisplay.BorderSizePixel = 0
currentSpeedDisplay.Parent = speedMenu

local currentSpeedLabel = Instance.new("TextLabel")
currentSpeedLabel.Name = "CurrentLabel"
currentSpeedLabel.Size = UDim2.new(0.4, 0, 1, 0)
currentSpeedLabel.Position = UDim2.new(0, 10, 0, 0)
currentSpeedLabel.Text = "Speed"
currentSpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
currentSpeedLabel.TextSize = 14
currentSpeedLabel.Font = Enum.Font.Gotham
currentSpeedLabel.BackgroundTransparency = 1
currentSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
currentSpeedLabel.Parent = currentSpeedDisplay

local currentSpeedValue = Instance.new("TextLabel")
currentSpeedValue.Name = "CurrentValue"
currentSpeedValue.Size = UDim2.new(0.6, -10, 1, 0)
currentSpeedValue.Position = UDim2.new(0.4, 0, 0, 0)
currentSpeedValue.Text = tostring(math.floor(humanoid.WalkSpeed))
currentSpeedValue.TextColor3 = Color3.fromRGB(255, 255, 0)
currentSpeedValue.TextSize = 20
currentSpeedValue.Font = Enum.Font.GothamBold
currentSpeedValue.BackgroundTransparency = 1
currentSpeedValue.TextXAlignment = Enum.TextXAlignment.Right
currentSpeedValue.Parent = currentSpeedDisplay

local inputFrame = Instance.new("Frame")
inputFrame.Name = "SpeedInput"
inputFrame.Size = UDim2.new(1, -20, 0, 50)
inputFrame.Position = UDim2.new(0, 10, 0, 110)
inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = speedMenu

local inputLabel = Instance.new("TextLabel")
inputLabel.Name = "InputLabel"
inputLabel.Size = UDim2.new(0.4, 0, 1, 0)
inputLabel.Position = UDim2.new(0, 10, 0, 0)
inputLabel.Text = "Input Speed"
inputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
inputLabel.TextSize = 14
inputLabel.Font = Enum.Font.Gotham
inputLabel.BackgroundTransparency = 1
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = inputFrame

local speedInputBox = Instance.new("TextBox")
speedInputBox.Name = "SpeedInputBox"
speedInputBox.Size = UDim2.new(0.6, -20, 0.7, 0)
speedInputBox.Position = UDim2.new(0.4, 0, 0.15, 0)
speedInputBox.Text = "50"
speedInputBox.PlaceholderText = "Input Speed Here!"
speedInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedInputBox.BorderSizePixel = 0
speedInputBox.TextSize = 16
speedInputBox.Font = Enum.Font.Gotham
speedInputBox.Parent = inputFrame

local setSpeedButton = Instance.new("TextButton")
setSpeedButton.Name = "SetSpeedButton"
setSpeedButton.Size = UDim2.new(1, -20, 0, 45)
setSpeedButton.Position = UDim2.new(0, 10, 0, 170)
setSpeedButton.Text = "SET SPEED"
setSpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
setSpeedButton.TextSize = 16
setSpeedButton.Font = Enum.Font.GothamBold
setSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
setSpeedButton.BorderSizePixel = 0
setSpeedButton.Parent = speedMenu

local presetButtonsFrame = Instance.new("Frame")
presetButtonsFrame.Name = "PresetButtons"
presetButtonsFrame.Size = UDim2.new(1, -20, 0, 35)
presetButtonsFrame.Position = UDim2.new(0, 10, 0, 225)
presetButtonsFrame.BackgroundTransparency = 1
presetButtonsFrame.Parent = speedMenu

local presets = {
    {Name = "Slow", Value = 16, Color = Color3.fromRGB(100, 150, 255)},
    {Name = "Normal", Value = 50, Color = Color3.fromRGB(0, 200, 100)},
    {Name = "Fast", Value = 100, Color = Color3.fromRGB(255, 150, 0)},
    {Name = "Extreme", Value = 200, Color = Color3.fromRGB(255, 50, 50)}
}

for i, preset in ipairs(presets) do
    local presetBtn = Instance.new("TextButton")
    presetBtn.Name = preset.Name .. "Preset"
    presetBtn.Size = UDim2.new(0.23, -2, 1, 0)
    presetBtn.Position = UDim2.new(0.23 * (i-1), 0, 0, 0)
    presetBtn.Text = preset.Name
    presetBtn.TextSize = 12
    presetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    presetBtn.BackgroundColor3 = preset.Color
    presetBtn.Font = Enum.Font.Gotham
    presetBtn.Parent = presetButtonsFrame
    
    presetBtn.MouseButton1Click:Connect(function()
        speedInputBox.Text = tostring(preset.Value)
        applySpeed(preset.Value)
    end)
end

local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(1, -20, 0, 30)
resetButton.Position = UDim2.new(0, 10, 0, 190)
resetButton.Text = "RESET TO DEFAULT"
resetButton.TextColor3 = Color3.fromRGB(255, 200, 200)
resetButton.TextSize = 12
resetButton.Font = Enum.Font.Gotham
resetButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
resetButton.BorderSizePixel = 0
resetButton.Parent = speedMenu

local notificationFrame = Instance.new("Frame")
notificationFrame.Name = "Notification"
notificationFrame.Size = UDim2.new(0, 250, 0, 60)
notificationFrame.Position = UDim2.new(0.5, -125, 0.8, 0)
notificationFrame.BackgroundColor3 = Color3.fromRGB(30, 40, 30)
notificationFrame.BackgroundTransparency = 1
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
notificationFrame.Parent = screenGui

local notificationText = Instance.new("TextLabel")
notificationText.Name = "NotificationText"
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
    
    notificationFrame.BackgroundTransparency = 0.2
    TweenService:Create(notificationFrame, TweenInfo.new(0.3), {
        BackgroundTransparency = 0
    }):Play()
    
    task.wait(2)
    
    TweenService:Create(notificationFrame, TweenInfo.new(0.3), {
        BackgroundTransparency = 1
    }):Play()
    
    task.wait(0.3)
    notificationFrame.Visible = false
end

local function applySpeed(speedValue)
    if not character or not humanoid then return end
    
    speedValue = tonumber(speedValue)
    if not speedValue then
        showNotification("idk 2", Color3.fromRGB(80, 40, 40))
        return
    end
    
    speedValue = math.clamp(speedValue, 0, 500)
    
    humanoid.WalkSpeed = speedValue
    currentSpeed = speedValue
    
    currentSpeedValue.Text = tostring(math.floor(speedValue))
    speedInputBox.Text = tostring(speedValue)
    
    currentSpeedValue.TextColor3 = Color3.fromRGB(0, 255, 150)
    task.wait(0.1)
    currentSpeedValue.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    showNotification("Your Speed Right Now is: " .. math.floor(speedValue), Color3.fromRGB(30, 60, 30))
end

local function resetToDefault()
    humanoid.WalkSpeed = originalWalkSpeed
    humanoid.JumpPower = originalJumpPower
    currentSpeed = originalWalkSpeed
    
    currentSpeedValue.Text = tostring(math.floor(originalWalkSpeed))
    speedInputBox.Text = tostring(originalWalkSpeed)
    
    showNotification("Successfully Reseted to: " .. originalWalkSpeed, Color3.fromRGB(40, 40, 60))
end

local function toggleMenu()
    isMenuOpen = not isMenuOpen
    
    if isMenuOpen then
        speedMenu.Visible = true
        menuToggle.Text = "🐺"
        menuToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        
        speedMenu.Position = UDim2.new(0.02, 0, 0.85, -260)
        TweenService:Create(speedMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.02, 0, 0.85, -250)
        }):Play()
        
        currentSpeedValue.Text = tostring(math.floor(humanoid.WalkSpeed))
        
    else
        menuToggle.Text = "🐺"
        menuToggle.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
        
        TweenService:Create(speedMenu, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0.02, 0, 0.85, -260)
        }):Play()
        
        task.wait(0.2)
        speedMenu.Visible = false
    end
end

menuToggle.MouseButton1Click:Connect(toggleMenu)
setSpeedButton.MouseButton1Click:Connect(function()
    applySpeed(speedInputBox.Text)
end)

resetButton.MouseButton1Click:Connect(resetToDefault)

speedInputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        applySpeed(speedInputBox.Text)
    end
end)

speedInputBox:GetPropertyChangedSignal("Text"):Connect(function()
    local text = speedInputBox.Text
    
    local filtered = ""
    for i = 1, #text do
        local char = text:sub(i, i)
        if tonumber(char) or char == "" or (i == 1 and char == "-") then
            filtered = filtered .. char
        end
    end
    
    if filtered ~= text then
        speedInputBox.Text = filtered
    end
    
    if #filtered > 4 then
        speedInputBox.Text = filtered:sub(1, 4)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.S and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        toggleMenu()
            
    elseif input.KeyCode == Enum.KeyCode.R and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        resetToDefault()
    
    elseif input.KeyCode == Enum.KeyCode.Return and isMenuOpen then
        applySpeed(speedInputBox.Text)
    end
end)

RunService.Heartbeat:Connect(function()
    if character and humanoid then
        local currentWalkSpeed = humanoid.WalkSpeed
        
        if math.abs(currentWalkSpeed - currentSpeed) > 0.1 then
            currentSpeed = currentWalkSpeed
            currentSpeedValue.Text = tostring(math.floor(currentWalkSpeed))
            
            currentSpeedValue.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.wait(0.05)
            currentSpeedValue.TextColor3 = Color3.fromRGB(255, 255, 0)
        end
    end
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    
    originalWalkSpeed = humanoid.WalkSpeed
    originalJumpPower = humanoid.JumpPower
    currentSpeed = originalWalkSpeed
    
    if currentSpeedValue then
        currentSpeedValue.Text = tostring(math.floor(currentSpeed))
        speedInputBox.Text = tostring(currentSpeed)
    end
end)

local function addVisualEffects()
    local function addCorner(obj, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = obj
    end
    
    local function addShadow(obj)
        local shadow = Instance.new("UIStroke")
        shadow.Color = Color3.fromRGB(0, 0, 0)
        shadow.Thickness = 2
        shadow.Transparency = 0.3
        shadow.Parent = obj
    end
    
    addCorner(menuToggle, 10)
    addShadow(menuToggle)
    
    addCorner(speedMenu, 10)
    addShadow(speedMenu)
    
    addCorner(titleFrame, 10)
    
    addCorner(currentSpeedDisplay, 8)
    addShadow(currentSpeedDisplay)
    
    addCorner(inputFrame, 8)
    addShadow(inputFrame)
    
    addCorner(speedInputBox, 6)

    addCorner(setSpeedButton, 8)
    addShadow(setSpeedButton)
    
    addCorner(resetButton, 6)
    addShadow(resetButton)
    
    for _, child in ipairs(presetButtonsFrame:GetChildren()) do
        if child:IsA("TextButton") then
            addCorner(child, 6)
            addShadow(child)
        end
    end
    
    addCorner(notificationFrame, 10)
    addShadow(notificationFrame)
end

addVisualEffects()

menuToggle.MouseEnter:Connect(function()
    TweenService:Create(menuToggle, TweenInfo.new(0.2), {
        BackgroundColor3 = isMenuOpen and Color3.fromRGB(220, 80, 80) or Color3.fromRGB(60, 140, 220)
    }):Play()
end)

menuToggle.MouseLeave:Connect(function()
    TweenService:Create(menuToggle, TweenInfo.new(0.2), {
        BackgroundColor3 = isMenuOpen and Color3.fromRGB(200, 60, 60) or Color3.fromRGB(40, 120, 200)
    }):Play()
end)

setSpeedButton.MouseEnter:Connect(function()
    TweenService:Create(setSpeedButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    }):Play()
end)

setSpeedButton.MouseLeave:Connect(function()
    TweenService:Create(setSpeedButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    }):Play()
end)

task.wait(1)
showNotification("Welcome To Speed GUI Control By: TenshiDev.", Color3.fromRGB(40, 40, 60))

print("Speed Control GUI | Shiro Hub success loaded.")
print("Shortcuts From this Speed Gui ‹ Shortcuts: Ctrl+S (Toggle Menu) | Ctrl+R (Reset) | Enter (Apply)")
