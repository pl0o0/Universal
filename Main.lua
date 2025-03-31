local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local window = Rayfield:CreateWindow({
    Name = "Test",
    LoadingTitle = "Test",
    LoadingSubtitle = "Test",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Test",
        KeySystem = false,
    }
})

local HumanoidSettingsTab  = window:CreateTab("HumanoidSettings")

HumanoidSettingsTab:CreateSlider({
    Name = "Speed",
    Range = {16,300},
    Increment = 2,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
    HumanoidSettingsTab:CreateSlider({
    Name = "JumpPower",
    Range = {16,300},
    Increment = 2,
    Suffix = "JumpPower",
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})
local ResetButton = HumanoidSettingsTab:CreateButton({
    Name = "Reset",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 16
    end,
}) 

local tpwalking = false
local tpWalkSpeed = 10

local Rs = game:GetService("RunService")

HumanoidSettingsTab:CreateToggle({
    Name = "TPwalk",
    CurrentValue = false,
    Flag = "TpWalkToggle",
    Callback = function(Value)
        tpwalking = Value
        if not Value then return end
        local hb = Rs.Heartbeat
        local chr = game.Players.LocalPlayer.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        while tpwalking and chr and hum.Parent do
            local delta = hb:Wait()
            if hum.MoveDirection.Magnitude > 0 then
                chr:TranslateBy(hum.MoveDirection * delta * tpWalkSpeed)
            end
        end
    end
})

HumanoidSettingsTab:CreateSlider({
    Name = "TpWalkSpeed",
    Range = {1,1000},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 10,
    Flag = "TPWalkSpeedSlider",
    Callback = function(Value)
        tpWalkSpeed = Value
    end
})

local EspTab = window:CreateTab("ESP")

local xrayEnabled = false

local xray = function()
    for _, xray in pairs(workspace:GetDescendants()) do
        if xray:IsA("BasePart") and not xray.Parent:FindFirstChildWhichIsA("Humanoid") and not xray.Parent.Parent:FindFirstChildWhichIsA("Humanoid") then
            xray.LocalTransparencyModifier = xrayEnabled and 0.5 or 0
        end
    end
end

local XrayToggle = EspTab:CreateToggle({
    Name = "Xray",
    CurrentValue = false,
    Flag = "XrayToggle",
    Callback = function(Value)
        xrayEnabled = Value
        xray()
    end
})  

local InfJumpToggle = HumanoidSettingsTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJump",
    Callback = function(InfiniteJumpEnabled)
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            local chara = game:GetService("Players").LocalPlayer.Character
            if InfiniteJumpEnabled then
                local humanoid = chara:FindFirstChildOfClass("Humanoid")
                humanoid:ChangeState("Jumping")
            end
        end)
    end,
})
