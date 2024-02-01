repeat task.wait() until game:IsLoaded()
if game.PlaceId ~= 3351674303 then return end

--Vars
local LocalPlayer = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

--Get Current Vehicle
local function GetCurrentVehicle()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.SeatPart and LocalPlayer.Character.Humanoid.SeatPart.Parent
end

--Notification Handler
local function SendNotification(Title, Message, Duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = Title;
        Text = Message;
        Duration = Duration;
    })
end

--Regular TP
local function TP(cframe)
    GetCurrentVehicle():SetPrimaryPartCFrame(cframe)
end

--Velocity TP
local function VelocityTP(cframe)
    local TeleportSpeed = math.random(500, 600)
    local Car = GetCurrentVehicle()
    local BodyGyro = Instance.new("BodyGyro", Car.PrimaryPart)
    BodyGyro.P = 5000
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.CFrame = Car.PrimaryPart.CFrame
    local BodyVelocity = Instance.new("BodyVelocity", Car.PrimaryPart)
    BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Velocity = CFrame.new(Car.PrimaryPart.Position, cframe.p).LookVector * TeleportSpeed
    task.wait((Car.PrimaryPart.Position - cframe.p).Magnitude / TeleportSpeed)
    BodyVelocity.Velocity = Vector3.new()
    task.wait(0.1)
    BodyVelocity:Destroy()
    BodyGyro:Destroy()
end

local function HopServer()
    local success, servers = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?limit=100"
        )).data
     end)
     if not success then return end
     local server = servers[1]
     for i,svr in pairs(servers) do
        if svr["playing"] < server["playing"] then
            server = svr
        end
     end
     TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id)
end

--Auto Farm
local StartPosition = CFrame.new(Vector3.new(4940.19775, 66.0195084, -1933.99927, 0.343969434, -0.00796990748, -0.938947022, 0.00281227613, 0.999968231, -0.00745762791, 0.938976645, -7.53822824e-05, 0.343980938), Vector3.new())
local EndPosition = CFrame.new(Vector3.new(1827.3407, 66.0150146, -658.946655, -0.366112858, 0.00818905979, 0.930534422, 0.00240773871, 0.999966264, -0.00785277691, -0.930567324, -0.000634518801, -0.366120219), Vector3.new())
AutoFarmFunc = coroutine.create(function()
    while wait() do
        if not AutoFarm then
            AutoFarmRunning = false
            coroutine.yield()
        end
        AutoFarmRunning = true
        pcall(function()
            if not GetCurrentVehicle() and tick() - (LastNotif or 0) > 5 then
                LastNotif = tick()
                ReplicatedStorage.Remotes.VehicleEvent:FireServer("Spawn", "Roadster1")
            else
                TP(StartPosition + (TouchTheRoad and Vector3.new() or Vector3.new(0, 1, 0)))
                VelocityTP(EndPosition + (TouchTheRoad and Vector3.new() or Vector3.new(0, 1, 0)))
                TP(EndPosition + (TouchTheRoad and Vector3.new() or Vector3.new(0, 1, 0)))
                VelocityTP(StartPosition + (TouchTheRoad and Vector3.new() or Vector3.new(0, 1, 0)))
            end
        end)
    end
end)

--Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(), Camera.CFrame)
end)

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlayerReady"):FireServer()
--Game Disconnect
game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        HopServer()
    end
end)

--UI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))()
local venyx = library.new(MarketplaceService:GetProductInfo(game.PlaceId).Name)

--Themes
local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),
    TextColor = Color3.fromRGB(255, 255, 255)
}

--Pages
local page1 = venyx:addPage("Main")
local page2 = venyx:addPage("Other")

--Page 1
local FirstSection1 = page1:addSection("Auto Farm")
local FirstSection2 = page1:addSection("Options")

FirstSection1:addToggle("Enabled", true, function(value)
    AutoFarm = value
    if value and not AutoFarmRunning then
        coroutine.resume(AutoFarmFunc)
    end
end)
FirstSection2:addToggle("Touch The Ground", true, function(value)
    TouchTheRoad = value
end)
FirstSection2:addToggle("Collect Playtime", nil, function(value)
    CollectPlaytime = value
    RunService:Set3dRenderingEnabled(not CollectPlaytime)
end)

--Page 2
local SecondSection2 = page2:addSection("Settings")

SecondSection2:addKeybind("Toggle Keybind", Enum.KeyCode.RightShift, function() venyx:toggle() end, function(key)
    Keybind = key.KeyCode.Name
end)
for theme, color in pairs(themes) do
    SecondSection2:addColorPicker(theme, color, function(color3)
        venyx:setTheme(theme, color3)
    end)
end
--load
venyx:SelectPage(venyx.pages[1], true)
