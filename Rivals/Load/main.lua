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

-- Config Table
local fc90 = {
    aim = false,
    h_size = 2,
    fov_val = 150,
    show_fov = false,
    team = true,
    antiban = true,
    fullbright = false
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
   LoadingTitle = "V1",
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

--- ### TAB 2: UTILITY & FPS ### ---
local v110 = v556:CreateTab("Utility", 4483362458)

v110:CreateButton({
   Name = "FPS Boost (Extreme)",
   Callback = function()
       u_light.GlobalShadows = false
       for _, v in pairs(game:GetDescendants()) do
           if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.Plastic
           elseif v:IsA("Decal") then v:Destroy() end
       end
       u178:Notify({Title = "Optimized", Content = "Map textures removed!"})
   end,
})

v110:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(val)
       fc90.fullbright = val
       if val then u_light.Brightness = 2 u_light.ClockTime = 14 u_light.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
       else u_light.Brightness = 1 u_light.ClockTime = 12 end
   end,
})

v110:CreateToggle({
   Name = "Anti-Ban Protection",
   CurrentValue = true,
   Callback = function(val) fc90.antiban = val end,
})

--- ### TAB 3: SERVER MANAGEMENT ### ---
local v220 = v556:CreateTab("Server", 4483362458)

local function u_hop_v9(target_type)
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
    local success, result = pcall(function() return u_http:JSONDecode(game:HttpGet(url)) end)
    if success and result and result.data then
        local servers = result.data
        if target_type == "Low" then table.sort(servers, function(a, b) return a.playing < b.playing end)
        elseif target_type == "Pro" then table.sort(servers, function(a, b) return a.playing > b.playing end) end
        for _, s in pairs(servers) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                u_tele:TeleportToPlaceInstance(game.PlaceId, s.id, v002) break
            end
        end
    end
end

v220:CreateButton({ Name = "Server Hop (Random)", Callback = function() u_hop_v9("Random") end })
v220:CreateButton({ Name = "Hop to Low Player Server", Callback = function() u_hop_v9("Low") end })
v220:CreateButton({ Name = "Hop to Pro Players", Callback = function() u_hop_v9("Pro") end })

--- ### CORE LOGIC SYSTEMS ### ---

local v646 = v556:CreateTab("Misc", 4483362458)

v646:CreateButton({
        Name = "Destroy Windows",
        Callback = function()
            u178:Destroy()
        end
})

-- Command /size
v002.Chatted:Connect(function(msg)
    local args = msg:split(" ")
    if args[1] == "/size" and args[3] then
        local target_name = args[2]:lower()
        local size_val = tonumber(args[3])
        for _, p in pairs(u119:GetPlayers()) do
            if p.Name:lower():sub(1, #target_name) == target_name or (p.DisplayName and p.DisplayName:lower():sub(1, #target_name) == target_name) then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum and size_val then
                    for _, s in pairs({"BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale"}) do
                        local v = hum:FindFirstChild(s) or Instance.new("NumberValue", hum)
                        v.Name = s v.Value = size_val
                    end
                end
            end
        end
    end
end)

-- Main Loop (Hitbox & FOV)
u443.RenderStepped:Connect(function()
    if fov_c.Visible then fov_c.Position = Vector2.new(v002:GetMouse().X, v002:GetMouse().Y + 36) end
    if fc90.aim then
        for _, v in pairs(u119:GetPlayers()) do
            if v ~= v002 and v.Character and v.Character:FindFirstChild("Head") then
                if fc90.team and v.Team == v002.Team then v.Character.Head.Size = Vector3.new(1.2, 1.2, 1.2)
                else
                    v.Character.Head.Size = Vector3.new(fc90.h_size, fc90.h_size, fc90.h_size)
                    v.Character.Head.Transparency = 0.5 v.Character.Head.CanCollide = false
                end
            end
        end
    end
end)

-- Metamethod Hooks
local mt = getrawmetatable(game)
local old_idx = mt.__index
local old_namecall = mt.__namecall
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
    return old_idx(t, k)
end)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if fc90.antiban and (method == "Kick" or method == "kick") then return nil end
    return old_namecall(self, ...)
end)

setreadonly(mt, true)
u178:Notify({Title = "Shiro Hub Loaded", Content = "Rivals 2026 Ready!", Duration = 5})
