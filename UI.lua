repeat wait() until game:IsLoaded()
if game:GetService("CoreGui").RobloxGui.Modules:FindFirstChild("AnimeUI") then
    game:GetService("CoreGui").RobloxGui.Modules:FindFirstChild("AnimeUI"):Destroy()
end
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Http = game:GetService("HttpService")
local Mouse = LocalPlayer:GetMouse()
local library = {flags = {}}

local Noti = {
    ["ColorNoti"] = Color3.fromRGB(180, 77, 81),
    ["Icon"] = "rbxassetid://3926307971",
    ["Offset"] = Vector2.new(964, 444),
    ["Size"] = Vector2.new(36, 36),
}

local function GetFolder(foldername, filename)
    if not isfolder(tostring(foldername)) then 
        makefolder(tostring(foldername))
    end
    if not isfile(tostring(foldername) .. "/" .. tostring(filename) .. ".json") then 
        writefile(tostring(foldername) .. "/" .. tostring(filename) .. ".json", tostring(Http:JSONEncode({})))
    end
end

local function GetSetting(name, foldername, filename)
    local content = readfile(tostring(foldername) .. "/" .. tostring(filename) .. ".json")
    local parsed = Http:JSONDecode(content)
    name = name:gsub("%s+", "")
    if parsed then 
        return parsed[name]
    end
end

local function AddSetting(name, value, foldername, filename)
    local content = readfile(tostring(foldername) .. "/" .. tostring(filename) .. ".json")
    local parsed = Http:JSONDecode(content)
    parsed[name:gsub("%s+", "")] = value 
    writefile(tostring(foldername) .. "/" .. tostring(filename) .. ".json", tostring(Http:JSONEncode(parsed)))
end

local function tweenObject(object, data, time)
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, data)
    tween:Play()
    return tween
end

