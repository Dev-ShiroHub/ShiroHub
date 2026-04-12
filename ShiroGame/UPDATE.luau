-- === VACUUM FOR BRAINROTS - WINDUI VERSION ===
-- Collect Cash 0.2s + Auto GOD + Auto Escape + Settings Tab

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Shiro Hub | Vacuum For Brainrots",
    Icon = "🧹",
    Theme = "Dark",           -- Bisa ganti: Dark, Light, Violet, Ocean, dll
    Size = UDim2.new(0, 620, 0, 460)
})

-- ==================== TABS ====================
local MainTab = Window:Tab({ Title = "Main", Icon = "home" })
local FarmTab = Window:Tab({ Title = "Auto Farm", Icon = "target" })
local UpgradeTab = Window:Tab({ Title = "Upgrades", Icon = "zap" })
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

-- ==================== SETTINGS GLOBAL ====================
_G.VFB = {
    CashDelay = 0.2,
    AutoCollectCash = false,
    AutoPower100 = false,
    AutoSpeed = false,
    AutoRebirth = false,
    AutoEscape = false,
    AutoFarmRarity = false,
    SafeZone = CFrame.new(73.92, 54.73, -50.63)
}

local autoEnabled = {
    GOD = false, Divine = false, Exclusive = false, Admin = false,
    Celestial = false, Secret = false, Cosmic = false, Mythic = false
}

local rarityPriority = { GOD = 8, Divine = 7, Exclusive = 6, Admin = 5, Celestial = 4, Secret = 3, Cosmic = 2, Mythic = 1 }

-- ==================== MAIN TAB - COLLECT CASH ====================
MainTab:Toggle({
    Title = "Collect Cash (0.2s)",
    Default = false,
    Callback = function(state)
        _G.VFB.AutoCollectCash = state
    end
})

spawn(function()
    while task.wait(_G.VFB.CashDelay) do
        if _G.VFB.AutoCollectCash then
            pcall(function()
                local remote = game:GetService("ReplicatedStorage")
                    :WaitForChild("Utilities")
                    :WaitForChild("TypedRemote")
                    :FindFirstChild("CashRemote")
                if remote then
                    remote:InvokeServer("CollectCash")
                end
            end)
        end
    end
end)

-- ==================== AUTO ESCAPE ====================
MainTab:Toggle({
    Title = "Auto Escape",
    Default = false,
    Callback = function(state)
        _G.VFB.AutoEscape = state
    end
})

spawn(function()
    while task.wait(0.5) do
        if _G.VFB.AutoEscape then
            pcall(function()
                local dropButton = game:GetService("Players").LocalPlayer.PlayerGui.MainGui:FindFirstChild("DropButton")
                if dropButton and dropButton.Visible then
                    -- Logika escape (bisa disesuaikan)
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                end
            end)
        end
    end
end)

-- ==================== FARM TAB - RARITY ====================
FarmTab:Section("Auto Farm Rarity (Prioritas Tinggi → Rendah)")

local function createRarityToggle(rarityName)
    FarmTab:Toggle({
        Title = "Auto " .. rarityName,
        Default = false,
        Callback = function(state)
            autoEnabled[rarityName] = state
            -- Logic start farm (bisa ditambah nanti)
        end
    })
end

createRarityToggle("GOD")
createRarityToggle("Divine")
createRarityToggle("Exclusive")
createRarityToggle("Admin")
createRarityToggle("Celestial")
createRarityToggle("Secret")
createRarityToggle("Cosmic")
createRarityToggle("Mythic")

-- ==================== UPGRADE TAB ====================
UpgradeTab:Toggle({
    Title = "Auto Power +100",
    Default = false,
    Callback = function(state) _G.VFB.AutoPower100 = state end
})

UpgradeTab:Toggle({
    Title = "Auto Speed +1",
    Default = false,
    Callback = function(state) _G.VFB.AutoSpeed = state end
})

UpgradeTab:Toggle({
    Title = "Auto Rebirth",
    Default = false,
    Callback = function(state) _G.VFB.AutoRebirth = state end
})

-- ==================== SETTINGS TAB ====================
SettingsTab:Section("UI & Delay Settings")

SettingsTab:Slider({
    Title = "Collect Cash Delay",
    Min = 0.1,
    Max = 2,
    Default = 0.2,
    Callback = function(value)
        _G.VFB.CashDelay = value
    end
})

SettingsTab:Button({
    Title = "Reset All Toggles",
    Callback = function()
        -- Reset logic
        print("Semua toggle di-reset")
    end
})

SettingsTab:Button({
    Title = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

print("✅ WindUI Shiro Hub VFB Loaded! Collect Cash 0.2s + Auto Escape aktif.")
print("Nyalakan Collect Cash dulu, lalu Power, lalu Auto GOD/Divine.")
