local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zap-Zaporium/Zap-is-Me/refs/heads/main/Zaporium.lua"))()

local Window = library:CreateWindow("Shiro Hub (VFB)")

-- ==================== UPGRADE & REBIRTH TOGGLES ====================

local powerLoopRunning = false
local speedLoopRunning = false
local rebirthLoopRunning = false

-- Buy Power +100 Toggle

Window:AddToggle({
    text = 'Collect Cash',
    flag = 'toggle',
    state = false,
    callback = function(p3)
        _G.Cash = p3

        print('Cash: ', p3)

        if p3 then
            Cash()
        end
    end,
})

function Cash()
    spawn(function()
        _G.Cash = true

        while _G.Cash do
            wait()
            pcall(function()
                local v4, v5, v6 = pairs(workspace.Studios:GetChildren())

                while true do
                    local v7

                    v6, v7 = v4(v5, v6)

                    if v6 == nil then
                        break
                    end
                    if v7:GetAttribute('Owner') == game:GetService('Players').LocalPlayer.UserId then
                        local v8, v9, v10 = pairs(v7.Platforms:GetDescendants())

                        while true do
                            local v11

                            v10, v11 = v8(v9, v10)

                            if v10 == nil then
                                break
                            end
                            if v11:IsA('TouchTransmitter') then
                                v11.Parent.CanCollide = false

                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v11.Parent, 0)
                                wait()
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v11.Parent, 1)
                            end
                        end
                    end
                end

                wait(0.1)
            end)
        end
    end)
end


Window:AddToggle({
    text = "Buy Power +100",
    state = false,
    callback = function(state)
        powerLoopRunning = state
        if state then
            task.spawn(function()
                local args = {"VacuumPowerUpgrade2"}
                local remote = game:GetService("ReplicatedStorage")
                    :WaitForChild("Utilities")
                    :WaitForChild("TypedRemote")
                    :WaitForChild("PurchaseUpgrade")
                
                while powerLoopRunning do
                    remote:FireServer(unpack(args))
                    task.wait(1)
                end
            end)
        end
    end
})

-- Buy Speed +1 Toggle
Window:AddToggle({
    text = "Buy Speed +1",
    state = false,
    callback = function(state)
        speedLoopRunning = state
        if state then
            task.spawn(function()
                local args = {"SpeedUpgrade"}
                local remote = game:GetService("ReplicatedStorage")
                    :WaitForChild("Utilities")
                    :WaitForChild("TypedRemote")
                    :WaitForChild("PurchaseUpgrade")
                
                while speedLoopRunning do
                    remote:FireServer(unpack(args))
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- Auto Rebirth Toggle
Window:AddToggle({
    text = "Auto Rebirth",
    state = false,
    callback = function(state)
        rebirthLoopRunning = state
        if state then
            task.spawn(function()
                local remote = game:GetService("ReplicatedStorage")
                    :WaitForChild("Utilities")
                    :WaitForChild("TypedRemote")
                    :WaitForChild("Rebirth")
                
                while rebirthLoopRunning do
                    remote:InvokeServer()
                    task.wait(1)
                end
            end)
        end
    end
})

-- ==================== AUTO RARITY FARM TOGGLES ====================

local autoEnabled = {
    Mythic = false,
    Cosmic = false,
    Secret = false,
    Admin = false,
    Celestial = false,
    Exclusive = false,
    Divine = false
}

local currentFarming = false
local SAFEZONE_CFRAME = CFrame.new(73.92, 54.73, -50.63)

-- Rarity priority: Divine highest → Mythic lowest
local rarityPriority = {
    Divine = 7,
    Exclusive = 6,
    Admin = 5,
    Celestial = 4,
    Secret = 3,
    Cosmic = 2,
    Mythic = 1
}

local function getPureRarity(gradientName: string): string?
    for rarity in pairs(rarityPriority) do
        if gradientName:find(rarity) then
            return rarity
        end
    end
    return nil
end

local function getEnabledEntities()
    local list = {}
    local entitiesFolder = workspace:FindFirstChild("EntitiesFolder")
    if not entitiesFolder then return list end

    for _, entity in ipairs(entitiesFolder:GetChildren()) do
        local mesh = entity:FindFirstChild("Mesh")
        if not mesh then continue end

        local billboard = mesh:FindFirstChild("EntityBillboardTemplate")
        if not billboard then continue end

        local rarityLabel = billboard:FindFirstChild("RarityLabel")
        if not rarityLabel then continue end

        for _, child in ipairs(rarityLabel:GetChildren()) do
            if child.Name:find("Gradient") then
                local rarity = getPureRarity(child.Name)
                if rarity and autoEnabled[rarity] then
                    local prompt = mesh:FindFirstChild("ProximityPrompt")
                    if prompt then
                        table.insert(list, {
                            Entity = entity,
                            Rarity = rarity,
                            Priority = rarityPriority[rarity],
                            Prompt = prompt
                        })
                    end
                    break
                end
            end
        end
    end

    table.sort(list, function(a, b)
        return a.Priority > b.Priority
    end)

    return list
end

local function teleportTo(entity)
    local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root and entity then
        local pos = entity:GetPivot().Position
        root.CFrame = CFrame.new(pos.X, pos.Y + 6, pos.Z)
    end
end

local function farmLoop()
    while currentFarming do
        local targets = getEnabledEntities()
        if #targets == 0 then
            task.wait(1)
            continue
        end

        for _, data in ipairs(targets) do
            if not currentFarming then break end

            print(`Farming: {data.Entity.Name} → {data.Rarity}`)

            teleportTo(data.Entity)
            task.wait(0.8)

            if data.Prompt then
                data.Prompt:InputHoldBegin()
                task.wait(data.Prompt.HoldDuration + 0.4)
                data.Prompt:InputHoldEnd()
            end

            task.wait(1.0)

            local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = SAFEZONE_CFRAME
            end

            task.wait(1.5)
        end
    end
end

-- Auto Rarity Toggles
Window:AddToggle({
    text = "Auto Mythic",
    state = false,
    callback = function(state)
        autoEnabled.Mythic = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

Window:AddToggle({
    text = "Auto Cosmic",
    state = false,
    callback = function(state)
        autoEnabled.Cosmic = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

Window:AddToggle({
    text = "Auto Secret",
    state = false,
    callback = function(state)
        autoEnabled.Secret = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

Window:AddToggle({
    text = "Auto Admin",
    state = false,
    callback = function(state)
        autoEnabled.Admin = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

Window:AddToggle({
    text = "Auto Celestial",
    state = false,
    callback = function(state)
        autoEnabled.Celestial = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

Window:AddToggle({
    text = "Auto Exclusive",
    state = false,
    callback = function(state)
        autoEnabled.Exclusive = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

Window:AddToggle({
    text = "Auto Divine",
    state = false,
    callback = function(state)
        autoEnabled.Divine = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

Window:AddToggle({
    text = "Auto GOD",
    state = false,
    callback = function(state)
        autoEnabled.GOD = state
        if state and not currentFarming then
            currentFarming = true
            task.spawn(farmLoop)
        elseif not state then
            local anyOn = false
            for _, v in pairs(autoEnabled) do if v then anyOn = true break end end
            if not anyOn then currentFarming = false end
        end
    end
})

-- Credit
Window:AddLabel({text = "Made by TenshiDev"})

-- Initialize GUI
library:Init()

print("TenshiDev GUI Loaded with Upgrades + Auto Farm!")