-- Function Dragging
local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		object.Position = pos
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local AnimeUI = Instance.new("ScreenGui")
AnimeUI.Name = "AnimeUI"
AnimeUI.Parent = game:GetService("CoreGui").RobloxGui.Modules
AnimeUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Create Window
function library:Window(optionswin)
    GetFolder(optionswin.FolderName, optionswin.FileName)
    local MainFrame = Instance.new("Frame")
    local MainFrameCorner = Instance.new("UICorner")
    local LeftFrame = Instance.new("Frame")
    local LeftFrameCorner = Instance.new("UICorner")
    local CenterLogo = Instance.new("ImageLabel")
    local TabHolder = Instance.new("ScrollingFrame")
    local TabHolderListLayout = Instance.new("UIListLayout")
    local TabHolderPadding = Instance.new("UIPadding")
    local TopFrame = Instance.new("Frame")
    local TopFrameCorner = Instance.new("UICorner")
    local LogoHub = Instance.new("ImageLabel")
    local NameLogo = Instance.new("TextLabel")
    local HubLogo = Instance.new("TextLabel")
    local ContainerFolder = Instance.new("Folder")
    local Container = Instance.new("Frame")
    local Notifications = Instance.new("Frame")
    local NotificationsListLayout = Instance.new("UIListLayout")
    local NotificationsPadding = Instance.new("UIPadding")
    local MinimizeIcon = Instance.new("ImageButton")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = AnimeUI
    MainFrame.AnchorPoint = Vector2.new(0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 525, 0, 453)
    MainFrame.ClipsDescendants = true

    MainFrameCorner.CornerRadius = UDim.new(0, 5)
    MainFrameCorner.Name = "MainFrameCorner"
    MainFrameCorner.Parent = MainFrame

    LeftFrame.Name = "LeftFrame"
    LeftFrame.Parent = MainFrame
    LeftFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    LeftFrame.BorderSizePixel = 0
    LeftFrame.Position = UDim2.new(0, 0, 0.0580573976, 0)
    LeftFrame.Size = UDim2.new(0, 165, 0, 426)

    LeftFrameCorner.CornerRadius = UDim.new(0, 5)
    LeftFrameCorner.Name = "LeftFrameCorner"
    LeftFrameCorner.Parent = LeftFrame

    CenterLogo.Name = "CenterLogo"
    CenterLogo.Parent = LeftFrame
    CenterLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CenterLogo.BackgroundTransparency = 1.000
    CenterLogo.Position = UDim2.new(0.193939388, 0, 0.00234741787, 0)
    CenterLogo.Size = UDim2.new(0, 100, 0, 100)
    CenterLogo.Image = "http://www.roblox.com/asset/?id=13392469916"

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = LeftFrame
    TabHolder.Active = true
    TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.BorderColor3 = Color3.fromRGB(30, 30, 30)
    TabHolder.Position = UDim2.new(0, 0, 0.237089202, 0)
    TabHolder.Size = UDim2.new(0, 165, 0, 325)
    TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHolder.ScrollBarThickness = 3
    TabHolder.ScrollBarImageTransparency = 0.8

    TabHolderListLayout.Name = "TabHolderListLayout"
    TabHolderListLayout.Parent = TabHolder
    TabHolderListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHolderListLayout.Padding = UDim.new(0, 5)

    TabHolderPadding.Name = "TabHolderPadding"
    TabHolderPadding.Parent = TabHolder
    TabHolderPadding.PaddingLeft = UDim.new(0, 10)
    TabHolderPadding.PaddingTop = UDim.new(0, 15)

    TopFrame.Name = "TopFrame"
    TopFrame.Parent = MainFrame
    TopFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    TopFrame.BorderSizePixel = 0
    TopFrame.Size = UDim2.new(0, 525, 0, 27)

    TopFrameCorner.CornerRadius = UDim.new(0, 5)
    TopFrameCorner.Name = "TopFrameCorner"
    TopFrameCorner.Parent = TopFrame

    LogoHub.Name = "LogoHub"
    LogoHub.Parent = TopFrame
    LogoHub.AnchorPoint = Vector2.new(0.5, 0.5)
    LogoHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LogoHub.BackgroundTransparency = 1.000
    LogoHub.Position = UDim2.new(0.0299999993, 0, 0.5, 0)
    LogoHub.Size = UDim2.new(0, 20, 0, 20)
    LogoHub.Image = "http://www.roblox.com/asset/?id=13392469916"

    NameLogo.Name = "NameLogo"
    NameLogo.Parent = TopFrame
    NameLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameLogo.BackgroundTransparency = 1.000
    NameLogo.Position = UDim2.new(0.0549999997, 0, 0, 1)
    NameLogo.Size = UDim2.new(0, 137, 0, 27)
    NameLogo.Font = Enum.Font.GothamMedium
    NameLogo.Text = "Sylveon"
    NameLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLogo.TextSize = 17.000
    NameLogo.TextXAlignment = Enum.TextXAlignment.Left

    HubLogo.Name = "HubLogo"
    HubLogo.Parent = TopFrame
    HubLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HubLogo.BackgroundTransparency = 1.000
    HubLogo.Position = UDim2.new(0.075, 0, 0, 1)
    HubLogo.Size = UDim2.new(0, 137, 0, 27)
    HubLogo.Font = Enum.Font.GothamMedium
    HubLogo.Text = "Hub"
    HubLogo.TextColor3 = Color3.fromRGB(110, 186, 101)
    HubLogo.TextSize = 17.000

    ContainerFolder.Name = "ContainerFolder"
    ContainerFolder.Parent = MainFrame

    Container.Name = "Container"
    Container.Parent = ContainerFolder
    Container.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0.314285725, 0, 0.0580573678, 0)
    Container.Size = UDim2.new(0, 360, 0, 426)

    Notifications.Name = "Notifications"
    Notifications.Parent = AnimeUI
    Notifications.AnchorPoint = Vector2.new(0.5, 0.5)
    Notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Notifications.BackgroundTransparency = 1.000
    Notifications.BorderSizePixel = 0
    Notifications.ClipsDescendants = true
    Notifications.Position = UDim2.new(0.159999996, 0, 0.629999995, 0)
    Notifications.Size = UDim2.new(0, 600, 0, 700)

    NotificationsListLayout.Name = "NotificationsListLayout"
    NotificationsListLayout.Parent = Notifications
    NotificationsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotificationsListLayout.Padding = UDim.new(0, 5)

    NotificationsPadding.Name = "NotificationsPadding"
    NotificationsPadding.Parent = Notifications
    NotificationsPadding.PaddingLeft = UDim.new(0, 48)
    NotificationsPadding.PaddingTop = UDim.new(0, 5)

    MinimizeIcon.Name = "MinimizeIcon"
    MinimizeIcon.Parent = TopFrame
    MinimizeIcon.AnchorPoint = Vector2.new(1, 0.5)
    MinimizeIcon.BackgroundTransparency = 1.000
    MinimizeIcon.Position = UDim2.new(1, 0, 0.5, 0)
    MinimizeIcon.Size = UDim2.new(0, 30, 0, 25)
    MinimizeIcon.ZIndex = 2
    MinimizeIcon.Image = "rbxassetid://3926307971"
    MinimizeIcon.ImageRectOffset = Vector2.new(884, 284)
    MinimizeIcon.ImageRectSize = Vector2.new(36, 36)

    -- Dragging
    MakeDraggable(TopFrame, MainFrame)

    -- Toggle UI
    local opened = true
    MinimizeIcon.MouseButton1Click:Connect(function()
        opened = not opened
        if opened then
            TweenService:Create(
                MainFrame,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 525, 0, 453)}
            ):Play()
            Container.Visible = true
        else
            TweenService:Create(
                MainFrame,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 525, 0, 27)}
            ):Play()
            Container.Visible = false
        end
    end)

    function library:Noti(status, content, time)
        if status == "error" then
            Noti["ColorNoti"] = Color3.fromRGB(180, 77, 81)
            Noti["Icon"] = "rbxassetid://3926307971"
            Noti["Text"] = "ERROR"
            Noti["Offset"] = Vector2.new(964, 444)
            Noti["Size"] = Vector2.new(36, 36)
        elseif status == "success" then
            Noti["ColorNoti"] = Color3.fromRGB(64, 201, 114)
            Noti["Icon"] = "rbxassetid://3926305904"
            Noti["Text"] = "SUCCESS"
            Noti["Offset"] = Vector2.new(284, 924)
            Noti["Size"] = Vector2.new(36, 36)
        elseif status == "warn" then
            Noti["ColorNoti"] = Color3.fromRGB(254, 214, 0)
            Noti["Icon"] = "rbxassetid://3926305904"
            Noti["Text"] = "WARNING"
            Noti["Offset"] = Vector2.new(524, 444)
            Noti["Size"] = Vector2.new(36, 36)
        end
        local NotiMain = Instance.new("Frame")
        local NotiMainCorner = Instance.new("UICorner")
        local OutMain = Instance.new("Frame")
        local OutMainCorner = Instance.new("UICorner")
        local TitleNoti = Instance.new("TextLabel")
        local Content = Instance.new("TextLabel")
        local Icon = Instance.new("ImageLabel")

        NotiMain.Name = "NotiMain"
        NotiMain.Parent = Notifications
        NotiMain.AnchorPoint = Vector2.new(0.5, 0.5)
        NotiMain.BackgroundColor3 = Noti["ColorNoti"]
        NotiMain.ClipsDescendants = true
        NotiMain.Position = UDim2.new(0.282999992, 0, 0.0599999987, 0)

        NotiMainCorner.CornerRadius = UDim.new(0, 5)
        NotiMainCorner.Name = "NotiMainCorner"
        NotiMainCorner.Parent = NotiMain

        OutMain.Name = "OutMain"
        OutMain.Parent = NotiMain
        OutMain.AnchorPoint = Vector2.new(0.5, 0.5)
        OutMain.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
        OutMain.Position = UDim2.new(0.504999995, 0, 0.5, 0)
        OutMain.Size = UDim2.new(0, 296, 0, 70)

        OutMainCorner.CornerRadius = UDim.new(0, 5)
        OutMainCorner.Name = "OutMainCorner"
        OutMainCorner.Parent = OutMain

        TitleNoti.Name = "TitleNoti"
        TitleNoti.Parent = OutMain
        TitleNoti.AnchorPoint = Vector2.new(0.5, 0.5)
        TitleNoti.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TitleNoti.BackgroundTransparency = 1.000
        TitleNoti.BorderSizePixel = 0
        TitleNoti.Position = UDim2.new(0.400000006, 0, 0.349999994, 0)
        TitleNoti.Size = UDim2.new(0, 100, 0, 30)
        TitleNoti.Font = Enum.Font.GothamBlack
        TitleNoti.Text = Noti["Text"]
        TitleNoti.TextColor3 = Noti["ColorNoti"]
        TitleNoti.TextSize = 15.000
        TitleNoti.TextXAlignment = Enum.TextXAlignment.Left

        Content.Name = "Content"
        Content.Parent = OutMain
        Content.AnchorPoint = Vector2.new(0.5, 0.5)
        Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Content.BackgroundTransparency = 1.000
        Content.BorderSizePixel = 0
        Content.Position = UDim2.new(0.590338945, 0, 0.649999976, 0)
        Content.Size = UDim2.new(0, 212, 0, 25)
        Content.Font = Enum.Font.GothamSemibold
        Content.Text = tostring(content)
        Content.TextColor3 = Color3.fromRGB(255, 255, 255)
        Content.TextSize = 14.000
        Content.TextXAlignment = Enum.TextXAlignment.Left

        Icon.Name = "Icon"
        Icon.Parent = OutMain
        Icon.AnchorPoint = Vector2.new(0.5, 0.5)
        Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Icon.BackgroundTransparency = 1.000
        Icon.BorderSizePixel = 0
        Icon.Position = UDim2.new(0.119999997, 0, 0.5, 0)
        Icon.Size = UDim2.new(0, 35, 0, 35)
        Icon.Image = Noti["Icon"]
        Icon.ImageColor3 = Noti["ColorNoti"]
        Icon.ImageRectOffset = Noti["Offset"]
        Icon.ImageRectSize = Noti["Size"]

        tweenObject(NotiMain, {
            Size = UDim2.new(0, 300, 0, 70)
        }, 0.3)

        local function FadeOutAfter(Seconds)
            wait(tonumber(Seconds))
            tweenObject(NotiMain, {
                Size = UDim2.new(0, 0, 0, 0)
            }, 0.3)
            wait(0.25)
            NotiMain:Destroy()
        end
        coroutine.wrap(FadeOutAfter)(time);
    end
    
    -- Create Tab
    local activeTab = false
    local activeTabFrame = nil
    local window = {}
    function window:Tab(name, icon, off, size)
        if off == nil then
            off = Vector2.new(0, 0)
        end
        if size == nil then
            size = Vector2.new(0, 0)
        end

        local Tab = Instance.new("TextButton")
        local TitleTab = Instance.new("TextLabel")
        local LogoTab = Instance.new("ImageLabel")
        local Selection = Instance.new("Frame")
        local SelectionCorner = Instance.new("UICorner")
        local TabCorner = Instance.new("UICorner")
        local PageFrame = Instance.new("ScrollingFrame")
        local PageFramePadding = Instance.new("UIPadding")
        local PageFrameListLayout = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabHolder
        Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(-0.0316129141, 0, 0, 0)
        Tab.Size = UDim2.new(0, 146, 0, 29)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.SourceSans
        Tab.Text = ""
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 14.000

        TitleTab.Name = "TitleTab"
        TitleTab.Parent = Tab
        TitleTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TitleTab.BackgroundTransparency = 1.000
        TitleTab.Position = UDim2.new(0.25, 0, 0, 0)
        TitleTab.Size = UDim2.new(0, 108, 0, 29)
        TitleTab.Font = Enum.Font.GothamMedium
        TitleTab.Text = tostring(name)
        TitleTab.TextColor3 = Color3.fromRGB(155, 155, 155)
        TitleTab.TextSize = 11.000
        TitleTab.TextXAlignment = Enum.TextXAlignment.Left

        LogoTab.Name = "LogoTab"
        LogoTab.Parent = Tab
        LogoTab.AnchorPoint = Vector2.new(0.5, 0.5)
        LogoTab.BackgroundTransparency = 1.000
        LogoTab.BorderSizePixel = 0
        LogoTab.Position = UDim2.new(0.100000001, 0, 0.5, 0)
        LogoTab.Size = UDim2.new(0, 23, 0, 23)
        LogoTab.Image = tostring(icon)
        LogoTab.ImageColor3 = Color3.fromRGB(71, 118, 64)
        LogoTab.ImageRectOffset = off
        LogoTab.ImageRectSize = size

        Selection.Name = "Selection"
        Selection.Parent = Tab
        Selection.AnchorPoint = Vector2.new(0.5, 0.5)
        Selection.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Selection.BorderSizePixel = 0
        Selection.Position = UDim2.new(-0.0500000007, 0, 0.5, 0)
        Selection.Size = UDim2.new(0, 5, 0, 29)

        SelectionCorner.CornerRadius = UDim.new(0, 5)
        SelectionCorner.Name = "SelectionCorner"
        SelectionCorner.Parent = Selection

        TabCorner.CornerRadius = UDim.new(0, 5)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        PageFrame.Name = "PageFrame"
        PageFrame.Parent = Container
        PageFrame.Active = true
        PageFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        PageFrame.BackgroundTransparency = 1.000
        PageFrame.Size = UDim2.new(0, 359, 0, 426)
        PageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        PageFrame.ScrollBarThickness = 4
        PageFrame.Visible = false
        PageFrame.BorderSizePixel = 0

        PageFramePadding.Name = "PageFramePadding"
        PageFramePadding.Parent = PageFrame
        PageFramePadding.PaddingLeft = UDim.new(0, 15)
        PageFramePadding.PaddingTop = UDim.new(0, 15)

        PageFrameListLayout.Name = "PageFrameListLayout"
        PageFrameListLayout.Parent = PageFrame
        PageFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageFrameListLayout.Padding = UDim.new(0, 10)

        if activeTab == false then
            activeTab = true
            Selection.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            Tab.BackgroundColor3 = Color3.fromRGB(33, 35, 39)
            TitleTab.TextColor3 = Color3.fromRGB(255, 255, 255)
            LogoTab.ImageColor3 = Color3.fromRGB(110, 186, 101)
			PageFrame.Visible = true
        end

        Tab.MouseButton1Click:Connect(function()
            for i, v in next, ContainerFolder.Container:GetChildren() do
                if v.Name == "PageFrame" then
                    v.Visible = false
                end
                PageFrame.Visible = true
            end
            for i, v in next, TabHolder:GetChildren() do
                if v.ClassName == "TextButton" then
                    tweenObject(v.TitleTab, {
                        TextColor3 = Color3.fromRGB(155, 155, 155)
                    }, 0.2)
                    tweenObject(v.Selection, {
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    }, 0.2)
                    tweenObject(v, {
                        BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    }, 0.2)
                    tweenObject(v.LogoTab, {
                        ImageColor3 = Color3.fromRGB(71, 118, 64)
                    }, 0.2)
                end
            end
            tweenObject(TitleTab, {
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }, 0.4)
            tweenObject(Selection, {
                BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            }, 0.4)
            tweenObject(Tab, {
                BackgroundColor3 = Color3.fromRGB(33, 35, 39)
            }, 0.4)
            tweenObject(LogoTab, {
                ImageColor3 = Color3.fromRGB(110, 186, 101)
            }, 0.4)
        end)

        -- Responsive
        TabHolder.CanvasSize = UDim2.new(0,0,0,TabHolderListLayout.AbsoluteContentSize.Y + 20)

        -- Create Module
        local ContainerContent = {}
        function ContainerContent:Button(name, callback)
            local Btn = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonCorner = Instance.new("UICorner")

            Btn.Name = "Btn"
            Btn.Parent = PageFrame
            Btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            Btn.BackgroundTransparency = 1.000
            Btn.BorderSizePixel = 0
            Btn.ClipsDescendants = true
            Btn.Size = UDim2.new(0, 330, 0, 30)

            Button.Name = "Button"
            Button.Parent = Btn
            Button.AnchorPoint = Vector2.new(0.5, 0.5)
            Button.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            Button.BackgroundTransparency = 0.900
            Button.Position = UDim2.new(0.5, 0, 0.5, 0)
            Button.Size = UDim2.new(0, 250, 0, 30)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.BorderSizePixel = 0
            ButtonTitle.Size = UDim2.new(0, 250, 0, 30)
            ButtonTitle.Font = Enum.Font.GothamMedium
            ButtonTitle.Text = tostring(name)
            ButtonTitle.TextColor3 = Color3.fromRGB(110, 186, 101)
            ButtonTitle.TextSize = 13.000

            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            Button.MouseEnter:Connect(function()
                tweenObject(Button, {
                    BackgroundTransparency = 0
                }, 0.3)
                tweenObject(Button, {
                    Size = UDim2.new(0, 330, 0, 30)
                }, 0.3)
                tweenObject(ButtonTitle, {
                    Size = UDim2.new(0, 330, 0, 30)
                }, 0.3)
                tweenObject(ButtonTitle, {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }, 0.3)
            end)

            Button.MouseLeave:Connect(function()
                tweenObject(Button, {
                    BackgroundTransparency = 0.9
                }, 0.3)
                tweenObject(Button, {
                    Size = UDim2.new(0, 250, 0, 30)
                }, 0.3)
                tweenObject(ButtonTitle, {
                    Size = UDim2.new(0, 250, 0, 30)
                }, 0.3)
                tweenObject(ButtonTitle, {
                    TextColor3 = Color3.fromRGB(110, 186, 101)
                }, 0.3)
            end)

            Button.MouseButton1Click:Connect(function()
                coroutine.resume(coroutine.create(function()
                    local Circle = Instance.new("ImageLabel")
                    Circle.Name = "Circle"
                    Circle.Parent = Button
                    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Circle.BackgroundTransparency = 1
                    Circle.ZIndex = 10
                    Circle.Image = "rbxassetid://266543268"
                    Circle.ImageColor3 = Color3.fromRGB(30, 30, 30)
                    Circle.ImageTransparency = 0.800
                    Btn.ClipsDescendants = true
                    Circle.Position = UDim2.new(0, Mouse.X - Circle.AbsolutePosition.X, 0, Mouse.Y - Circle.AbsolutePosition.Y)
                    Circle:TweenSizeAndPosition(UDim2.new(0, Button.AbsoluteSize.X * 1.5, 0, Button.AbsoluteSize.X * 1.5), UDim2.new(0.5, -Button.AbsoluteSize.X * 1.5 / 2, 0.5, -Button.AbsoluteSize.X * 1.5 / 2), "Out", "Quad", 0.75, false, nil)
                    TweenService:Create(
                        Circle,
                        TweenInfo.new(.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                        {ImageTransparency = 1}
                    ):Play()
                    wait(0.75)
                    Circle:Destroy()
                end))
                if callback then
                    callback()
                end
            end)

            PageFrame.CanvasSize = UDim2.new(0,0,0,PageFrameListLayout.AbsoluteContentSize.Y + 25)
        end
        function ContainerContent:Toggle(name, default, callback)
            local setting = GetSetting(name, optionswin.FolderName, optionswin.FileName)
            setting = setting == "true" and true or false
            default = setting or default

            if not library.flags[name] then
                library.flags[name] = default or false
            end

            local Toggle = Instance.new("Frame")
            local BtnToggle = Instance.new("TextButton")
            local TitleToggle = Instance.new("TextLabel")
            local FrameToggle = Instance.new("Frame")
            local LogoToggle = Instance.new("ImageLabel")
            local ToggleLocker = Instance.new("Frame")
            local ToggleLockerCorner = Instance.new("UICorner")
            local LockerIcon = Instance.new("ImageLabel")
            local StrokeToggle = Instance.new("UIStroke")

            Toggle.Name = "Toggle"
            Toggle.Parent = PageFrame
            Toggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            Toggle.BackgroundTransparency = 1.000
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(0, 320, 0, 35)

            BtnToggle.Name = "BtnToggle"
            BtnToggle.Parent = Toggle
            BtnToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BtnToggle.BackgroundTransparency = 1.000
            BtnToggle.BorderSizePixel = 0
            BtnToggle.Size = UDim2.new(0, 320, 0, 35)
            BtnToggle.Font = Enum.Font.SourceSans
            BtnToggle.Text = ""
            BtnToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            BtnToggle.TextSize = 14.000

            TitleToggle.Name = "TitleToggle"
            TitleToggle.Parent = BtnToggle
            TitleToggle.AnchorPoint = Vector2.new(0.5, 0.5)
            TitleToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TitleToggle.BackgroundTransparency = 1.000
            TitleToggle.BorderSizePixel = 0
            TitleToggle.Position = UDim2.new(0.596875012, 0, 0.5, 0)
            TitleToggle.Size = UDim2.new(0, 210, 0, 30)
            TitleToggle.Font = Enum.Font.GothamSemibold
            TitleToggle.Text = tostring(name)
            TitleToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleToggle.TextSize = 13.000
            TitleToggle.TextXAlignment = Enum.TextXAlignment.Left

            FrameToggle.Name = "FrameToggle"
            FrameToggle.Parent = Toggle
            FrameToggle.AnchorPoint = Vector2.new(0.5, 0.5)
            FrameToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            FrameToggle.BackgroundTransparency = 1.000
            FrameToggle.BorderSizePixel = 0
            FrameToggle.Position = UDim2.new(0.129999995, 0, 0.5, 0)
            FrameToggle.Size = UDim2.new(0, 17, 0, 17)

            LogoToggle.Name = "LogoToggle"
            LogoToggle.Parent = FrameToggle
            LogoToggle.AnchorPoint = Vector2.new(0.5, 0.5)
            LogoToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LogoToggle.BackgroundTransparency = 1.000
            LogoToggle.BorderSizePixel = 0
            LogoToggle.Position = UDim2.new(0.5, 0, 0.5, 0)
            LogoToggle.Size = not default and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 27, 0, 27)
            LogoToggle.Visible = true
            LogoToggle.Image = "rbxassetid://6031068421"
            LogoToggle.ImageColor3 = Color3.fromRGB(110, 186, 101)

            ToggleLocker.Name = "ToggleLocker"
            ToggleLocker.Parent = Toggle
            ToggleLocker.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleLocker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            ToggleLocker.BackgroundTransparency = 1
            ToggleLocker.BorderSizePixel = 0
            ToggleLocker.Position = UDim2.new(0.5, 0, 0.5, 0)
            ToggleLocker.Size = UDim2.new(0, 320, 0, 35)

            ToggleLockerCorner.CornerRadius = UDim.new(0, 5)
            ToggleLockerCorner.Name = "ToggleLockerCorner"
            ToggleLockerCorner.Parent = ToggleLocker

            StrokeToggle.Name = "StrokeToggle"
            StrokeToggle.Parent = FrameToggle
            StrokeToggle.Color = Color3.fromRGB(110, 186, 101)
            StrokeToggle.Thickness = 2

            LockerIcon.Name = "LockerIcon"
            LockerIcon.Parent = ToggleLocker
            LockerIcon.AnchorPoint = Vector2.new(0.5, 0.5)
            LockerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LockerIcon.BackgroundTransparency = 1.000
            LockerIcon.BorderSizePixel = 0
            LockerIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
            LockerIcon.Size = UDim2.new(0, 0, 0, 0)
            LockerIcon.Image = "rbxassetid://6031082533"

            local OldCallback = callback or function() end
            callback = function(Value)
                library.flags[name] = Value
                AddSetting(name, tostring(Value), optionswin.FolderName, optionswin.FileName)
                return OldCallback(Value)
            end

            if default and callback then
                callback(default)
            end

            BtnToggle.MouseButton1Click:Connect(function()
                if LogoToggle.Size == UDim2.new(0, 0, 0, 0) then
                    tweenObject(LogoToggle, {
                        Size = UDim2.new(0, 27, 0, 27)
                    }, 0.15)
                    if callback then
                        callback(true)
                    end
                elseif LogoToggle.Size == UDim2.new(0, 27, 0, 27) then
                    tweenObject(LogoToggle, {
                        Size = UDim2.new(0, 0, 0, 0)
                    }, 0.15)
                    if callback then
                        callback(false)
                    end
                end
            end)

            PageFrame.CanvasSize = UDim2.new(0,0,0,PageFrameListLayout.AbsoluteContentSize.Y + 20)

            local togglefunc = {}
            function togglefunc:UpdateToggle(bool)
                if LogoToggle.Size == UDim2.new(0, 27, 0, 27) and bool == false then
                    tweenObject(LogoToggle, {
                        Size = UDim2.new(0, 0, 0, 0)
                    }, 0.15)
                    toggled = not toggled
                    pcall(callback, bool)
                elseif LogoToggle.Size == UDim2.new(0, 0, 0, 0) and bool == true then
                    tweenObject(LogoToggle, {
                        Size = UDim2.new(0, 27, 0, 27)
                    }, 0.15)
                    toggled = not toggled
                    pcall(callback, bool)
                end
            end
            return togglefunc
        end
        function ContainerContent:Section(name)
            local Section = Instance.new("Frame")
            local SectionLine = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")

            Section.Name = "Section"
            Section.Parent = PageFrame
            Section.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
            Section.BackgroundTransparency = 1.000
            Section.BorderSizePixel = 0
            Section.Position = UDim2.new(0.0417827293, 0, 0.035799522, 0)
            Section.Size = UDim2.new(0, 330, 0, 20)

            SectionLine.Name = "SectionLine"
            SectionLine.Parent = Section
            SectionLine.AnchorPoint = Vector2.new(0.5, 0.5)
            SectionLine.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            SectionLine.BorderSizePixel = 0
            SectionLine.Position = UDim2.new(0.5, 0, 0.5, 0)
            SectionLine.Size = UDim2.new(0, 330, 0, 1)

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            SectionTitle.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
            SectionTitle.BorderSizePixel = 0
            SectionTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
            SectionTitle.Size = UDim2.new(0, 150, 0, 20)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = tostring(name)
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 13.000

            PageFrame.CanvasSize = UDim2.new(0,0,0,PageFrameListLayout.AbsoluteContentSize.Y)
        end
        function ContainerContent:Dropdown(name, default, options, callback)
            default = GetSetting(name, optionswin.FolderName, optionswin.FileName) or default
            if not library.flags[name] then 
                library.flags[name] = default or ""
            end

            local DropTog = false
            local dropfuc = {}

            local Dropdown = Instance.new("Frame")
            local TextDropdownBtn = Instance.new("TextLabel")
            local DropdownFrame = Instance.new("Frame")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownBtnV2 = Instance.new("TextButton")
            local DropdownCornerV2 = Instance.new("UICorner")
            local SearchDrop = Instance.new("TextBox")
            local DropdownLogo = Instance.new("ImageButton")
            local DropdownCorner = Instance.new("UICorner")
            local ItemFrame = Instance.new("Frame")
            local itemOutline = Instance.new("Frame")
            local ScrollingItem = Instance.new("ScrollingFrame")
            local ScrollingItemLayout = Instance.new("UIListLayout")
            local ScrollingItemPadding = Instance.new("UIPadding")
            local itemOutlineCorner = Instance.new("UICorner")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = PageFrame
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.BorderSizePixel = 0
            Dropdown.Size = UDim2.new(0, 320, 0, 35)
            
            TextDropdownBtn.Name = "TextDropdownBtn"
            TextDropdownBtn.Parent = Dropdown
            TextDropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextDropdownBtn.BackgroundTransparency = 1.000
            TextDropdownBtn.BorderSizePixel = 0
            TextDropdownBtn.Size = UDim2.new(0, 320, 0, 150)
            TextDropdownBtn.Font = Enum.Font.GothamSemibold
            TextDropdownBtn.Text = ""
            TextDropdownBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
            TextDropdownBtn.TextSize = 9.000
            
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Parent = TextDropdownBtn
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropdownFrame.BackgroundTransparency = 1.000
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Size = UDim2.new(0, 320, 0, 35)
            
            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = DropdownFrame
            DropdownBtn.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            DropdownBtn.BackgroundTransparency = 0.600
            DropdownBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
            DropdownBtn.Size = UDim2.new(0, 320, 0, 35)
            DropdownBtn.AutoButtonColor = false
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000
            
            DropdownBtnV2.Name = "DropdownBtnV2"
            DropdownBtnV2.Parent = DropdownBtn
            DropdownBtnV2.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownBtnV2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            DropdownBtnV2.BorderSizePixel = 0
            DropdownBtnV2.Position = UDim2.new(0.5, 0, 0.5, 0)
            DropdownBtnV2.Size = UDim2.new(0, 318, 0, 33)
            DropdownBtnV2.Font = Enum.Font.SourceSans
            DropdownBtnV2.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtnV2.TextSize = 14.000
            DropdownBtnV2.Text = ""
            DropdownBtnV2.AutoButtonColor = false
            
            DropdownCornerV2.CornerRadius = UDim.new(0, 4)
            DropdownCornerV2.Name = "DropdownCornerV2"
            DropdownCornerV2.Parent = DropdownBtnV2
            
            SearchDrop.Name = "SearchDrop"
            SearchDrop.Parent = DropdownBtnV2
            SearchDrop.AnchorPoint = Vector2.new(0.5, 0.5)
            SearchDrop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            SearchDrop.BackgroundTransparency = 1.000
            SearchDrop.BorderSizePixel = 0
            SearchDrop.ClipsDescendants = true
            SearchDrop.Position = UDim2.new(0.430000007, 0, 0.5, 0)
            SearchDrop.Size = UDim2.new(0, 260, 0, 28)
            SearchDrop.Font = Enum.Font.GothamSemibold
            SearchDrop.PlaceholderColor3 = Color3.fromRGB(222, 222, 222)
            SearchDrop.PlaceholderText = tostring(name).." : " .. tostring(default)
            SearchDrop.Text = ""
            SearchDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchDrop.TextSize = 12.000
            SearchDrop.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownLogo.Name = "DropdownLogo"
            DropdownLogo.Parent = DropdownBtnV2
            DropdownLogo.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownLogo.BackgroundTransparency = 1.000
            DropdownLogo.BorderSizePixel = 0
            DropdownLogo.Position = UDim2.new(0.939999998, 0, 0.5, 0)
            DropdownLogo.Size = UDim2.new(0, 30, 0, 30)
            DropdownLogo.Image = "http://www.roblox.com/asset/?id=6031091004"
            
            DropdownCorner.CornerRadius = UDim.new(0, 4)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = DropdownBtn

            ItemFrame.Name = "ItemFrame"
            ItemFrame.Parent = PageFrame
            ItemFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ItemFrame.BackgroundTransparency = 1.000
            ItemFrame.BorderSizePixel = 0
            ItemFrame.Size = UDim2.new(0, 320, 0, 0)
            ItemFrame.ClipsDescendants = true

            itemOutline.Name = "itemOutline"
            itemOutline.Parent = ItemFrame
            itemOutline.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            itemOutline.BorderSizePixel = 0
            itemOutline.ClipsDescendants = true
            itemOutline.Position = UDim2.new(0, 0, 0, 0)
            itemOutline.Size = UDim2.new(0, 320, 0, 140)

            ScrollingItem.Name = "ScrollingItem"
            ScrollingItem.Parent = itemOutline
            ScrollingItem.Active = true
            ScrollingItem.AnchorPoint = Vector2.new(0.5, 0.5)
            ScrollingItem.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
            ScrollingItem.BorderSizePixel = 0
            ScrollingItem.Position = UDim2.new(0.5, 0, 0.5, 0)
            ScrollingItem.Size = UDim2.new(0, 318, 0, 138)
            ScrollingItem.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollingItem.ScrollBarThickness = 3

            ScrollingItemLayout.Name = "ScrollingItemLayout"
            ScrollingItemLayout.Parent = ScrollingItem
            ScrollingItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ScrollingItemLayout.Padding = UDim.new(0, 5)

            ScrollingItemPadding.Name = "ScrollingItemPadding"
            ScrollingItemPadding.Parent = ScrollingItem
            ScrollingItemPadding.PaddingTop = UDim.new(0, 2)

            itemOutlineCorner.CornerRadius = UDim.new(0, 3)
            itemOutlineCorner.Name = "itemOutlineCorner"
            itemOutlineCorner.Parent = itemOutline

            local OldCallback = callback or function() end
            callback = function(Value)
                library.flags[name] = Value
                AddSetting(name, tostring(Value), optionswin.FolderName, optionswin.FileName)
                return OldCallback(Value)
            end

            if default and callback then 
                callback(default)
            end

            DropdownBtn.MouseEnter:Connect(function()
                TweenService:Create(
                    DropdownBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()
            end)

            DropdownBtn.MouseLeave:Connect(function()
                TweenService:Create(
                    DropdownBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0.6}
                ):Play()
            end)

            DropdownLogo.MouseButton1Click:Connect(function()
                if DropTog == false then
                    TweenService:Create(
                        ItemFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 320, 0, 150)}
                    ):Play()
                    TweenService:Create(
                        DropdownLogo,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 180}
                    ):Play()
                else
                    TweenService:Create(
                        ItemFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 320, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        DropdownLogo,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                end
                DropTog = not DropTog
            end)

            for i,v in next, options do
                local ItemDrop = Instance.new("Frame")
                local TextButton = Instance.new("TextButton")
                local TextLabel = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                ItemDrop.Name = "ItemDrop"
                ItemDrop.Parent = ScrollingItem
                ItemDrop.AnchorPoint = Vector2.new(0.5, 0.5)
                ItemDrop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ItemDrop.BackgroundTransparency = 1.000
                ItemDrop.BorderSizePixel = 0
                ItemDrop.Size = UDim2.new(0, 320, 0, 30)

                TextButton.Parent = ItemDrop
                TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
                TextButton.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                TextButton.BackgroundTransparency = 0.300
                TextButton.BorderSizePixel = 0
                TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextButton.Size = UDim2.new(0, 310, 0, 30)
                TextButton.AutoButtonColor = false
                TextButton.Font = Enum.Font.SourceSans
                TextButton.Text = ""
                TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextButton.TextSize = 14.000

                TextLabel.Parent = TextButton
                TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.BorderSizePixel = 0
                TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextLabel.Size = UDim2.new(0, 91, 0, 25)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextSize = 12.000
                TextLabel.Text = tostring(v)

                UICorner.CornerRadius = UDim.new(0, 5)
                UICorner.Parent = TextButton

                TextButton.MouseEnter:Connect(function()
                    TweenService:Create(
                        TextButton,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(110, 186, 101)}
                    ):Play()
                end)

                TextButton.MouseLeave:Connect(function()
                    TweenService:Create(
                        TextButton,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}
                    ):Play()
                end)

                TextButton.MouseButton1Click:Connect(function()
                    TweenService:Create(
                        ItemFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 320, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        DropdownLogo,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                    SearchDrop.PlaceholderText = tostring(name)..": "..tostring(v)
                    callback(v)
                end)

                SearchDrop:GetPropertyChangedSignal("Text"):Connect(function()
                    for i , v in pairs(ScrollingItem:GetChildren()) do
                        if v.Name == "ItemDrop" then
                            for i2 , v2 in pairs(v:GetChildren()) do
                                if v2.Name == "TextButton" then
                                    if string.find(tostring(string.lower(v2.TextLabel.Text)), string.lower(SearchDrop.Text)) then
                                        v.Visible = true
                                    else
                                        v.Visible = false
                                    end
                                    if SearchDrop.Text == "" or nil then
                                        v.Visible = true 
                                    end
                                end
                            end
                        end
                    end
                end)

                game:GetService("RunService").Stepped:Connect(function ()
                    pcall(function ()
                        ScrollingItem.CanvasSize = UDim2.new(0, 5, 0, ScrollingItemLayout.AbsoluteContentSize.Y + 5)
                        PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageFrameListLayout.AbsoluteContentSize.Y + 20)
                    end)
                end)
            end

            function dropfuc:Clear()
                for i, v in next, ScrollingItem:GetChildren() do
                    if v:IsA("Frame") then
                        v:Destroy()
                    end
                    ScrollingItem.CanvasSize = UDim2.new(0, 5, 0, ScrollingItemLayout.AbsoluteContentSize.Y + 20)
                end
            end

            function dropfuc:Add(name2)
                local ItemDrop = Instance.new("Frame")
                local TextButton = Instance.new("TextButton")
                local TextLabel = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                ItemDrop.Name = "ItemDrop"
                ItemDrop.Parent = ScrollingItem
                ItemDrop.AnchorPoint = Vector2.new(0.5, 0.5)
                ItemDrop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ItemDrop.BackgroundTransparency = 1.000
                ItemDrop.BorderSizePixel = 0
                ItemDrop.Size = UDim2.new(0, 320, 0, 30)

                TextButton.Parent = ItemDrop
                TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
                TextButton.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                TextButton.BackgroundTransparency = 0.300
                TextButton.BorderSizePixel = 0
                TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextButton.Size = UDim2.new(0, 310, 0, 30)
                TextButton.AutoButtonColor = false
                TextButton.Font = Enum.Font.SourceSans
                TextButton.Text = ""
                TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextButton.TextSize = 14.000

                TextLabel.Parent = TextButton
                TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.BorderSizePixel = 0
                TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextLabel.Size = UDim2.new(0, 91, 0, 25)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextSize = 12.000
                TextLabel.Text = tostring(name2)

                UICorner.CornerRadius = UDim.new(0, 5)
                UICorner.Parent = TextButton

                TextButton.MouseEnter:Connect(function()
                    TweenService:Create(
                        TextButton,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(110, 186, 101)}
                    ):Play()
                end)

                TextButton.MouseLeave:Connect(function()
                    TweenService:Create(
                        TextButton,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}
                    ):Play()
                end)

                TextButton.MouseButton1Click:Connect(function()
                    TweenService:Create(
                        ItemFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 320, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        DropdownLogo,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                    SearchDrop.PlaceholderText = tostring(name).." : "..tostring(name2)
                    callback(name2)
                end)

                SearchDrop:GetPropertyChangedSignal("Text"):Connect(function()
                    for i , v in pairs(ScrollingItem:GetChildren()) do
                        if v.Name == "ItemDrop" then
                            for i2 , v2 in pairs(v:GetChildren()) do
                                if v2.Name == "TextButton" then
                                    if string.find(tostring(string.lower(v2.TextLabel.Text)), string.lower(SearchDrop.Text)) then
                                        v.Visible = true
                                    else
                                        v.Visible = false
                                    end
                                    if SearchDrop.Text == "" or nil then
                                        v.Visible = true 
                                    end
                                end
                            end
                        end
                    end
                end)
            end
            return dropfuc
        end
        function ContainerContent:MultiDropdown(name, default, options, callback)
            default = GetSetting(name, optionswin.FolderName, optionswin.FileName) or default
            if not library.flags[name] then 
                library.flags[name] = default or ""
            end

            local DropTog = false
            local multi_table = {}

            local Dropdown = Instance.new("Frame")
            local TextDropdownBtn = Instance.new("TextLabel")
            local DropdownFrame = Instance.new("Frame")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownBtnV2 = Instance.new("TextButton")
            local DropdownCornerV2 = Instance.new("UICorner")
            local SearchDrop = Instance.new("TextBox")
            local DropdownLogo = Instance.new("ImageButton")
            local DropdownCorner = Instance.new("UICorner")
            local ItemFrame = Instance.new("Frame")
            local itemOutline = Instance.new("Frame")
            local ScrollingItem = Instance.new("ScrollingFrame")
            local ScrollingItemLayout = Instance.new("UIListLayout")
            local ScrollingItemPadding = Instance.new("UIPadding")
            local itemOutlineCorner = Instance.new("UICorner")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = PageFrame
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.BorderSizePixel = 0
            Dropdown.Size = UDim2.new(0, 320, 0, 35)
            
            TextDropdownBtn.Name = "TextDropdownBtn"
            TextDropdownBtn.Parent = Dropdown
            TextDropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextDropdownBtn.BackgroundTransparency = 1.000
            TextDropdownBtn.BorderSizePixel = 0
            TextDropdownBtn.Size = UDim2.new(0, 320, 0, 150)
            TextDropdownBtn.Font = Enum.Font.GothamSemibold
            TextDropdownBtn.Text = ""
            TextDropdownBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
            TextDropdownBtn.TextSize = 9.000
            
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Parent = TextDropdownBtn
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropdownFrame.BackgroundTransparency = 1.000
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Size = UDim2.new(0, 320, 0, 35)
            
            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = DropdownFrame
            DropdownBtn.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            DropdownBtn.BackgroundTransparency = 0.600
            DropdownBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
            DropdownBtn.Size = UDim2.new(0, 320, 0, 35)
            DropdownBtn.AutoButtonColor = false
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000
            
            DropdownBtnV2.Name = "DropdownBtnV2"
            DropdownBtnV2.Parent = DropdownBtn
            DropdownBtnV2.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownBtnV2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            DropdownBtnV2.BorderSizePixel = 0
            DropdownBtnV2.Position = UDim2.new(0.5, 0, 0.5, 0)
            DropdownBtnV2.Size = UDim2.new(0, 318, 0, 33)
            DropdownBtnV2.Font = Enum.Font.SourceSans
            DropdownBtnV2.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtnV2.TextSize = 14.000
            DropdownBtnV2.Text = ""
            DropdownBtnV2.AutoButtonColor = false
            
            DropdownCornerV2.CornerRadius = UDim.new(0, 4)
            DropdownCornerV2.Name = "DropdownCornerV2"
            DropdownCornerV2.Parent = DropdownBtnV2
            
            SearchDrop.Name = "SearchDrop"
            SearchDrop.Parent = DropdownBtnV2
            SearchDrop.AnchorPoint = Vector2.new(0.5, 0.5)
            SearchDrop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            SearchDrop.BackgroundTransparency = 1.000
            SearchDrop.BorderSizePixel = 0
            SearchDrop.ClipsDescendants = true
            SearchDrop.Position = UDim2.new(0.430000007, 0, 0.5, 0)
            SearchDrop.Size = UDim2.new(0, 260, 0, 28)
            SearchDrop.Font = Enum.Font.GothamSemibold
            SearchDrop.PlaceholderColor3 = Color3.fromRGB(222, 222, 222)
            SearchDrop.PlaceholderText = tostring(name).." : " .. tostring(default)
            SearchDrop.Text = ""
            SearchDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchDrop.TextSize = 12.000
            SearchDrop.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownLogo.Name = "DropdownLogo"
            DropdownLogo.Parent = DropdownBtnV2
            DropdownLogo.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownLogo.BackgroundTransparency = 1.000
            DropdownLogo.BorderSizePixel = 0
            DropdownLogo.Position = UDim2.new(0.939999998, 0, 0.5, 0)
            DropdownLogo.Size = UDim2.new(0, 30, 0, 30)
            DropdownLogo.Image = "http://www.roblox.com/asset/?id=6031091004"
            
            DropdownCorner.CornerRadius = UDim.new(0, 4)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = DropdownBtn

            ItemFrame.Name = "ItemFrame"
            ItemFrame.Parent = PageFrame
            ItemFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ItemFrame.BackgroundTransparency = 1.000
            ItemFrame.BorderSizePixel = 0
            ItemFrame.Size = UDim2.new(0, 320, 0, 0)
            ItemFrame.ClipsDescendants = true

            itemOutline.Name = "itemOutline"
            itemOutline.Parent = ItemFrame
            itemOutline.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            itemOutline.BorderSizePixel = 0
            itemOutline.ClipsDescendants = true
            itemOutline.Position = UDim2.new(0, 0, 0, 0)
            itemOutline.Size = UDim2.new(0, 320, 0, 140)

            ScrollingItem.Name = "ScrollingItem"
            ScrollingItem.Parent = itemOutline
            ScrollingItem.Active = true
            ScrollingItem.AnchorPoint = Vector2.new(0.5, 0.5)
            ScrollingItem.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
            ScrollingItem.BorderSizePixel = 0
            ScrollingItem.Position = UDim2.new(0.5, 0, 0.5, 0)
            ScrollingItem.Size = UDim2.new(0, 318, 0, 138)
            ScrollingItem.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollingItem.ScrollBarThickness = 3

            ScrollingItemLayout.Name = "ScrollingItemLayout"
            ScrollingItemLayout.Parent = ScrollingItem
            ScrollingItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ScrollingItemLayout.Padding = UDim.new(0, 5)

            ScrollingItemPadding.Name = "ScrollingItemPadding"
            ScrollingItemPadding.Parent = ScrollingItem
            ScrollingItemPadding.PaddingTop = UDim.new(0, 2)

            itemOutlineCorner.CornerRadius = UDim.new(0, 3)
            itemOutlineCorner.Name = "itemOutlineCorner"
            itemOutlineCorner.Parent = itemOutline

            local OldCallback = callback or function() end
            callback = function(Value)
                library.flags[name] = Value
                AddSetting(name, Value, optionswin.FolderName, optionswin.FileName)
                return OldCallback(Value)
            end

            if type(default) == "table" and callback then 
                local EncodeDefault = Http:JSONEncode(default)
                local DeleteDeafault = string.gsub(tostring(EncodeDefault), '"', " ")
                SearchDrop.PlaceholderText = tostring(name).." : "..tostring(DeleteDeafault)
                for i,v in next, default do
                    table.insert(multi_table, v)
                end
                callback(multi_table)
            end

            DropdownBtn.MouseEnter:Connect(function()
                tweenObject(DropdownBtn, {
                    BackgroundTransparency = 0
                }, 0.3)
            end)

            DropdownBtn.MouseLeave:Connect(function()
                tweenObject(DropdownBtn, {
                    BackgroundTransparency = 0.6
                }, 0.3)
            end)

            DropdownLogo.MouseButton1Click:Connect(function()
                if DropTog == false then
                    tweenObject(ItemFrame, {
                        Size = UDim2.new(0, 320, 0, 150)
                    }, 0.2)
                    tweenObject(DropdownLogo, {
                        Rotation = 180
                    }, 0.2)
                else
                    tweenObject(ItemFrame, {
                        Size = UDim2.new(0, 320, 0, 0)
                    }, 0.2)
                    tweenObject(DropdownLogo, {
                        Rotation = 0
                    }, 0.2)
                end
                DropTog = not DropTog
            end)

            for i,v in next, options do
                local ItemDrop = Instance.new("Frame")
                local TextButton = Instance.new("TextButton")
                local TextLabel = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                ItemDrop.Name = "ItemDrop"
                ItemDrop.Parent = ScrollingItem
                ItemDrop.AnchorPoint = Vector2.new(0.5, 0.5)
                ItemDrop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ItemDrop.BackgroundTransparency = 1.000
                ItemDrop.BorderSizePixel = 0
                ItemDrop.Size = UDim2.new(0, 320, 0, 30)

                TextButton.Parent = ItemDrop
                TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
                TextButton.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                TextButton.BackgroundTransparency = 0.300
                TextButton.BorderSizePixel = 0
                TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextButton.Size = UDim2.new(0, 310, 0, 30)
                TextButton.AutoButtonColor = false
                TextButton.Font = Enum.Font.SourceSans
                TextButton.Text = ""
                TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextButton.TextSize = 14.000

                TextLabel.Parent = TextButton
                TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.BorderSizePixel = 0
                TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextLabel.Size = UDim2.new(0, 91, 0, 25)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextSize = 12.000
                TextLabel.Text = tostring(v)

                UICorner.CornerRadius = UDim.new(0, 5)
                UICorner.Parent = TextButton

                TextButton.MouseEnter:Connect(function()
                    tweenObject(TextButton, {
                        BackgroundColor3 = Color3.fromRGB(110, 186, 101)
                    }, 0.2)
                end)

                TextButton.MouseLeave:Connect(function()
                    if not table.find(multi_table, v) then
                        tweenObject(TextButton, {
                            BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                        }, 0.2)
                    end
                end)

                if table.find(multi_table, v) then
                    tweenObject(TextButton, {
                        BackgroundColor3 = Color3.fromRGB(110, 186, 101)
                    }, 0.2)
                end

                -- for i2,v2 in next, multi_table do
                --     if not table.find(multi_table, v) then
                --         table.remove(multi_table, i2)
                --     end
                -- end

                TextButton.MouseButton1Click:Connect(function()
                    if not table.find(multi_table, v) then
                        table.insert(multi_table, v)
                        tweenObject(TextButton, {
                            BackgroundColor3 = Color3.fromRGB(110, 186, 101)
                        }, 0.2)
                        local table,value = multi_table,v
                        local Encode = Http:JSONEncode(multi_table)
                        local Delete = string.gsub(tostring(Encode), '"', " ")
                        SearchDrop.PlaceholderText = tostring(name).." : "..tostring(Delete)
                        callback(table,value)
                    else
                        tweenObject(TextButton, {
                            BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                        }, 0.2)
                        for i2,v2 in pairs(multi_table) do
                            if v2 == v then
                                table.remove(multi_table, i2)
                            end
                        end
                        local table,value = multi_table,v
                        local Encode2 = Http:JSONEncode(multi_table)
                        local Delete = string.gsub(tostring(Encode2), '"', " ")
                        SearchDrop.PlaceholderText = tostring(name).." : "..tostring(Delete)
                        callback(table,value)
                        if #multi_table <= 0 then
                            SearchDrop.PlaceholderText = tostring(name).." : "
                        end
                    end
                end)

                SearchDrop:GetPropertyChangedSignal("Text"):Connect(function()
                    for i , v in pairs(ScrollingItem:GetChildren()) do
                        if v.Name == "ItemDrop" then
                            for i2 , v2 in pairs(v:GetChildren()) do
                                if v2.Name == "TextButton" then
                                    if string.find(tostring(string.lower(v2.TextLabel.Text)), string.lower(SearchDrop.Text)) then
                                        v.Visible = true
                                    else
                                        v.Visible = false
                                    end
                                    if SearchDrop.Text == "" or nil then
                                        v.Visible = true 
                                    end
                                end
                            end
                        end
                    end
                end)

                game:GetService("RunService").Stepped:Connect(function ()
                    pcall(function ()
                        ScrollingItem.CanvasSize = UDim2.new(0, 5, 0, ScrollingItemLayout.AbsoluteContentSize.Y + 5)
                        PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageFrameListLayout.AbsoluteContentSize.Y + 20)
                    end)
                end)
            end
        end
        function ContainerContent:Label(name)
            local labelfunc = {}
            local Label = Instance.new("Frame")
            local TitleLabel = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.Parent = PageFrame
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(0, 320, 0, 35)

            TitleLabel.Name = "TitleLabel"
            TitleLabel.Parent = Label
            TitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.BackgroundTransparency = 1.000
            TitleLabel.BorderSizePixel = 0
            TitleLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            TitleLabel.Size = UDim2.new(0, 320, 0, 35)
            TitleLabel.Font = Enum.Font.GothamBold
            TitleLabel.Text = tostring(name)
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 14.000

            PageFrame.CanvasSize = UDim2.new(0,0,0,PageFrameListLayout.AbsoluteContentSize.Y + 25)

            function labelfunc:ReLabel(tochange)
				TitleLabel.Text = tochange
			end
            return labelfunc
        end
        function ContainerContent:TextBox(name, holder, default, save, callback)
            if save then
                default = GetSetting(name, optionswin.FolderName, optionswin.FileName) or default 
                if not library.flags[name] then 
                    library.flags[name] = default or ""
                end
            end

            local Textbox = Instance.new("Frame")
            local TextBoxTitle = Instance.new("TextLabel")
            local ContentFrame = Instance.new("Frame")
            local ContentFrameCorner = Instance.new("UICorner")
            local OutContentFrame = Instance.new("Frame")
            local OutContentFrameCorner = Instance.new("UICorner")
            local ContentBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = PageFrame
            Textbox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            Textbox.BackgroundTransparency = 1.000
            Textbox.BorderSizePixel = 0
            Textbox.Size = UDim2.new(0, 320, 0, 35)

            TextBoxTitle.Name = "TextBoxTitle"
            TextBoxTitle.Parent = Textbox
            TextBoxTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxTitle.BackgroundTransparency = 1.000
            TextBoxTitle.BorderSizePixel = 0
            TextBoxTitle.Position = UDim2.new(0.23875007, 0, 0.5, 0)
            TextBoxTitle.Size = UDim2.new(0, 126, 0, 30)
            TextBoxTitle.Font = Enum.Font.GothamMedium
            TextBoxTitle.Text = tostring(name)
            TextBoxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBoxTitle.TextSize = 13.000
            TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left

            ContentFrame.Name = "ContentFrame"
            ContentFrame.Parent = Textbox
            ContentFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            ContentFrame.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            ContentFrame.BackgroundTransparency = 0.300
            ContentFrame.BorderSizePixel = 0
            ContentFrame.Position = UDim2.new(0.727812588, 0, 0.5, 0)
            ContentFrame.Size = UDim2.new(0, 167, 0, 25)

            ContentFrameCorner.CornerRadius = UDim.new(0, 5)
            ContentFrameCorner.Name = "ContentFrameCorner"
            ContentFrameCorner.Parent = ContentFrame

            OutContentFrame.Name = "OutContentFrame"
            OutContentFrame.Parent = ContentFrame
            OutContentFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            OutContentFrame.BackgroundColor3 = Color3.fromRGB(58, 97, 53)
            OutContentFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            OutContentFrame.Size = UDim2.new(0, 165, 0, 23)

            OutContentFrameCorner.CornerRadius = UDim.new(0, 5)
            OutContentFrameCorner.Name = "OutContentFrameCorner"
            OutContentFrameCorner.Parent = OutContentFrame

            ContentBox.Name = "ContentBox"
            ContentBox.Parent = OutContentFrame
            ContentBox.AnchorPoint = Vector2.new(0.5, 0.5)
            ContentBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ContentBox.BackgroundTransparency = 1.000
            ContentBox.BorderSizePixel = 0
            ContentBox.Position = UDim2.new(0.516969621, 0, 0.5, 0)
            ContentBox.Size = UDim2.new(0, 160, 0, 23)
            ContentBox.Font = Enum.Font.GothamMedium
            ContentBox.PlaceholderColor3 = Color3.fromRGB(222, 222, 222)
            ContentBox.PlaceholderText = tostring(holder)
            ContentBox.Text = tostring(default)
            ContentBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            ContentBox.TextSize = 13.000
            ContentBox.TextWrapped = true
            ContentBox.TextXAlignment = Enum.TextXAlignment.Left

            if save then
                local OldCallback = callback or function() end
                callback = function(Value)
                    library.flags[name] = Value
                    AddSetting(name, tostring(Value), optionswin.FolderName, optionswin.FileName)
                    return OldCallback(Value)
                end
            end

            ContentBox.FocusLost:Connect(function()
                if #ContentBox.Text > 0 then
                    pcall(callback, ContentBox.Text)
                end
            end)

            if default and callback and save then 
                callback(default)
            end
        end
        function ContainerContent:Slider(name, options, callback)
            if not library.flags[name] then 
                library.flags[name] = options.default or options.min
            end 
            local setting = GetSetting(name, optionswin.FolderName, optionswin.FileName)
            setting = setting and tonumber(setting)
            options.default = setting or options.default

            local Slider = Instance.new("Frame")
            local SliderCorner = Instance.new("UICorner")
            local SliderBtn = Instance.new("TextButton")
            local SliderFrame = Instance.new("Frame")
            local SliderFrameCorner = Instance.new("UICorner")
            local CustomValueFrame = Instance.new("Frame")
            local OutBottomCustom = Instance.new("Frame")
            local CustomValue = Instance.new("TextBox")
            local ValueFrame = Instance.new("Frame")
            local ValueFrameCorner = Instance.new("UICorner")
            local ValueBtn = Instance.new("TextButton")
            local CurrentFrame = Instance.new("Frame")
            local CurrentFrameCorner = Instance.new("UICorner")
            local TitleSlider = Instance.new("TextLabel")
            local PlusBtn = Instance.new("TextButton")
            local MinusBtn = Instance.new("TextButton")

            Slider.Name = "Slider"
            Slider.Parent = PageFrame
            Slider.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            Slider.BackgroundTransparency = 0.600
            Slider.BorderSizePixel = 0
            Slider.Size = UDim2.new(0, 320, 0, 50)

            SliderCorner.CornerRadius = UDim.new(0, 5)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderBtn.Name = "SliderBtn"
            SliderBtn.Parent = Slider
            SliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderBtn.BackgroundTransparency = 1.000
            SliderBtn.BorderSizePixel = 0
            SliderBtn.Size = UDim2.new(0, 330, 0, 50)
            SliderBtn.AutoButtonColor = false
            SliderBtn.Font = Enum.Font.SourceSans
            SliderBtn.Text = ""
            SliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            SliderBtn.TextSize = 14.000

            SliderFrame.Name = "SliderFrame"
            SliderFrame.Parent = Slider
            SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            SliderFrame.Size = UDim2.new(0, 318, 0, 48)

            SliderFrameCorner.CornerRadius = UDim.new(0, 5)
            SliderFrameCorner.Name = "SliderFrameCorner"
            SliderFrameCorner.Parent = SliderFrame

            CustomValueFrame.Name = "CustomValueFrame"
            CustomValueFrame.Parent = SliderFrame
            CustomValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            CustomValueFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CustomValueFrame.BackgroundTransparency = 1.000
            CustomValueFrame.BorderSizePixel = 0
            CustomValueFrame.Position = UDim2.new(0.850000024, 0, 0.300000012, 0)
            CustomValueFrame.Size = UDim2.new(0, 40, 0, 20)

            OutBottomCustom.Name = "OutBottomCustom"
            OutBottomCustom.Parent = CustomValueFrame
            OutBottomCustom.AnchorPoint = Vector2.new(0.5, 0.5)
            OutBottomCustom.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            OutBottomCustom.Position = UDim2.new(0.5, 0, 0.899999976, 0)
            OutBottomCustom.Size = UDim2.new(0, 40, 0, 1)

            CustomValue.Name = "CustomValue"
            CustomValue.Parent = CustomValueFrame
            CustomValue.AnchorPoint = Vector2.new(0.5, 0.5)
            CustomValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CustomValue.BackgroundTransparency = 1.000
            CustomValue.BorderSizePixel = 0
            CustomValue.Position = UDim2.new(0.5, 0, 0.5, 0)
            CustomValue.Size = UDim2.new(0, 40, 0, 20)
            CustomValue.Font = Enum.Font.GothamMedium
            CustomValue.Text = options.default or options.min < 0 and options.max > 0 and "0" or tostring(options.min)
            CustomValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            CustomValue.TextSize = 12.000
            CustomValue.TextTransparency = 0.300

            ValueFrame.Name = "ValueFrame"
            ValueFrame.Parent = SliderFrame
            ValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            ValueFrame.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
            ValueFrame.BackgroundTransparency = 0.300
            ValueFrame.BorderSizePixel = 0
            ValueFrame.Position = UDim2.new(0.5, 0, 0.75, 0)
            ValueFrame.Size = UDim2.new(0, 310, 0, 6)

            ValueFrameCorner.CornerRadius = UDim.new(1, 8)
            ValueFrameCorner.Name = "ValueFrameCorner"
            ValueFrameCorner.Parent = ValueFrame

            ValueBtn.Name = "ValueBtn"
            ValueBtn.Parent = ValueFrame
            ValueBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ValueBtn.BackgroundTransparency = 1.000
            ValueBtn.BorderSizePixel = 0
            ValueBtn.Size = UDim2.new(0, 310, 0, 6)
            ValueBtn.AutoButtonColor = false
            ValueBtn.Font = Enum.Font.SourceSans
            ValueBtn.Text = ""
            ValueBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ValueBtn.TextSize = 14.000

            CurrentFrame.Name = "CurrentFrame"
            CurrentFrame.Parent = ValueFrame
            CurrentFrame.BackgroundColor3 = Color3.fromRGB(110, 186, 101)
            CurrentFrame.BackgroundTransparency = 0.300
            CurrentFrame.BorderSizePixel = 0
            CurrentFrame.Size = UDim2.new(0, 150, 0, 6)

            CurrentFrameCorner.CornerRadius = UDim.new(1, 8)
            CurrentFrameCorner.Name = "CurrentFrameCorner"
            CurrentFrameCorner.Parent = CurrentFrame

            TitleSlider.Name = "TitleSlider"
            TitleSlider.Parent = SliderFrame
            TitleSlider.AnchorPoint = Vector2.new(0.5, 0.5)
            TitleSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TitleSlider.BackgroundTransparency = 1.000
            TitleSlider.BorderSizePixel = 0
            TitleSlider.Position = UDim2.new(0.273597628, 0, 0.299999863, 0)
            TitleSlider.Size = UDim2.new(0, 163, 0, 25)
            TitleSlider.Font = Enum.Font.GothamMedium
            TitleSlider.Text = tostring(name)
            TitleSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleSlider.TextSize = 13.000
            TitleSlider.TextTransparency = 0.300
            TitleSlider.TextXAlignment = Enum.TextXAlignment.Left

            PlusBtn.Name = "PlusBtn"
            PlusBtn.Parent = SliderFrame
            PlusBtn.AnchorPoint = Vector2.new(0.5, 0.5)
            PlusBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            PlusBtn.BackgroundTransparency = 1.000
            PlusBtn.BorderSizePixel = 0
            PlusBtn.Position = UDim2.new(0.959999979, 0, 0.300000012, 0)
            PlusBtn.Size = UDim2.new(0, 25, 0, 25)
            PlusBtn.AutoButtonColor = false
            PlusBtn.Font = Enum.Font.GothamBold
            PlusBtn.Text = "+"
            PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlusBtn.TextSize = 14.000
            PlusBtn.TextTransparency = 0.300

            MinusBtn.Name = "MinusBtn"
            MinusBtn.Parent = SliderFrame
            MinusBtn.AnchorPoint = Vector2.new(0.5, 0.5)
            MinusBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MinusBtn.BackgroundTransparency = 1.000
            MinusBtn.BorderSizePixel = 0
            MinusBtn.Position = UDim2.new(0.730000019, 0, 0.300000012, 0)
            MinusBtn.Size = UDim2.new(0, 25, 0, 25)
            MinusBtn.AutoButtonColor = false
            MinusBtn.Font = Enum.Font.GothamBold
            MinusBtn.Text = "-"
            MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            MinusBtn.TextSize = 14.000
            MinusBtn.TextTransparency = 0.300

            local OldCallback = callback or function() end
            callback = function(Value)
                library.flags[name] = Value
                AddSetting(name, tostring(Value), optionswin.FolderName, optionswin.FileName)
                return OldCallback(Value)
            end

            SliderBtn.MouseEnter:Connect(function()
                tweenObject(Slider, {
                    BackgroundTransparency = 0
                }, 0.3)
                tweenObject(TitleSlider, {
                    TextTransparency = 0
                }, 0.3)
                tweenObject(MinusBtn, {
                    TextTransparency = 0
                }, 0.3)
                tweenObject(PlusBtn, {
                    TextTransparency = 0
                }, 0.3)
                tweenObject(CustomValue, {
                    TextTransparency = 0
                }, 0.3)
                tweenObject(CurrentFrame, {
                    BackgroundTransparency = 0
                }, 0.3)
                tweenObject(OutBottomCustom, {
                    BackgroundTransparency = 0
                }, 0.3)
            end)

            SliderBtn.MouseLeave:Connect(function()
                tweenObject(Slider, {
                    BackgroundTransparency = 0.6
                }, 0.3)
                tweenObject(TitleSlider, {
                    TextTransparency = 0.3
                }, 0.3)
                tweenObject(MinusBtn, {
                    TextTransparency = 0.3
                }, 0.3)
                tweenObject(PlusBtn, {
                    TextTransparency = 0.3
                }, 0.3)
                tweenObject(CustomValue, {
                    TextTransparency = 0.3
                }, 0.3)
                tweenObject(CurrentFrame, {
                    BackgroundTransparency = 0.3
                }, 0.3)
                tweenObject(OutBottomCustom, {
                    BackgroundTransparency = 0.6
                }, 0.3)
            end)

            if options.default then
                value = math.clamp(options.default, options.min, options.max)
                local percent = 1 - ((options.max - value) / (options.max - options.min))
                tweenObject(CurrentFrame, {
                    Size = UDim2.new(0, percent * 310, 0, 6)
                }, 0.1)
                manual = true
                CustomValue.Text = tostring(value)
                manual = false
                callback(value)
            end

            local value = options.default or options.min;
            local connections = {}
            local manual = false

            MinusBtn.MouseButton1Click:Connect(function()
                value = math.clamp(value - 1, options.min, options.max)
                local percent = 1 - ((options.max - value) / (options.max - options.min))
                tweenObject(CurrentFrame, {
                    Size = UDim2.new(0, percent * 310, 0, 6)
                }, 0.1)
                manual = true
                CustomValue.Text = tostring(value)
                manual = false
                if callback then
                    callback(value)
                end
            end)

            PlusBtn.MouseButton1Click:Connect(function()
                value = math.clamp(value + 1, options.min, options.max)
                local percent = 1 - ((options.max - value) / (options.max - options.min))
                tweenObject(CurrentFrame, {
                    Size = UDim2.new(0, percent * 310, 0, 6)
                }, 0.1)
                manual = true
                CustomValue.Text = tostring(value)
                manual = false
                if callback then
                    callback(value)
                end
            end)

            CustomValue:GetPropertyChangedSignal("Text"):Connect(function()
                if not manual then
                    if tonumber(CustomValue.Text) ~= nil then
                        value = math.clamp(tonumber(CustomValue.Text), options.min, options.max)
                        local percent = 1 - ((options.max - value) / (options.max - options.min))
                        tweenObject(CurrentFrame, {
                            Size = UDim2.new(0, percent * 310, 0, 6)
                        }, 0.1)
                        local con
                        con = CustomValue.FocusLost:Connect(function()
                            con:Disconnect()
                            if callback then
                                callback(value)
                            end
                        end)
                    end
                end
            end)

            ValueBtn.MouseButton1Down:Connect(function()
                value = math.floor((((tonumber(options.max) - tonumber(options.min)) / 310) * CurrentFrame.AbsoluteSize.X) + tonumber(options.min) + 0.5) or 0
                CustomValue.Text = value
                tweenObject(CurrentFrame, {
                    Size = UDim2.new(0, math.clamp(Mouse.X - CurrentFrame.AbsolutePosition.X, 0, 310), 0, 6)
                }, 0.1)
                if callback then
                    callback(value)
                end
                connections.MoveConnection = Mouse.Move:Connect(function()
                    value = math.floor((((tonumber(options.max) - tonumber(options.min)) / 310) * CurrentFrame.AbsoluteSize.X) + tonumber(options.min) + 0.5) or 0
                    CustomValue.Text = value
                    tweenObject(CurrentFrame, {
                        Size = UDim2.new(0, math.clamp(Mouse.X - CurrentFrame.AbsolutePosition.X, 0, 310), 0, 6)
                    }, 0.1)
                    if callback then
                        callback(value)
                    end
                end)
                connections.ReleaseConnection = UserInputService.InputEnded:Connect(function(mouse)
                    if mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                        value = math.floor((((tonumber(options.max) - tonumber(options.min)) / 310) * CurrentFrame.AbsoluteSize.X) + tonumber(options.min) + 0.5) or 0
                        CustomValue.Text = value
                        tweenObject(CurrentFrame, {
                            Size = UDim2.new(0, math.clamp(Mouse.X - CurrentFrame.AbsolutePosition.X, 0, 310), 0, 6)
                        }, 0.1)
                        connections.MoveConnection:Disconnect()
                        connections.ReleaseConnection:Disconnect()
                        if callback then
                            callback(value)
                        end
                    end
                end)
            end)

            PageFrame.CanvasSize = UDim2.new(0,0,0,PageFrameListLayout.AbsoluteContentSize.Y + 25)
        end
        return ContainerContent
    end
    return window
