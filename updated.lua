
-- init
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/MagikManz/Venyx-UI-Library/main/source.lua"))()

local ui = UI.new("ninja.lol")


local Aiming = loadstring(game:HttpGet("http://167.99.81.180/modules/SilentModule2.txt"))()
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local checks = loadstring(game:HttpGet("http://167.99.81.180/modules/Downed/SilentDowned2.txt"))()
ESP:Toggle(false)
ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false
Aiming.TeamCheck(false)
Aiming.VisibleCheck = false
-- // Dependencies

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
}

local DaHoodSettings = {
    SilentAim = false,
    AimLock = false,
    Prediction = 0.157
}

getgenv().DaHoodSettings = DaHoodSettings


local tab = ui:Tab("Main")
ui:Tab("Teleports"):Section("Teleports")

local section = tab:Section("Silent Aim")

section:Toggle("Silent Aim", false, function(bool)
	DaHoodSettings.SilentAim = bool
end)

section:Toggle("FOV Circle", false, function(bool)
    Aiming.ShowFOV = bool
end)





section:Slider("FOV Size", 0, 200, 10, function(value)
    Aiming.FOV = value
end)



local section1 = tab:Section("Checks")

section1:Toggle("Picked Up", false, function(bool)
    checks.Pickup = bool
end)

section1:Toggle("Downed", false, function(bool)
    checks.Downed = bool
end)


section:Key("Key", Enum.UserInputType.LeftShift, function(key)
	warn("sub")
end)
