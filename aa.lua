--// Decompiled Code. 
sandy = "3137796274"
if game.Players.LocalPlayer:IsFriendsWith(sandy) then

print("whitelisted")

getgenv().paidSettings = {
    PerformanceMode = true,
    turksense = false,
    TargetKey = "Q",
    Watermark = true
}



local paidSettings = getgenv().paidSettings

if paidSettings == nil then

getgenv().paidSettings = {
    PerformanceMode = true,
    turksense = false,
    TargetKey = "Q",
    Watermark = true
}

end

local Script = {
Version = "v0.0.5",
Name = "ninja.lol"
}

local Settings = {
Prediction_Settings = {
    AutoSettings = false,
    Prediction = 0.165
},

Aimbot = {
    Enabled = false,
    Aiming = false,
    FOV = {
        Enabled = false,
        Size = 100,
        Round = 100,
        Color = Color3.fromRGB(28, 56, 139),
        Shape = "Custom",
        Filled = false,
        Transparency = 0.5
    },
    Hitbox = "Head",
    Nearest = "Mouse",
    VisibleCheck = false,
    IgnoreFOV = false,
},
SilentAim = {
    Enabled = false,
    WallCheck = false,
    FOV = {
        Enabled = false,
        Size = 100,
        Round = 100,
        Color = Color3.fromRGB(28, 56, 139),
        Shape = "Custom",
        Filled = false,
        Transparency = 0.5
    },
    Hitbox = "Head",
    Nearest = "Mouse",
    Mode = "Normal",
    VisibleCheck = false,
    IgnoreFOV = false,
    LookAt = false,
},
Triggerbot = {
    Enabled = false,
    Delay = {
        Enabled = false,
        Value = 0
    }
},
AntiAim = {
    Enabled = false,
    Type = "Jitter",
    Angle = 20,
    Speed = 100,
    Underground = false,
    AntiPointAt = false,
    NoAutoRotate = false,
    AntiPointAtDistance = 20
},
Whitelist = {
    Players = {},
    Friends = {},
    Holder = "",
    Enabled = false,
    CrewEnabled = false,
    FriendsWhitelist = false
},
Movement = {
    CFrameSpeed = false,
    Type = "Render"
},
ServerCrash = {
    Enabled = false,
    Value = 0
},
God = {
    GodBullet = false,
    GodMelee = false,
    AntiRagdoll = false,
    IsStillAlive = false
},
Target = {
    Enabled = false,
    TargetUser = nil,
    WallCheck = false,
    Bind = paidSettings.TargetKey
}
}

local Service = setmetatable({}, {
__index = function(t, k)
    return game:GetService(k)
end
})

local WS = workspace
local Insert = table.insert
local Remove = table.remove
local Find = table.find
local Players = Service.Players
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = WS.CurrentCamera
local WorldToViewPortPoint = CurrentCamera.WorldToViewportPoint
local Mouse = LocalPlayer:GetMouse()
local RunService = Service.RunService
local GuiInset = Service.GuiService:GetGuiInset()
local ReplicatedStorage = Service.ReplicatedStorage
local UserInputService = Service.UserInputService
local KeyCode = Enum.KeyCode
local InputType = Enum.UserInputType
local Material = Enum.Material
local UniversalAnimation = Instance.new("Animation")
local StarterGui = Service.StarterGui

