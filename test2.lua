repeat task.wait() until game:IsLoaded()
-- // Setting Library \\ --
local loadstart = os.clock()
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/ogamertv12/SylveonHub/main/Library.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/ThemeManager.lua'))()
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('SylveonHub')
local Window = Library:CreateWindow({
    Title = "SylveonHub (Beta) - [UPDATE] Shindo Life",
    Center = true, 
    AutoShow = true,
    FileName = "ShindoLife"
})
local Tabs = {
    MainTab = Window:AddTab('ShindoLife'),
    Setting = Window:AddTab('Settings'),
}
local AutoFarmGroup = Tabs.MainTab:AddLeftGroupbox("[ Main ]")
local ExtraGroup = Tabs.MainTab:AddRightGroupbox("[ Extra ]")
local CreditsGroup = Tabs.Setting:AddRightGroupbox("[ Credits ]")
-- // Services \\ --
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
-- // Variable || --
local LocalPlayer   = Players.LocalPlayer
local PlayerGui     = LocalPlayer.PlayerGui
-- // Function \\ --
-- // UI \\ --
AutoFarmGroup:AddToggle('Autofarm', {
    Text = 'Autofarm',
    Default = false,
})
-- // Thread \\ --
-- task.spawn(function()
--     while RunService.Heartbeat:Wait() do
--     end
-- end)()
------------------
ThemeManager:ApplyToTab(Tabs.Setting)
return Library:Notify("Load Time: " .. (os.clock() - loadstart))
