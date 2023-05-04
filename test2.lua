repeat task.wait() until game:IsLoaded()
if game.PlaceId ~= 6152116144 then return end
-- // Setting Library \\ --
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/ogamertv12/SylveonHub/main/test.lua'))()
local window = Library:Window("[👊UPD 10] Anime Adventures")
local Tabs = {
    Main = window:Tab("AutoFarm", "Settings, AutoFarm", "rbxassetid://3926305904", Vector2.new(364, 484), Vector2.new(36, 36)),
    Test = window:Tab("Misc", "LocalPlayer, Gourd", "rbxassetid://3926305904", Vector2.new(364, 444), Vector2.new(36, 36)),
    Test2 = window:Tab("Aisdfdsfmbot2", "FOV, Smoothasd", "rbxassetid://6035039430")
}
-- // Services \\ --
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
-- Environment
local Environment = getgenv()
Environment.Settings = {
    ["AutoFarm"] = false,
    ["RemoveMap"] = false,
    ["KillAura"] = false,
    ["AutoCollectChest"] = false,
    ["TweenSpeed"] = 200,
    ["Distance"] = 8,
    ["KillAuraMethod"] = "",
    ["FarmMethod"] = "",
    ["SelectedMonster"] = {},
}
-- // Variable || --
local LocalPlayer = Players.LocalPlayer
local PlayerData = ReplicatedStorage["Player_Data"][LocalPlayer.Name]
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ToServer = Remotes:WaitForChild("To_Server")
local HandleFireServer = ToServer:WaitForChild("Handle_Initiate_S")
local HandleInvokeServer = ToServer:WaitForChild("Handle_Initiate_S_")
local FireServer = Instance.new("RemoteEvent").FireServer
local InvokeServer = Instance.new("RemoteFunction").InvokeServer
-- // For Executor && Function \\ --
local spawn, wait = task.spawn, task.wait
-- Table
local AutofarmDetails = {
    Closest = nil,
    AttackMethods = {
        ["Combat"] = 'fist_combat',
        ["Sword"] = 'Sword_Combat_Slash',
        ["Scythe"] = 'Scythe_Combat_Slash',
        ["Claw"] = 'claw_Combat_Slash',
    },
    MonsterName = {"Sabito", "Zanegutsu Kuuchie", "Shiron", "Sanemi", "Slasher", "Susamaru", "Nezuko", "Giyu", "Yahaba"},
    NPCsPosition = {
        ["Water Trainer"] = CFrame.new(705, 261, -2409),
        ["Insect Trainer"] = CFrame.new(2873, 316, -3917),
        ["Thunder Trainer"] = CFrame.new(-322, 426, -2384),
        ["Wind Trainer"] = CFrame.new(1792, 334, -3521),
        ["BuyRod"] = CFrame.new(-524, 275, -3482),
    },
    LocationsPosition = {
        ["Zapiwara Mountain"] = CFrame.new(-365, 425, -2303),
        ["Waroru Cave"] = CFrame.new(683, 261, -2401),
        ["Slasher Demon"] = CFrame.new(-485, 274, -3314),
        ["Ushumaru Village"] = CFrame.new(-90, 354, -3170),
        ["Ouwbayashi Home"] = CFrame.new(1593, 315, -4618),
        ["Kabiwaru Village"] = CFrame.new(2037, 315, -2956),
        ["Zapiwara Cave"] = CFrame.new(-8, 275, -2414),
        ["Dangerous Woods"] = CFrame.new(4061, 342, -3928),
        ["Final Selection"] = CFrame.new(5200, 365, -2425),
        ["Kiribating Village"] = CFrame.new(-40, 282, -1623),
        ["Butterfly Mansion"] = CFrame.new(3022, 316, -3928),
        ["Abubu Cave"] = CFrame.new(1044, 276, -3483),
        ["Fishing"] = CFrame.new(677, 273, -2765)
    },
    TextLabal = {
        BreathingProgress = nil,
        DemonProgress = nil,
    }
}
-- // Init \\ --
if setfflag then
    setfflag("HumanoidParallelRemoveNoPhysics", "False")
    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
end

for _,v in pairs(getconnections(LocalPlayer.Idled)) do
    v:Disable()
end

if Remotes:FindFirstChild("getclientping") then 
    Remotes:FindFirstChild("getclientping").OnClientInvoke = function()
        wait(5)
        return true
    end
end
-- // Function \\ --
local function CallerRemote(Remote, ...)
    local Method = Remote.ClassName == ("RemoteEvent") and FireServer or Remote.ClassName == ("RemoteFunction") and InvokeServer
    return spawn(Method, Remote, ...)
end

local function TableFind(Table, Value)
    for _, v in pairs(Table) do
        if v == Value then
            return true
        end
    end
    return false
end

local function GetDistance(Endpoint)
    local Character = LocalPlayer.Character
    local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if typeof(Endpoint) == "Instance" or typeof(Endpoint) == "CFrame" then
        Endpoint = Vector3.new(Endpoint.Position.X, RootPart.Position.Y, Endpoint.Position.Z)
    end
    return LocalPlayer:DistanceFromCharacter(Endpoint)