local Module = {
Instance = {},
Players = {},
DrawingInstance = {},
OldCFrame,
Ignores = {
    "UpperTorso",
    "LowerTorso",
    "Head",
    "LeftHand",
    "LeftUpperArm",
    "LeftLowerArm",
    "RightHand",
    "RightUpperArm",
    "RightLowerArm"
},
BodyParts = {
    "Head",
    "Torso",
    "HumanoidRootPart",
    "Left Arm",
    "Right Arm",
    "Left Leg",
    "Right Leg"
},	
Functions = {
    Network = function(Data)
        if Data and Data.Character and Data.Character:FindFirstChild("HumanoidRootPart") ~= nil and Data.Character:FindFirstChild("Humanoid") ~= nil and Data.Character:FindFirstChild("Head") ~= nil then
            return true
        end
        return false
    end,
    Cham = function(Data, State)
        local BoxVar = nil
        local GlowVar = nil
        if State then
            for _, v in pairs(Data.Character:GetChildren()) do
                if v:IsA("BasePart") and v.Transparency ~= 1 then
                    if not v:FindFirstChild("Box") then
                        BoxVar = Instance.new("BoxHandleAdornment", v)
                        BoxVar.Name = "Box"
                        BoxVar.AlwaysOnTop = true
                        BoxVar.ZIndex = 4
                        BoxVar.Adornee = v
                        BoxVar.Color3 = Color3.fromRGB(0, 153, 153)
                        BoxVar.Transparency = 0.5
                        BoxVar.Size = v.Size + Vector3.new(0.02, 0.02, 0.02)
                    end
                end
            end
        else
            for i, v in pairs(Data.Character:GetChildren()) do
                if v:IsA("BasePart") and v.Transparency ~= 1 then
                    if v:FindFirstChild("Box") then
                        v["Box"]:Destroy()
                    end
                end
            end
            
            return BoxVar, GlowVar
        end
    end
},
Drawing = {
    Circle = function(Thickness)
        local Circle = Drawing.new("Circle")
        Circle.Transparency = 1
        Circle.Thickness = Thickness
        return Circle
    end
},
}

Module.Functions.NoSpace = function(Data)
return Data:gsub("%s+", "") or Data
end

Module.Functions.Find = function(Data)
local Target = nil

for i, v in next, Players:GetPlayers() do
    if v.Name ~= LocalPlayer.Name and v.Name:lower():match('^'.. Module.Functions.NoSpace(Data):lower()) then
        Target = v.Name
    end
end

return Target
end

Module.Functions.PlayAnimation = function(Data, SpeedData, ActionData)
if Module.Functions.Network(LocalPlayer) then
    UniversalAnimation.AnimationId = "rbxassetid://" .. tostring(Data)
    local Track = LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(UniversalAnimation)
    if ActionData then
        Track.Priority = Enum.AnimationPriority.Action
    end
    if SpeedData ~= nil then
        Track:AdjustSpeed(SpeedData)
    end
    Track:Play()
end
end

Module.Functions.StopAnimation = function()
if Module.Functions.Network(LocalPlayer) then
    for _, v in next, LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks() do
        if v.Animation.AnimationId:match("rbxassetid") then
            v:Stop()
        end
    end
end
end

Module.Functions.Underground = function(Data)
if Module.Functions.Network(LocalPlayer) then
    if Data then
        LocalPlayer.Character.Humanoid.HipHeight = -1
        Module.Functions.PlayAnimation(3152378852, nil, true)
    else
        LocalPlayer.Character.Humanoid.HipHeight = 2.1
        Module.Functions.StopAnimation()
    end
end
end

Module.Functions.AntiHead = function(State)
if Module.Functions.Network(LocalPlayer) then
    if State then
        Module.Functions.PlayAnimation(3189777795, 0.1, false)
    else
        Module.Functions.StopAnimation()
    end
end
end

