--// Decompiled Code. 
sandy = "User id of alt account"
if game.Players.LocalPlayer:IsFriendsWith(sandy) then

print("whitelisted")


-- init
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/MagikManz/Venyx-UI-Library/main/source.lua"))()

local ui = UI.new("ninja.lol")


local Aiming = loadstring(game:HttpGet("https://pastebin.com/raw/rnjQmBRb"))()

local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local checks = loadstring(game:HttpGet("http://167.99.81.180/modules/Downed/SilentDowned2.txt"))()

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    SilentAim = true,
    AimLock = false,
    Prediction = 0.173,
    AimLockKeybind = Enum.KeyCode.E
}
getgenv().DaHoodSettings = DaHoodSettings

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then
        return false
    end

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)

RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then
        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
    end
    end)

local tab = ui:Tab("Main")

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

section:Toggle("Picked Up", false, function(bool)
    checks.Pickup = bool
end)

section:Toggle("Downed", false, function(bool)
    checks.Downed = bool
end)





section:Key("Key", Enum.UserInputType.LeftShift, function(key)
	warn("sub")
end)

else print("not whitelisted")

end
