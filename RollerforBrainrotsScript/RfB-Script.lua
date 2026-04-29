local fenv = getfenv()

game:GetService('CoreGui'):FindFirstChild('TenshiScript')
game:GetService('CoreGui').ToraScript:Destroy()

local _14 = loadstring(game:HttpGet('https://raw.githubusercontent.com/liebertsx/Tora-Library/main/src/librarynew', true))()
local _call16 = _14:CreateWindow('Roller for Brainrots')

task.spawn(function(_19, _19_2, _19_3, _19_4, _19_5)
    task.wait()
    task.wait()
end)

local _LocalPlayer21 = game.Players.LocalPlayer
local _ = _LocalPlayer21.Character

_LocalPlayer21.Character:WaitForChild('HumanoidRootPart')

fenv.AutoFarm = function(_26, _26_2, _26_3, _26_4, _26_5, _26_6, _26_7)
    spawn(function(_28, _28_2)
        _G[_26_2] = true 
    end)
end

_call16:AddToggle({
    state = false,
    text = 'Auto OG & Divine',
    callback = function(_31, _31_2, _31_3, _31_4) end,
})
_call16:AddToggle({
    state = false,
    text = 'Auto Celestial',
    callback = function(_34, _34_2, _34_3, _34_4, _34_5, _34_6) end,
})
_call16:AddToggle({
    state = false,
    text = 'Auto Secret',
    callback = function(_37) end,
})

for _41, _41_2 in pairs(workspace.Plots:GetChildren())do
    local _ = _41_2:GetAttribute('OccupiedByUserId') == game.Players.LocalPlayer.UserId
end

_call16:AddToggle({
    flag = 'toggle',
    text = 'Collect Cash',
    callback = function(_50, _50_2, _50_3, _50_4, _50_5) end,
    state = false,
})

fenv.Cash = function(_51, _51_2) end

_call16:AddToggle({
    flag = 'toggle',
    text = 'Upgrade All',
    callback = function(_54, _54_2, _54_3, _54_4) end,
    state = false,
})

fenv.Upgrade = function(_55) end

_call16:AddToggle({
    flag = 'toggle',
    text = 'Auto Rebirth',
    callback = function(_58) end,
    state = false,
})

fenv.Rebirth = function(_59, _59_2, _59_3, _59_4) end

_call16:AddLabel({
    text = 'Builded By: TenshiDev',
})
_14:Init()
