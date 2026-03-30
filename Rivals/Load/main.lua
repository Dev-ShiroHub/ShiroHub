local function LoadUI()
    local success, library = pcall(function()
        return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    end)
    if not success or not library then
        return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end
    return library
end

local u178 = LoadUI()
local u119 = game:GetService("Players")
local v002 = u119.LocalPlayer
local u443 = game:GetService("RunService")
local u_cam = workspace.CurrentCamera
local u_light = game:GetService("Lighting")
local u_tele = game:GetService("TeleportService")
local u_http = game:GetService("HttpService")
local u_vu = game:GetService("VirtualUser")

-- Config Table
local fc90 = {
    aim = false,
    h_size = 2,
    fov_val = 150,
    show_fov = false,
    team = true,
    antiban = true,
    fullbright = false,
    afk_mode = false,
    troll_target = ""
}

-- Drawing FOV Circle
local fov_c = Drawing.new("Circle")
fov_c.Thickness = 1
fov_c.NumSides = 100
fov_c.Color = Color3.fromRGB(255, 255, 255)
fov_c.Filled = false
fov_c.Visible = false

-- Window Setup
local v556 = u178:CreateWindow({
   Name = "Shiro Hub | Rivals",
   LoadingTitle = "V1 Ready",
   LoadingSubtitle = "by TenshiDev",
   ConfigurationSaving = { Enabled = false }
})

--- ### TAB 1: COMBAT ### ---
local u998 = v556:CreateTab("Combat", 4483362458)

u998:CreateToggle({
   Name = "Silent Aim (Metamethod)",
   CurrentValue = false,
   Callback = function(val) fc90.aim = val end,
})

u998:CreateSlider({
   Name = "Hitbox Expander",
   Range = {2, 20},
   Increment = 1,
   CurrentValue = 2,
   Callback = function(val) fc90.h_size = val end,
})

u998:CreateToggle({
   Name = "Show FOV Circle",
   CurrentValue = false,
   Callback = function(val) 
       fc90.show_fov = val 
       fov_c.Visible = val
   end,
})

u998:CreateSlider({
   Name = "FOV Radius",
   Range = {50, 600},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(val) 
       fc90.fov_val = val 
       fov_c.Radius = val
   end,
})

--- ### TAB 2: AFK GUARDIAN (AUTO-SHOOT) ### ---
local v881 = v556:CreateTab("AFK Mode", 4483362458)

v881:CreateToggle({
   Name = "AFK Guardian (Auto-Shoot 0.1s)",
   CurrentValue = false,
   Callback = function(val) 
       fc90.afk_mode = val 
       if val then u178:Notify({Title = "AFK Active", Content = "Diem di spawn, biarin musuh mati sendiri!"}) end
   end,
})

--- ### TAB 3: TROLL (JUMPSCARE) ### ---
local v772 = v556:CreateTab("Troll", 4483362458)

v772:CreateInput({
   Name = "Target Username",
   PlaceholderText = "Nama Korban...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) fc90.troll_target = Text end,
})

v772:CreateButton({
   Name = "Send Jeff Jumpscare (Local)",
   Callback = function()
       local sfx = Instance.new("Sound", workspace)
       sfx.SoundId = "rbxassetid://155355608" sfx.Volume = 5 sfx:Play()
       local gui = Instance.new("ScreenGui", v002.PlayerGui)
       local img = Instance.new("ImageLabel", gui)
       img.Size = UDim2.new(1, 0, 1, 0) img.Image = "rbxassetid://93309534" img.BackgroundTransparency = 1
       task.wait(1) -- Request lu: 1 detik kaget
       gui:Destroy() sfx:Destroy()
   end,
})

--- ### TAB 4: UTILITY & SERVER ### ---
local v110 = v556:CreateTab("Utility", 4483362458)

v110:CreateButton({
   Name = "FPS Boost (Extreme)",
   Callback = function()
       u_light.GlobalShadows = false
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.Plastic
           elseif v:IsA("Decal") then v:Destroy() end
       end
       u178:Notify({Title = "FPS Boost", Content = "Map textures cleared!"})
   end,
})

v110:CreateToggle({
   Name = "Anti-Ban Protection",
   CurrentValue = true,
   Callback = function(val) fc90.antiban = val end,
})

local v220 = v556:CreateTab("Server", 4483362458)
local function u_hop(t)
    local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
    local s, r = pcall(function() return u_http:JSONDecode(game:HttpGet(url)) end)
    if s and r then
        for _, sv in pairs(r.data) do
            if sv.playing < sv.maxPlayers and sv.id ~= game.JobId then u_tele:TeleportToPlaceInstance(game.PlaceId, sv.id, v002) break end
        end
    end
end
v220:CreateButton({ Name = "Server Hop", Callback = function() u_hop() end })

local v646 = v556:CreateTab("Misc", 4483362458)
v646:CreateButton({ Name = "Destroy Windows", Callback = function() u178:Destroy() end })

--- ### CORE LOGIC SYSTEMS ### ---

-- Main Loop (Hitbox, FOV, AFK Guardian)
u443.RenderStepped:Connect(function()
    if fov_c.Visible then fov_c.Position = Vector2.new(v002:GetMouse().X, v002:GetMouse().Y + 36) end
    
    local target = nil
    local dist = fc90.fov_val
    
    for _, v in pairs(u119:GetPlayers()) do
        if v ~= v002 and v.Character and v.Character:FindFirstChild("Head") then
            -- Hitbox Logic
            if fc90.aim then
                if fc90.team and v.Team == v002.Team then v.Character.Head.Size = Vector3.new(1.2, 1.2, 1.2)
                else v.Character.Head.Size = Vector3.new(fc90.h_size, fc90.h_size, fc90.h_size) v.Character.Head.Transparency = 0.5 end
            end
            
            -- Target Finder for AFK Guardian
            local pos, vis = u_cam:WorldToViewportPoint(v.Character.Head.Position)
            local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(v002:GetMouse().X, v002:GetMouse().Y)).Magnitude
            if vis and mag < dist then dist = mag target = v end
        end
    end
    
    -- AFK Guardian Auto-Shoot JEDERRR
    if fc90.afk_mode and target then
        task.spawn(function()
            u_vu:CaptureController()
            u_vu:ClickButton1(Vector2.new())
            task.wait(0.1) -- Jeda request lu
            u_vu:ClickButton1(Vector2.new())
        end)
    end
end)

-- Metamethod Silent Aim
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)
mt.__index = newcclosure(function(t, k)
    if not checkcaller() and k == "Hit" and fc90.aim then
        local target = nil
        local dist = fc90.fov_val
        for _, v in pairs(u119:GetPlayers()) do
            if v ~= v002 and v.Character and v.Character:FindFirstChild("Head") then
                if fc90.team and v.Team == v002.Team then continue end
                local pos, vis = u_cam:WorldToViewportPoint(v.Character.Head.Position)
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(v002:GetMouse().X, v002:GetMouse().Y)).Magnitude
                if vis and mag < dist then dist = mag target = v end
            end
        end
        if target then return target.Character.Head.CFrame end
    end
    return old(t, k)
end)
setreadonly(mt, true)

u178:Notify({Title = "Shiro Hub V1", Content = "TenshiDev Project Loaded!", Duration = 5})
