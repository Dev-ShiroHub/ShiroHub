local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-ShiroHub/ShiroHub/refs/heads/main/ShiroHub-Library/ShiroHubLib2.luau"))()
local Window = library:CreateWindow("Shiro Hub")

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local safeZoneCFrame = CFrame.new(196.59, 10.68, 282.22)
local friendsFolder = workspace:WaitForChild("Live"):WaitForChild("Friends")

local tweenInfoFast = TweenInfo.new(0.45, Enum.EasingStyle.Linear)

local isStealing = false
local stealCooldowns = {}

local function TryStealFriend(friend, rarityText, rarityKey)
    if isStealing then return false end
    isStealing = true
   
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") or character.Humanoid.Health <= 0 then
        isStealing = false
        return false
    end
    local hrp = character.HumanoidRootPart
   
    local rootPart = friend:FindFirstChild("RootPart")
    if not rootPart then isStealing = false return false end
   
    local prompt = rootPart:FindFirstChild("StealPrompt")
    if not prompt or not prompt:IsA("ProximityPrompt") then isStealing = false return false end
   
    task.defer(function()
        hrp.CFrame = rootPart.CFrame * CFrame.new(0, 4, 0)
        task.wait(0.15)
       
        prompt.MaxActivationDistance = 999
        prompt.RequiresLineOfSight = false
        prompt.HoldDuration = 0
        pcall(function() fireproximityprompt(prompt) end)
       
        task.wait(0.70)
       
        local currentPos = hrp.Position
        local y715CFrame = CFrame.new(currentPos.X, 715.0, currentPos.Z)
        local tweenY = TweenService:Create(hrp, tweenInfoFast, {CFrame = y715CFrame})
        tweenY:Play()
        tweenY.Completed:Wait()
       
        local tweenSafe = TweenService:Create(hrp, tweenInfoFast, {CFrame = safeZoneCFrame})
        tweenSafe:Play()
        tweenSafe.Completed:Wait()
       
        task.wait(0.1)
       
        print("✅ Stolen: " .. friend.Name .. " (" .. rarityText .. ") [PROMPT FIXED]")
       
        stealCooldowns[rarityKey] = tick() + 5
        isStealing = false
    end)
   
    return true
end

local autoLoops = {}
local function StartAuto(rarityKeyword, toggleState)
    local key = rarityKeyword:lower()
    if autoLoops[key] then autoLoops[key]:Disconnect() autoLoops[key] = nil end
    if not toggleState then return end
   
    print("✅ Auto " .. rarityKeyword .. " ENABLED (prompt fixed + fast cycle)")
   
    autoLoops[key] = RunService.Heartbeat:Connect(function()
        if stealCooldowns[key] and tick() < stealCooldowns[key] then return end
        if isStealing then return end
       
        for _, friend in ipairs(friendsFolder:GetChildren()) do
            local rarityObj = friend:FindFirstChild("FriendBillboard", true)
                       and friend.FriendBillboard:FindFirstChild("Frame", true)
                       and friend.FriendBillboard.Frame:FindFirstChild("Rarity")
           
            if not rarityObj then continue end
           
            local rarityText = rarityObj.Text or "???"
            local lower = rarityText:lower()
           
            if lower:find(key) then
                local stolen = TryStealFriend(friend, rarityText, key)
                if stolen then break end
            end
        end
        task.wait(0.3)
    end)
end

local upgradeLoop = nil
Window:AddToggle({
    text = "Buy Jump +10",
    state = false,
    callback = function(v)
        if upgradeLoop then upgradeLoop:Disconnect() upgradeLoop = nil end
        if v then
            print("✅ Upgrade Jump +10 ENABLED (fires every 2s)")
            upgradeLoop = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local rem = game:GetService("ReplicatedStorage")
                        :WaitForChild("SharedModules")
                        :WaitForChild("Network")
                        :WaitForChild("Remotes")
                    rem:WaitForChild("Buy Speed Upgrade"):FireServer(3)
                end)
                task.wait(2)
            end)
        end
    end
}

local rebirthLoop = nil
Window:AddToggle({
    text = "Auto Rebirth",
    state = false,
    callback = function(v)
        if rebirthLoop then rebirthLoop:Disconnect() rebirthLoop = nil end
        if v then
            print("✅ Auto Rebirth ENABLED (fires every 2s)")
            rebirthLoop = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local rem = game:GetService("ReplicatedStorage")
                        :WaitForChild("SharedModules")
                        :WaitForChild("Network")
                        :WaitForChild("Remotes")
                    rem:WaitForChild("Rebirth"):FireServer()
                end)
                task.wait(2)
            end)
        end
    end
})

Window:AddToggle({ text = "Auto Secret", state = false, callback = function(v) StartAuto("secret", v) end })
Window:AddToggle({ text = "Auto God", state = false, callback = function(v) StartAuto("brainrot god", v) end })
Window:AddToggle({ text = "Auto Exclusive", state = false, callback = function(v) StartAuto("exclusive", v) end })
Window:AddToggle({ text = "Auto OG", state = false, callback = function(v) StartAuto("og", v) end })
Window:AddToggle({ text = "Auto Divine", state = false, callback = function(v) StartAuto("divine", v) end })

Window:AddLabel({text = "Made by TenshiDev"})
library:Init()
print("✅ TenshiDev GUI Loaded - Upgrades + Rebirth + Auto Divine added!")