Module.Functions.IsVisible = function(OriginPart, Part)
if Module.Functions.Network(LocalPlayer) then
    local IgnoreList = {CurrentCamera, LocalPlayer.Character, OriginPart.Parent}
    local Parts = CurrentCamera:GetPartsObscuringTarget(
        {
            OriginPart.Position, 
            Part.Position
        },
        IgnoreList
    )

    for i, v in pairs(Parts) do
        if v.Transparency >= 0.3 then
            Module.Instance[#Module.Instance + 1] = v
        end

        if v.Material == Enum.Material.Glass then
            Module.Instance[#Module.Instance + 1] = v
        end
    end

    return #Parts == 0
end
return true
end

Module.Functions.NilBody = function()
if Module.Functions.Network(LocalPlayer) then
    for i, v in pairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("BasePart") or v:IsA("Part") or v:IsA("MeshPart") then
            if v.Name ~= "HumanoidRootPart" then
                v:Destroy()
            end
        end
    end
end
end

Module.Functions.TableRemove = function(Data, Data2)
for i, v in pairs(Data) do
    if v == Data2 then
        Remove(Data, i)
    end
end
end

Module.Functions.GodFunc = function(Variable)
LocalPlayer.Character.RagdollConstraints:Destroy()
local Folder = Instance.new("Folder", LocalPlayer.Character)
Folder.Name = "FULLY_LOADED_CHAR"
wait()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
Variable = false
end

Module.Functions.Init = function()
for _, v in next, Players:GetPlayers() do
    if v ~= LocalPlayer and v:IsFriendsWith(LocalPlayer.UserId) then
        Insert(Settings.Whitelist.Friends, v.Name)
    end
end

Players.PlayerAdded:Connect(function(_Player)
    if _Player ~= LocalPlayer and _Player:IsFriendsWith(LocalPlayer.UserId) then
        Insert(Settings.Whitelist.Friends, _Player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(_Player)
    if _Player ~= LocalPlayer and _Player:IsFriendsWith(LocalPlayer.UserId) then
        Module.Functions.TableRemove(Settings.Whitelist.Friends, _Player.Name)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    wait(0.5)
    Settings.God.IsStillAlive = false
    if LocalPlayer.Character:FindFirstChild("BodyEffects") then
        if Settings.God.GodBullet then
            Module.Functions.GodFunc(Settings.God.GodBullet)
            LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
        end
        if Settings.God.GodMelee then
            Module.Functions.GodFunc(Settings.God.GodMelee)
            Settings.God.IsStillAlive = true
            LocalPlayer.Character.BodyEffects.Armor:Destroy()
            LocalPlayer.Character.BodyEffects.Defense:Destroy()
        end
        if Settings.God.AntiRagdoll then
            Module.Functions.GodFunc(Settings.God.AntiRagdoll)
        end
    end
    wait(0.5)
    if Settings.AntiAim.Underground then
        Module.Functions.Underground(true)
    end
    wait(0.4)
    if Settings.AntiAim.UndergroundWallbang then
        Float = Instance.new("BodyVelocity")
        Float.Parent = LocalPlayer.Character.HumanoidRootPart
        Float.MaxForce = Vector3.new(100000, 100000, 100000)
        Float.Velocity = Vector3.new(0, 0, 0)
        wait(0.25)
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -11.5, 0)
        Module.Functions.Cham(LocalPlayer, true)
        Settings.AntiAim.UndergroundWallbang = true
    end
end)
end

Module.Functions.NearestMouse = function()
local Target = nil
local Distance = math.huge

for _, v in next, Players:GetPlayers() do
    if Module.Functions.Network(v) and v ~= LocalPlayer then
        local RootPosition, RootVisible = WorldToViewPortPoint(CurrentCamera, v.Character.HumanoidRootPart.Position)
        local NearestToMouse = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(RootPosition.X, RootPosition.Y)).magnitude
        if RootVisible and Distance > NearestToMouse then
            if (not Settings.Whitelist.FriendsWhitelist or not Find(Settings.Whitelist.Friends, v.Name)) and (not Settings.Whitelist.CrewEnabled or v:FindFirstChild("DataFolder") and v.DataFolder.Information:FindFirstChild("Crew") and not tonumber(v.DataFolder.Information.Crew.Value) == tonumber(LocalPlayer.DataFolder.Information.Crew.Value)) and (not Settings.Whitelist.Enabled or not Find(Settings.Whitelist.Players, v.Name)) then
                Target = v
                Distance = NearestToMouse
            end
        end
    end
end

return Target, Distance
end

Module.Functions.NearestRoot = function()
local Target = nil
local Distance = math.huge

for _, v in next, Players:GetPlayers() do
    if Module.Functions.Network(v) and Module.Functions.Network(LocalPlayer) and v ~= LocalPlayer then
        local NearestToRoot = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
        if Distance > NearestToRoot then
            if (not Settings.Whitelist.FriendsWhitelist or not Find(Settings.Whitelist.Friends, v.Name)) and (not Settings.Whitelist.CrewEnabled or v:FindFirstChild("DataFolder") and v.DataFolder.Information:FindFirstChild("Crew") and not tonumber(v.DataFolder.Information.Crew.Value) == tonumber(LocalPlayer.DataFolder.Information.Crew.Value)) and (not Settings.Whitelist.Enabled or not Find(Settings.Whitelist.Players, v.Name)) then
                Target = v
                Distance = NearestToRoot
            end
        end
    end
end

return Target, Distance
end

Module.Functions.TargetCheck = function(Data)
if Data == "Mouse" then
    return Module.Functions.NearestMouse()
elseif Data == "Distance" then
    return Module.Functions.NearestRoot()
end
end

Module.Functions.Invisible = function()
if Module.Functions.Network(LocalPlayer) then
    Module.OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    wait(0.1)
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 96995694596945934234234234, 0)
    wait(0.1)
    LocalPlayer.Character.LowerTorso.Root:Destroy()
    for _, v in pairs(LocalPlayer.Character:GetChildren()) do
        if v:IsA("MeshPart") and not table.find(Module.Ignores, v.Name) then
            v:Destroy()
        end
    end
    wait(0.1)
    LocalPlayer.Character.HumanoidRootPart.CFrame = Module.OldCFrame