end

local function Tween(Endpoint)
    local Character = LocalPlayer.Character
    local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if typeof(Endpoint) == "Instance" then
        Endpoint = Endpoint.CFrame
    end

    local TweenFunc = {}
    local Distance = GetDistance(Endpoint)
    local TweenInfo = TweenService:Create(RootPart,
        TweenInfo.new(Distance / Settings.TweenSpeed, Enum.EasingStyle.Linear),
        {CFrame = Endpoint * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), math.rad(0))}
    )
    TweenInfo:Play()

    function TweenFunc:Cancel()
        TweenInfo:Cancel()
        return false
    end

    if Distance <= 150 then
        RootPart.CFrame = Endpoint
        TweenInfo:Cancel()
        return false
    end

    return TweenFunc
end

local function GetClosest()
    local Closest = nil
    local selectedMonsters = Settings.SelectedMonster

    for _, Value in pairs(Workspace.Mobs.Bosses:GetChildren()) do
        local Model = Value:FindFirstChildOfClass("Model")
        if (Model and TableFind(selectedMonsters, Model.Name)) then
            local Humanoid = Model:FindFirstChild("Humanoid")
            if (Humanoid and Humanoid.Health > 0) then
                Closest = Model
                break
            end
        end
    end

    return Closest
end

local function MethodFarm(Method)
    if not Method then 
        return
    end

    local FarmMode = nil
    if Method == "Above" then
        FarmMode = CFrame.new(0, Settings.Distance, 0) * CFrame.Angles(math.rad(-90),0,0)
    elseif Method == "Below" then
        FarmMode = CFrame.new(0, -Settings.Distance, 0) * CFrame.Angles(math.rad(90),0,0)
    elseif Method == "Behind" then
        FarmMode = CFrame.new(0, 0, Settings.Distance)
    end

    return FarmMode
end

local function Attack(Method)
    local DamageAmounts = {math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919}
    
    for i = 1, #DamageAmounts do
        CallerRemote(HandleFireServer, Method, LocalPlayer, LocalPlayer.Character, LocalPlayer.Character.HumanoidRootPart, LocalPlayer.Character.Humanoid, DamageAmounts[i], "ground_slash")
    end
end

Tabs.Main:AddSection({Title = "Settings"})
Tabs.Main:AddDropdown({
    Name = "KillAura Method",
    Table = {"Combat", "Sword", "Scythe", "Claw"},
    Multi = false,
    Default = "Sword",
    Callback = function(value)
        Settings.KillAuraMethod = value
    end
})
Tabs.Main:AddDropdown({
    Name = "Farm Method",
    Table = {"Above","Below","Behind"},
    Multi = false,
    Default = "Below",
    Callback = function(value)
        Settings.FarmMethod = value
    end
})
Tabs.Main:AddSlider({
    Name = "Tween Speed",
    Min = 80,
    Max = 300,
    Start = 200,
    Callback = function(value)
        Settings.TweenSpeed = value
    end
})
Tabs.Main:AddSlider({
    Name = "Distance",
    Min = 5,
    Max = 15,
    Start = 8,
    Callback = function(value)
        Settings.Distance = value
    end
})
Tabs.Main:AddToggle({
    Name = "Remove Map (Reduce lag)",
    Callback = function(value)
        Settings.RemoveMap = value
    end
})
Tabs.Main:AddSection({Title = "Farming"})
Tabs.Main:AddDropdown({
    Name = "Select Monster",
    Table = AutofarmDetails.MonsterName,
    Multi = true,
    Default = "",
    Callback = function(value)
        Settings.SelectedMonster = value
    end
})
Tabs.Main:AddToggle({
    Name = "Auto Farm",
    Callback = function(value)
        Settings.AutoFarm = value
    end
})
Tabs.Main:AddToggle({
    Name = "Kill Aura",
    Callback = function(value)
        Settings.KillAura = value
    end
})
Tabs.Main:AddToggle({
    Name = "Auto Collect Chest",
    Callback = function(value)
        Settings.AutoCollectChest = value
    end
})
-- // Thread \\ --
RunService.Heartbeat:Connect(function()
    pcall(function()
        if Settings.AutoFarm then
            LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end)
end)
spawn(function()
    while wait() do
        -- pcall(function()
            if (Settings.AutoFarm) then
                local Closest = GetClosest()
                local Method = MethodFarm(Settings.FarmMethod)

                -- if not AutofarmDetails.Closest then
                --     AutofarmDetails.Closest = GetClosest()
                --     return
                -- end
                
                repeat wait()
                    print("Loop")
                    Tween(Closest:GetModelCFrame() * Method)
                until not Settings.AutoFarm or not Closest.Parent --or not AutofarmDetails.Closest.Humanoid.Health <= 0
                -- AutofarmDetails.Closest = nil
            end
        -- end)
    end
end)
spawn(function()
    while wait() do
        if (Settings.KillAura) then
            pcall(Attack, AutofarmDetails.AttackMethods[Settings.KillAuraMethod])
            wait(2.2)
        end
    end
end)