end
------------------------------------------------------
local loadstart = os.clock()
-- // Global Services \\ --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
-- // Global Variable || --
local PlayerData = ReplicatedStorage["Player_Data"][LocalPlayer.Name]
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ToServer = Remotes:WaitForChild("To_Server")
local HandleFireServer = ToServer:WaitForChild("Handle_Initiate_S")
local HandleInvokeServer = ToServer:WaitForChild("Handle_Initiate_S_")
local FireServer = Instance.new("RemoteEvent").FireServer
local InvokeServer = Instance.new("RemoteFunction").InvokeServer
-- // For Executor && Function \\ --
local spawn, wait = task.spawn, task.wait
-- // Environment \\
local Environment = getgenv()
Environment.Settings = {
    ["KillAuraMethod"] = "",
    ["FarmMethod"] = "",
    ["GourdSize"] = "",
    ["SelectedMonster"] = {},
    ["RemoveMap"] = false,
    ["AutoFarm"] = false,
    ["KillAura"] = false,
    ["AutoCollectChest"] = false,
    ["AutoEatSoul"] = false,
    ["InfBreathing"] = false,
    ["InfStamina"] = false,
    ["NoDrown"] = false,
    ["AutoBlow"] = false,
    ["TweenSpeed"] = 200,
    ["Distance"] = 10,
}
-- // Global Init || --
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
-- // Global Function || --
local function CallerRemote(Remote, ...)
    local Method = Remote.ClassName == ("RemoteEvent") and FireServer or Remote.ClassName == ("RemoteFunction") and InvokeServer
    return spawn(Method, Remote, ...)
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