end
end

Module.Functions.Jitter = function(Speed, Angle)
if Module.Functions.Network(LocalPlayer) then
    local Jit = Speed or math.random(30, 90)
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.Position) * CFrame.Angles(0, math.rad(Angle) + math.rad((math.random(1, 2) == 1 and Jit or -Jit)), 0) 
end
end

Module.Functions.Spin = function(Speed)
if Module.Functions.Network(LocalPlayer) then
    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(Speed), 0)
end
end

Module.Functions.HttpGet = function(Data)
return loadstring(game:HttpGet(Data))()
end

local Library = Module.Functions.HttpGet("http://167.99.81.180/modules/catto-lib.txt")
local NotifyLibrary = Module.Functions.HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua")
local Notify = NotifyLibrary.Notify
Module.Functions.Init()

Library.theme.topheight = 50
Library.theme.accentcolor = Color3.fromRGB(255, 105, 180)
Library.theme.accentcolor2 = Color3.fromRGB(128, 23, 90)
Library.theme.fontsize = 15
Library.theme.titlesize = 17

if paidSettings.Watermark == true then

Library:CreateWatermark("ninja.lol | {fps} | {game} | beta")

end

local Window = Library:CreateWindow(Script.Name, Vector2.new(492, 598), Enum.KeyCode.RightShift)


local RageTab = Window:CreateTab("Rage")
local SilentAimSection = RageTab:CreateSector("Silent Aim", "left")

local SilentToggle = SilentAimSection:AddToggle('Silent Aim', false, function(State)
Settings.SilentAim.Enabled = State
end)


SilentAimSection:AddToggle('Ping Based Prediction',false,function(State)
Settings.Prediction_Settings.AutoSettings = State
end)

SilentAimSection:AddToggle('Visible Check', false, function(State)
Settings.SilentAim.VisibleCheck = State
end)

SilentAimSection:AddToggle('Ignore FOV', false, function(State)
Settings.SilentAim.IgnoreFOV = State
end)


SilentAimSection:AddDropdown('Modes', {"Normal", "Insane"}, "Normal", false, function(Option)
Settings.SilentAim.Mode = Option
end)

SilentAimSection:AddDropdown('Hitbox', {"Head", "HumanoidRootPart"}, "HumanoidRootPart", false, function(Option)
Settings.SilentAim.Hitbox = Option
end)

SilentAimSection:AddDropdown('Nearest', {"Mouse", "Distance"}, "Distance", false, function(Option)
Settings.SilentAim.Nearest = Option
end)

local FOVSection = RageTab:CreateSector("FOV", "left")

FOVSection:AddToggle('Enabled', false, function(State)
Settings.SilentAim.FOV.Enabled = State
end)

FOVSection:AddToggle('Filled', false, function(State)
Settings.SilentAim.FOV.Filled = State
end)

FOVSection:AddDropdown('Shape', {"Custom", "Octagon", "Circle"}, "Custom", false, function(Option)
Settings.SilentAim.FOV.Shape = Option
end)

FOVSection:AddSlider("Size", 25, 100, 500, 1, function(Value)
Settings.SilentAim.FOV.Size = Value
end)

FOVSection:AddSlider("Round", 2.5, 100, 500, 1, function(Value)
Settings.SilentAim.FOV.Round = Value
end)

FOVSection:AddSlider("Transparency", 0, 5, 10, 1, function(Value)
Settings.SilentAim.FOV.Transparency = tonumber("0." .. Value)
end)

FOVSection:AddColorpicker("Color", Settings.SilentAim.FOV.Color, function(Color)
Settings.SilentAim.FOV.Color = Color
end)

else print("not whitelisted")

end