local function AutoCollectDrop()
    local Chest = Workspace.Debree:FindFirstChild("Loot_Chest")

    if Chest and #Chest:WaitForChild("Drops"):GetChildren() > 0 then
        local PickItems = Chest:WaitForChild("Add_To_Inventory")

        for _, Value in ipairs(Chest:WaitForChild("Drops"):GetChildren()) do
            if not PlayerData.Inventory.Items:FindFirstChild(Value.Name) or PlayerData.Inventory.Items:FindFirstChild(Value.Name):FindFirstChild("CanHaveMoreThenOne").Value then
                CallerRemote(PickItems, Value.Name)
            end
        end
    end
end

local function AutoEatSoul()
    for _, Value in ipairs(Workspace.Debree:GetChildren()) do
        if Value.Name == "Soul" then
            local EatRemote = Value.Handle.Eatthedamnsoul
            EatRemote:FireServer()
        end
    end
end

local function IsMap()
    local Map = Workspace:FindFirstChild("Map")
    if (Map) then
        return { true, Map }
    end
    return { false, nil}
end

local function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = Http:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = Http:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        TS:TeleportToPlaceInstance(PlaceID, ID, LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    function Teleport() 
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end
-- [[ Map1 ]]
if game.PlaceId == 6152116144 then
    local Window = library:Window({FolderName = "SylveonHub", FileName = "ProjectSlayers - Map1 -" .. LocalPlayer.UserId})
    local Tabs = {
        MainTab = Window:Tab("Autofarm", "rbxassetid://6031265972"),
        LocalPlayerTab = Window:Tab("LocalPlayer", "rbxassetid://7743875962"),
        TeleportTab = Window:Tab("Teleport", "rbxassetid://7733965184"),
        StatusTab = Window:Tab("Teleport", "rbxassetid://6031225809"),
    }
    -- Table
    local AutofarmDetails = {
        Closest = nil,
        AttackMethods = {
            ["Combat"] = 'fist_combat',
            ["Sword"] = 'Sword_Combat_Slash',
            ["Scythe"] = 'Scythe_Combat_Slash',
            ["Claw"] = 'claw_Combat_Slash',
        },
        MonsterName = {"Yowai Demon", "Civilian", "Mizunoto Demon Slayer", "Sakurai Demon", "Zoku's Subordinate", "Bandit Kaden", "Bandit Zoku", "Shiron", "Zanegutsu Kuuchie", "Sabito", "Sanemi", "Yahaba", "Nezuko", "Slasher", "Susamaru", "Giyu"},
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
    -- // Function \\ --
    local function GetClosest()
        local Closest = nil
        local selectedMonsters = Settings.SelectedMonster
    
        for _, Value in pairs(Workspace.Mobs:GetDescendants()) do
            if table.find(selectedMonsters, Value.Name) and Value:IsA("Model") and Value:FindFirstChild("Humanoid") then
                local Humanoid = Value:FindFirstChild("Humanoid")
                if (Humanoid and Humanoid.Health > 0) then
                    Closest = Value
                    break
                end
            end
        end
    
        return Closest
    end

    local function AutoGourd(Size)
        if not PlayerData.Inventory.Items:FindFirstChild(Size) then
            CallerRemote(HandleFireServer, "buysomething", LocalPlayer, Size, PlayerData.Yen, PlayerData.Inventory)
            wait(1)
        else
            local Gourd = LocalPlayer.Backpack:WaitForChild(Size) or LocalPlayer.Character:WaitForChild(Size)
            CallerRemote(HandleInvokeServer, "blow_in_gourd_thing", LocalPlayer, Gourd, 1)
        end
    end

    local function GetClosestFlower()
        local Closest = { nil }
        for _, Value in pairs(Workspace.Demon_Flowers_Spawn:GetChildren()) do
            if (Value.Name == "Demon_Flower") and Value:IsA("Model") then
                Closest[1] = Value
                break
            end
        end
    
        return Closest[1]
    end
    -- // UI \\ --
    Tabs.MainTab:Section("[ Settings ]")
    Tabs.MainTab:Dropdown("KillAura Method", "Sword", {"Combat", "Sword", "Scythe", "Claw"}, function(Value)
        Settings.KillAuraMethod = Value
    end)
    Tabs.MainTab:Dropdown("Farm Method", "Below", {"Above","Below","Behind"}, function(Value)
        Settings.FarmMethod = Value
    end)
    Tabs.MainTab:Slider("Tween Speed", {min = 80, default = 200, max = 300}, function(Value)
        Settings.TweenSpeed = Value
    end)
    Tabs.MainTab:Slider("Distance", {min = 1, default = 10, max = 10}, function(Value)
        Settings.Distance = Value
    end)
    Tabs.MainTab:Label("** Recommend for farm only. **")
    Tabs.MainTab:Toggle("Remove Map (Reduce lag)", false, function(Value)
        Settings.RemoveMap = Value
    end)
    Tabs.MainTab:Section("[ Farming ]")
    Tabs.MainTab:MultiDropdown("Select Monster", "", AutofarmDetails.MonsterName, function(Value)
        Settings.SelectedMonster = Value
    end)
    Tabs.MainTab:Toggle("Auto Farm", false, function(Value)
        Settings.AutoFarm = Value
    end)
    Tabs.MainTab:Toggle("Kill Aura", false, function(Value)
        Settings.KillAura = Value
    end)
    Tabs.MainTab:Toggle("Auto Collect Chest", false, function(Value)
        Settings.AutoCollectChest = Value
    end)
    Tabs.MainTab:Toggle("Auto Eat Souls (Demon)", false, function(Value)
        Settings.AutoEatSoul = Value
    end)
    Tabs.LocalPlayerTab:Section("[ LocalPlayer ]")
    Tabs.LocalPlayerTab:Toggle("Infinite Breathing", false, function(Value)
        Settings.InfBreathing = Value
    end)
    Tabs.LocalPlayerTab:Toggle("Infinite Stamina", false, function(Value)
        Settings.InfStamina = Value
    end)
    Tabs.LocalPlayerTab:Toggle("Semi GodMode (Kamado Only)", false, function(Value)
        CallerRemote(Remotes.heal_tang123asd, Value)
    end)
    Tabs.LocalPlayerTab:Toggle("Rengoku Mode (Human Only)", false, function(Value)
        CallerRemote(Remotes.heart_ablaze_mode_remote, Value)
    end)
    Tabs.LocalPlayerTab:Toggle("No Drown", false, function(Value)
        Settings.NoDrown = Value
    end)
    Tabs.LocalPlayerTab:Toggle("No Sun Damage", false, function(Value)
        LocalPlayer.PlayerScripts["Small_Scripts"].Gameplay["Sun_Damage"].Disabled = Value
    end)
    Tabs.LocalPlayerTab:Section("[ Gourd ]")
    Tabs.LocalPlayerTab:Dropdown("Gourd Size", "", {"Small Gourd", "Medium Gourd", "Big Gourd"}, function(Value)
        Settings.GourdSize = Value
    end)
    Tabs.LocalPlayerTab:Toggle("Auto Blow", false, function(Value)
        Settings.AutoBlow = Value
    end)
    Tabs.TeleportTab:Section("[ Teleport ]")
    Tabs.TeleportTab:Dropdown("Trainers", "", {"Wind Trainer", "Thunder Trainer", "Water Trainer", "Insect Trainer"}, function(Value)
        Settings.Trainers = Value
    end)
    Tabs.TeleportTab:Dropdown("Locations", "", {"Zapiwara Mountain", "Waroru Cave", "Slasher Demon", "Ushumaru Village", "Ouwbayashi Home", "Kabiwaru Village", "Zapiwara Cave", "Dangerous Woods", "Final Selection", "Kiribating Village", "Butterfly Mansion", "Abubu Cave"}, function(Value)
        Settings.Locations = Value
    end)
    Tabs.TeleportTab:Button("Teleport to Muzan", function()
        print("Click")
    end)
    Tabs.TeleportTab:Button("Teleport to Flower", function()
        library:Noti("warn", "Wait for server hop.", 5)
    end)
    Tabs.TeleportTab:Button("Rejoin", function()
        TS:Teleport(game.PlaceId, LocalPlayer)
    end)
    Tabs.TeleportTab:Button("Server Hop", function()
        Library:Notify("Wait for server hop.")
        Hop()
    end)
    Tabs.StatusTab:Section("[ Status ]")
    Tabs.StatusTab:Label("Breathing Progress : ")
    Tabs.StatusTab:Label("Demon Progress : ")
    -- // Thread \\ --
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if (Settings.AutoFarm) then
                LocalPlayer.Character.Humanoid:ChangeState(11)
            end
        end)
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if (Settings.AutoFarm) then
                    local Method = MethodFarm(Settings.FarmMethod)
    
                    if not AutofarmDetails.Closest then
                        AutofarmDetails.Closest = GetClosest()
                        return
                    end
                    
                    repeat wait()
                        Tween(AutofarmDetails.Closest:GetModelCFrame() * Method)
                    until not Settings.AutoFarm or not AutofarmDetails.Closest.Parent or not AutofarmDetails.Closest.Humanoid.Health <= 0
                    AutofarmDetails.Closest = nil
                end
            end)
        end
    end)
    spawn(function()
        while wait() do
            if (Settings.KillAura) then
                pcall(Attack, AutofarmDetails.AttackMethods[Settings.KillAuraMethod])
                wait(2.5)
            end
        end
    end)
end
