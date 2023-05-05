repeat task.wait() until game:IsLoaded()
if game:GetService("CoreGui"):FindFirstChild("SylveonLib") then
    game:GetService("CoreGui"):FindFirstChild("SylveonLib"):Destroy()
end
if not LPH_OBFUSCATED then
    LPH_JIT_MAX = function(...) return(...) end;
    LPH_NO_VIRTUALIZE = function(...) return(...) end;
end
if game.PlaceId ~= 6152116144 then return end
-- // Setting Library \\ --
-- // Services \\ --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Http = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local library = {flags = {}}

local SylveonLib = Instance.new("ScreenGui")
SylveonLib.Name = "SylveonLib"
SylveonLib.Parent = game:GetService("CoreGui")
SylveonLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function tweenObject(object, data, time)
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
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

function library:Window(name)
    GetFolder("SylveonHub", LocalPlayer.UserId)

    local MainFrame = Instance.new("Frame")
    local MainFrameCorner = Instance.new("UICorner")
    local TopFrame = Instance.new("Frame")
    local TitleTop = Instance.new("TextLabel")
    local TabHolder = Instance.new("ScrollingFrame")
    local TabHolderCorner = Instance.new("UICorner")
    local TabHolderListLayout = Instance.new("UIListLayout")
    local TabHolderPadding = Instance.new("UIPadding")
    local PageHolder = Instance.new("Frame")
    local PageHolderCorner = Instance.new("UICorner")
    local PageContainer = Instance.new("Frame")
    local ContainerFolder = Instance.new("Folder")
    local UIPageLayout = Instance.new("UIPageLayout")
    local RemoveCorner = Instance.new("Frame")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = SylveonLib
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(28, 24, 31)
    MainFrame.Position = UDim2.new(0.467886478, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 620, 0, 470)
    MainFrame.ClipsDescendants = true

    MainFrameCorner.CornerRadius = UDim.new(0, 5)
    MainFrameCorner.Name = "MainFrameCorner"
    MainFrameCorner.Parent = MainFrame

    TopFrame.Name = "TopFrame"
    TopFrame.Parent = MainFrame
    TopFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopFrame.BackgroundTransparency = 1.000
    TopFrame.BorderSizePixel = 0
    TopFrame.Size = UDim2.new(0, 620, 0, 25)

    TitleTop.Name = "TitleTop"
    TitleTop.Parent = TopFrame
    TitleTop.AnchorPoint = Vector2.new(0.5, 0.5)
    TitleTop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleTop.BackgroundTransparency = 1.000
    TitleTop.BorderSizePixel = 0
    TitleTop.Position = UDim2.new(0.0149999997, 0, 0.5, 0)
    TitleTop.Font = Enum.Font.GothamBold
    TitleTop.Text = "SylveonHub - [" .. tostring(identifyexecutor()) .."] | " .. tostring(name)
    TitleTop.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleTop.TextSize = 14.000
    TitleTop.TextXAlignment = Enum.TextXAlignment.Left

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.Active = true
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.Position = UDim2.new(0, 0, 0.0531914905, 0)
    TabHolder.Size = UDim2.new(0, 212, 0, 445)
    TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHolder.ScrollBarThickness = 0

    TabHolderCorner.CornerRadius = UDim.new(0, 5)
    TabHolderCorner.Name = "TabHolderCorner"
    TabHolderCorner.Parent = TabHolder

    TabHolderListLayout.Name = "TabHolderListLayout"
    TabHolderListLayout.Parent = TabHolder
    TabHolderListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    TabHolderPadding.Name = "TabHolderPadding"
    TabHolderPadding.Parent = TabHolder
    TabHolderPadding.PaddingTop = UDim.new(0, 10)

    PageHolder.Name = "PageHolder"
    PageHolder.Parent = MainFrame
    PageHolder.BackgroundColor3 = Color3.fromRGB(42, 36, 45)
    PageHolder.ClipsDescendants = true
    PageHolder.Position = UDim2.new(0.341935486, 0, 0.0530000068, 0)
    PageHolder.Size = UDim2.new(0, 407, 0, 445)

    PageHolderCorner.CornerRadius = UDim.new(0, 5)
    PageHolderCorner.Name = "PageHolderCorner"
    PageHolderCorner.Parent = PageHolder

    PageContainer.Name = "PageContainer"
    PageContainer.Parent = PageHolder
    PageContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PageContainer.BackgroundTransparency = 1.000
    PageContainer.BorderSizePixel = 0
    PageContainer.Position = UDim2.new(-0.0016217056, 0, 0, 0)
    PageContainer.Size = UDim2.new(0, 407, 0, 433)
    PageContainer.ZIndex = 2

    ContainerFolder.Name = "ContainerFolder"
    ContainerFolder.Parent = PageContainer

    UIPageLayout.Parent = ContainerFolder
    UIPageLayout.FillDirection = Enum.FillDirection.Vertical
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.Circular = true
    UIPageLayout.EasingDirection = Enum.EasingDirection.Out
    UIPageLayout.EasingStyle = Enum.EasingStyle.Circular
    UIPageLayout.GamepadInputEnabled = false
    UIPageLayout.Padding = UDim.new(0, 15)
    UIPageLayout.TweenTime = 0.500

    RemoveCorner.Name = "RemoveCorner"
    RemoveCorner.Parent = PageHolder
    RemoveCorner.BackgroundColor3 = Color3.fromRGB(42, 36, 45)
    RemoveCorner.BorderSizePixel = 0
    RemoveCorner.Size = UDim2.new(0, 6, 0, 445)
    MakeDraggable(TopFrame, MainFrame)

    local opened = true
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            opened = not opened
            if opened then
                TweenService:Create(
                    MainFrame,
                    TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
                    {Size = UDim2.new(0, 620, 0, 470)}
                ):Play()
            else
                TweenService:Create(
                    MainFrame,
                    TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
                    {Size = UDim2.new(0, 0, 0, 0)}
                ):Play()
            end
        end
    end)

    local window = {}
    local activeTab = false
    function window:Tab(name, des, icon, off, size)
        if off == nil then
            off = Vector2.new(0, 0)
        end
        if size == nil then
            size = Vector2.new(0, 0)
        end

        local TabBtn = Instance.new("TextButton")
        local SelectedTab = Instance.new("Frame")
        local SelectedCorner = Instance.new("UICorner")
        local LogoTab = Instance.new("ImageLabel")
        local TitleTab = Instance.new("TextLabel")
        local DesTab = Instance.new("TextLabel")
        local MainPage = Instance.new("Frame")
        local PageFrame = Instance.new("ScrollingFrame")
        local PageFrameListLayout = Instance.new("UIListLayout")
        local PageFramePadding = Instance.new("UIPadding")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHolder
        TabBtn.BackgroundColor3 = Color3.fromRGB(42, 36, 45)
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 212, 0, 50)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        TabBtn.BackgroundTransparency = 1.000

        SelectedTab.Name = "SelectedTab"
        SelectedTab.Parent = TabBtn
        SelectedTab.BackgroundColor3 = Color3.fromRGB(149, 125, 173)
        SelectedTab.Size = UDim2.new(0, 5, 0, 50)
        SelectedTab.BackgroundTransparency = 1

        SelectedCorner.CornerRadius = UDim.new(0, 5)
        SelectedCorner.Name = "SelectedCorner"
        SelectedCorner.Parent = SelectedTab

        LogoTab.Name = "LogoTab"
        LogoTab.Parent = TabBtn
        LogoTab.AnchorPoint = Vector2.new(0.5, 0.5)
        LogoTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LogoTab.BackgroundTransparency = 1.000
        LogoTab.Position = UDim2.new(0.150000006, 0, 0.5, 0)
        LogoTab.Size = UDim2.new(0, 29, 0, 29)
        LogoTab.Image = tostring(icon)
        LogoTab.ImageColor3 = Color3.fromRGB(192, 132, 204)
        LogoTab.ImageTransparency = 0.5
        LogoTab.ImageRectOffset = off
        LogoTab.ImageRectSize = size

        TitleTab.Name = "TitleTab"
        TitleTab.Parent = TabBtn
        TitleTab.AnchorPoint = Vector2.new(0.5, 0.5)
        TitleTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TitleTab.BackgroundTransparency = 1.000
        TitleTab.BorderSizePixel = 0
        TitleTab.Position = UDim2.new(0.300000012, 0, 0.300000012, 0)
        TitleTab.Font = Enum.Font.GothamBold
        TitleTab.Text = tostring(name)
        TitleTab.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleTab.TextSize = 14.000
        TitleTab.TextXAlignment = Enum.TextXAlignment.Left
        TitleTab.TextTransparency = 0.5

        DesTab.Name = "DesTab"
        DesTab.Parent = TabBtn
        DesTab.AnchorPoint = Vector2.new(0.5, 0.5)
        DesTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DesTab.BackgroundTransparency = 1.000
        DesTab.BorderSizePixel = 0
        DesTab.Position = UDim2.new(0.300000012, 0, 0.699999988, 0)
        DesTab.Font = Enum.Font.GothamBold
        DesTab.Text = tostring(des)
        DesTab.TextColor3 = Color3.fromRGB(170, 170, 170)
        DesTab.TextSize = 12.000
        DesTab.TextXAlignment = Enum.TextXAlignment.Left
        DesTab.TextTransparency = 0.5

        MainPage.Name = "MainPage_".. tostring(math.random(1000,9999))
        MainPage.Parent = ContainerFolder
        MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainPage.BackgroundTransparency = 1.000
        MainPage.Size = UDim2.new(0, 407, 0, 437)

        PageFrame.Name = "PageFrame"
        PageFrame.Parent = MainPage
        PageFrame.Active = true
        PageFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        PageFrame.BackgroundTransparency = 1.000
        PageFrame.BorderSizePixel = 0
        PageFrame.Size = UDim2.new(0, 407, 0, 437)
        PageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        PageFrame.ScrollBarThickness = 4

        PageFrameListLayout.Name = "PageFrameListLayout"
        PageFrameListLayout.Parent = PageFrame
        PageFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageFrameListLayout.Padding = UDim.new(0, 5)

        PageFramePadding.Name = "PageFramePadding"
        PageFramePadding.Parent = PageFrame
        PageFramePadding.PaddingLeft = UDim.new(0, 5)
        PageFramePadding.PaddingTop = UDim.new(0, 5)

        if not activeTab then
            activeTab = true
            TabBtn.BackgroundTransparency = 0
            SelectedTab.BackgroundTransparency = 0
            LogoTab.ImageTransparency = 0
            DesTab.TextTransparency = 0
            TitleTab.TextTransparency = 0
        end

        TabBtn.MouseButton1Click:Connect(function()
            UIPageLayout:JumpTo(MainPage)
            for i, v in next, TabHolder:GetChildren() do
                if v.ClassName == "TextButton" then
                    TweenService:Create(
                        v,
                        TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        v.SelectedTab,
                        TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        v.LogoTab,
                        TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                        {ImageTransparency = 0.5}
                    ):Play()
                    TweenService:Create(
                        v.DesTab,
                        TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                        {TextTransparency = 0.5}
                    ):Play()
                    TweenService:Create(
                        v.TitleTab,
                        TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                        {TextTransparency = 0.5}
                    ):Play()

                    -- tweenObject(v, {
                    --     BackgroundTransparency = 1
                    -- }, 0.3)
                    -- tweenObject(v.SelectedTab, {
                    --     BackgroundTransparency = 1
                    -- }, 0.3)
                    -- tweenObject(v.LogoTab, {
                    --     ImageTransparency = 0.5
                    -- }, 0.3)
                    -- tweenObject(v.DesTab, {
                    --     TextTransparency = 0.5
                    -- }, 0.3)
                    -- tweenObject(v.TitleTab, {
                    --     TextTransparency = 0.5
                    -- }, 0.3)
                end
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    SelectedTab,
                    TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    LogoTab,
                    TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                    {ImageTransparency = 0}
                ):Play()
                TweenService:Create(
                    DesTab,
                    TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                    {TextTransparency = 0}
                ):Play()
                TweenService:Create(
                    TitleTab,
                    TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
                    {TextTransparency = 0}
                ):Play()
                
                -- tweenObject(TabBtn, {
                --     BackgroundTransparency = 0
                -- }, 0.3)
                -- tweenObject(SelectedTab, {
                --     BackgroundTransparency = 0
                -- }, 0.3)
                -- tweenObject(LogoTab, {
                --     ImageTransparency = 0
                -- }, 0.3)
                -- tweenObject(DesTab, {
                --     TextTransparency = 0
                -- }, 0.3)
                -- tweenObject(TitleTab, {
                --     TextTransparency = 0
                -- }, 0.3)
            end
        end)

        local ContainerContent = {}
        function ContainerContent:AddToggle(options)
            local setting = GetSetting(options.Name, "SylveonHub", LocalPlayer.UserId)
            setting = setting == "true" and true or false
            options.Default = setting or options.Default

            if not library.flags[options.Name] then
                library.flags[options.Name] = default or false
            end

            local Toggle = Instance.new("Frame")
            local ToggleBtn = Instance.new("TextButton")
            local ToggleTitle = Instance.new("TextLabel")
            local CheckBox = Instance.new("Frame")
            local CheckBoxCorner = Instance.new("UICorner")
            local CheckBoxFill = Instance.new("Frame")
            local CheckBoxFillCorner = Instance.new("UICorner")
            local CheckImage = Instance.new("ImageLabel")
            local StrokeToggle = Instance.new("UIStroke")

            Toggle.Name = "Toggle"
            Toggle.Parent = PageFrame
            Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.BackgroundTransparency = 1.000
            Toggle.Size = UDim2.new(0, 395, 0, 30)
            
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = Toggle
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBtn.BackgroundTransparency = 1.000
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.Size = UDim2.new(0, 395, 0, 30)
            ToggleBtn.Font = Enum.Font.SourceSans
            ToggleBtn.Text = ""
            ToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ToggleBtn.TextSize = 14.000
            
            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = ToggleBtn
            ToggleTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.BorderSizePixel = 0
            ToggleTitle.Position = UDim2.new(0.0199999996, 0, 0.5, 0)
            ToggleTitle.Font = Enum.Font.GothamBold
            ToggleTitle.Text = tostring(options.Name)
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextTransparency = not options.Default and 0.400 or 0
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            CheckBox.Name = "CheckBox"
            CheckBox.Parent = ToggleBtn
            CheckBox.Active = true
            CheckBox.AnchorPoint = Vector2.new(0, 0.5)
            CheckBox.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
            CheckBox.BackgroundTransparency = 1.000
            CheckBox.Position = UDim2.new(0.850000024, 0, 0.5, 0)
            CheckBox.Size = UDim2.new(0, 25, 0, 25)
            
            CheckBoxCorner.CornerRadius = UDim.new(0, 4)
            CheckBoxCorner.Name = "CheckBoxCorner"
            CheckBoxCorner.Parent = CheckBox
            
            CheckBoxFill.Name = "CheckBoxFill"
            CheckBoxFill.Parent = CheckBox
            CheckBoxFill.AnchorPoint = Vector2.new(0.5, 0.5)
            CheckBoxFill.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
            CheckBoxFill.ClipsDescendants = true
            CheckBoxFill.Position = UDim2.new(0.5, 0, 0.5, 0)
            CheckBoxFill.Size = not options.Default and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 25, 0, 25)
            
            CheckBoxFillCorner.CornerRadius = UDim.new(0, 4)
            CheckBoxFillCorner.Name = "CheckBoxFillCorner"
            CheckBoxFillCorner.Parent = CheckBoxFill
            
            CheckImage.Name = "CheckImage"
            CheckImage.Parent = CheckBoxFill
            CheckImage.AnchorPoint = Vector2.new(0.5, 0.5)
            CheckImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CheckImage.BackgroundTransparency = 1.000
            CheckImage.BorderSizePixel = 0
            CheckImage.Position = UDim2.new(0.5, 0, 0.5, 0)
            CheckImage.Size = UDim2.new(0, 21, 0, 21)
            CheckImage.Image = "rbxassetid://11287988323"

            StrokeToggle.Name = "StrokeToggle"
            StrokeToggle.Parent = CheckBox
            StrokeToggle.Color = not options.Default and Color3.fromRGB(99, 98, 100) or Color3.fromRGB(192, 132, 204)
            StrokeToggle.Thickness = 1.5

            local OldCallback = options.Callback or function() end
            options.Callback = function(Value)
                library.flags[options.Name] = Value
                AddSetting(options.Name, tostring(Value), "SylveonHub", LocalPlayer.UserId)
                return OldCallback(Value)
            end

            if options.Default and options.Callback then
                options.Callback(options.Default)
            end

            ToggleBtn.MouseButton1Click:Connect(function()
                if CheckBoxFill.Size == UDim2.new(0, 0, 0, 0) then
                    tweenObject(CheckBoxFill, {
                        Size = UDim2.new(0, 25, 0, 25)
                    }, 0.15)
                    tweenObject(StrokeToggle, {
                        Color = Color3.fromRGB(192, 132, 204)
                    }, 0.15)
                    tweenObject(ToggleTitle, {
                        TextTransparency = 0
                    }, 0.15)
                    if options.Callback then
                        options.Callback(true)
                    end
                elseif CheckBoxFill.Size == UDim2.new(0, 25, 0, 25) then
                    tweenObject(CheckBoxFill, {
                        Size = UDim2.new(0, 0, 0, 0)
                    }, 0.15)
                    tweenObject(StrokeToggle, {
                        Color = Color3.fromRGB(99, 98, 100)
                    }, 0.15)
                    tweenObject(ToggleTitle, {
                        TextTransparency = 0.4
                    }, 0.15)
                    if options.Callback then
                        options.Callback(false)
                    end
                end
            end)

            PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageFrameListLayout.AbsoluteContentSize.Y + 10)
        end
        function ContainerContent:AddButton(options)
            local Button = Instance.new("Frame")
            local ButtonBtn = Instance.new("TextButton")
            local ButtonBtnCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")

            Button.Name = "Button"
            Button.Parent = PageFrame
            Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button.BackgroundTransparency = 1.000
            Button.Size = UDim2.new(0, 395, 0, 30)

            ButtonBtn.Name = "ButtonBtn"
            ButtonBtn.Parent = Button
            ButtonBtn.AnchorPoint = Vector2.new(0.5, 0.5)
            ButtonBtn.BackgroundColor3 = Color3.fromRGB(84, 58, 89)
            ButtonBtn.BackgroundTransparency = 0.700
            ButtonBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
            ButtonBtn.Size = UDim2.new(0.649999976, 0, 0, 30)
            ButtonBtn.AutoButtonColor = false
            ButtonBtn.Font = Enum.Font.SourceSans
            ButtonBtn.Text = ""
            ButtonBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ButtonBtn.TextSize = 14.000

            ButtonBtnCorner.CornerRadius = UDim.new(0, 6)
            ButtonBtnCorner.Name = "ButtonBtnCorner"
            ButtonBtnCorner.Parent = ButtonBtn

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = ButtonBtn
            ButtonTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
            ButtonTitle.Font = Enum.Font.GothamBold
            ButtonTitle.Text = tostring(options.Name)
            ButtonTitle.TextColor3 = Color3.fromRGB(192, 132, 204)
            ButtonTitle.TextSize = 14.000

            ButtonBtn.MouseEnter:Connect(function()
                tweenObject(ButtonBtn, {
                    Size = UDim2.new(1, 0, 0, 30)
                }, 0.3)
                tweenObject(ButtonBtn, {
                    BackgroundColor3 = Color3.fromRGB(192, 132, 204)
                }, 0.3)
                tweenObject(ButtonTitle, {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }, 0.3)
            end)

            ButtonBtn.MouseLeave:Connect(function()
                tweenObject(ButtonBtn, {
                    Size = UDim2.new(0.65, 0, 0, 30)
                }, 0.3)
                tweenObject(ButtonBtn, {
                    BackgroundColor3 = Color3.fromRGB(84, 58, 89)
                }, 0.3)
                tweenObject(ButtonTitle, {
                    TextColor3 = Color3.fromRGB(192, 132, 204)
                }, 0.3)
            end)

            ButtonBtn.MouseButton1Click:Connect(function()
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
                    Button.ClipsDescendants = true
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
                if options.Callback then
                    options.Callback()
                end
            end)

            PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageFrameListLayout.AbsoluteContentSize.Y + 10)
        end
        function ContainerContent:AddDropdown(options)
            options.Default = GetSetting(options.Name, "SylveonHub", LocalPlayer.UserId) or options.Default
            if not library.flags[options.Name] then 
                library.flags[options.Name] = options.Default or ""
            end

            local DropTog = false
            local multi_table = {}
            local dropfuc = {}
            local Dropdown = Instance.new("Frame")
            local DropdownCorner = Instance.new("UICorner")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownTitle = Instance.new("TextLabel")
            local DropdownShowBtn = Instance.new("TextButton")
            local DropdownShowIcon = Instance.new("ImageLabel")
            local DropdownHolder = Instance.new("Frame")
            local DropdownHolderCorner = Instance.new("UICorner")
            local DropdownListFrame = Instance.new("ScrollingFrame")
            local DropdownListFrameListLayout = Instance.new("UIListLayout")
            local DropdownListFramePadding = Instance.new("UIPadding")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = PageFrame
            Dropdown.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
            Dropdown.BackgroundTransparency = 0.700
            Dropdown.BorderSizePixel = 0
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(0, 395, 0, 30)
            
            DropdownCorner.CornerRadius = UDim.new(0, 5)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown
            
            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.BorderSizePixel = 0
            DropdownBtn.Size = UDim2.new(0, 395, 0, 30)
            DropdownBtn.AutoButtonColor = false
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000
            
            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = DropdownBtn
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.BorderSizePixel = 0
            DropdownTitle.Position = UDim2.new(0.0199999996, 0, 0, 15)
            DropdownTitle.Font = Enum.Font.GothamBold
            DropdownTitle.Text = tostring(options.Name) .. " : "
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            DropdownShowBtn.Name = "DropdownShowBtn"
            DropdownShowBtn.Parent = DropdownBtn
            DropdownShowBtn.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownShowBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownShowBtn.BackgroundTransparency = 1.000
            DropdownShowBtn.Position = UDim2.new(0.949999988, 0, 0, 15)
            DropdownShowBtn.Size = UDim2.new(0, 40, 0, 30)
            DropdownShowBtn.AutoButtonColor = false
            DropdownShowBtn.Font = Enum.Font.SourceSans
            DropdownShowBtn.Text = ""
            DropdownShowBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownShowBtn.TextSize = 14.000
            
            DropdownShowIcon.Name = "DropdownShowIcon"
            DropdownShowIcon.Parent = DropdownShowBtn
            DropdownShowIcon.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownShowIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownShowIcon.BackgroundTransparency = 1.000
            DropdownShowIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
            DropdownShowIcon.Rotation = 180.000
            DropdownShowIcon.Size = UDim2.new(0, 30, 0, 30)
            DropdownShowIcon.Image = "rbxassetid://3926305904"
            DropdownShowIcon.ImageRectOffset = Vector2.new(44, 404)
            DropdownShowIcon.ImageRectSize = Vector2.new(36, 36)
            
            DropdownHolder.Name = "DropdownHolder"
            DropdownHolder.Parent = DropdownBtn
            DropdownHolder.AnchorPoint = Vector2.new(0.5, 0)
            DropdownHolder.BackgroundColor3 = Color3.fromRGB(65, 56, 70)
            DropdownHolder.Position = UDim2.new(0.5, 0, 1, 0)
            DropdownHolder.Size = UDim2.new(0, 380, 0, 155)
            
            DropdownHolderCorner.CornerRadius = UDim.new(0, 5)
            DropdownHolderCorner.Name = "DropdownHolderCorner"
            DropdownHolderCorner.Parent = DropdownHolder
            
            DropdownListFrame.Name = "DropdownListFrame"
            DropdownListFrame.Parent = DropdownHolder
            DropdownListFrame.Active = true
            DropdownListFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownListFrame.BackgroundTransparency = 1.000
            DropdownListFrame.BorderSizePixel = 0
            DropdownListFrame.Size = UDim2.new(0, 380, 0, 155)
            DropdownListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropdownListFrame.ScrollBarThickness = 4

            DropdownListFrameListLayout.Name = "DropdownListFrameListLayout"
            DropdownListFrameListLayout.Parent = DropdownListFrame
            DropdownListFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownListFrameListLayout.Padding = UDim.new(0, 5)
            
            DropdownListFramePadding.Name = "DropdownListFramePadding"
            DropdownListFramePadding.Parent = DropdownListFrame
            DropdownListFramePadding.PaddingLeft = UDim.new(0, 5)
            DropdownListFramePadding.PaddingTop = UDim.new(0, 5)

            DropdownShowBtn.MouseButton1Click:Connect(function()
                if not DropTog then
                    tweenObject(Dropdown, {
                        Size = UDim2.new(0, 395, 0, 193)
                    }, 0.3)
                else
                    tweenObject(Dropdown, {
                        Size = UDim2.new(0, 395, 0, 30)
                    }, 0.3)
                end
                DropTog = not DropTog
            end)

            local OldCallback = options.Callback or function() end
            options.Callback = function(Value)
                library.flags[options.Name] = Value
                if options.Multi then
                    AddSetting(options.Name, Value, "SylveonHub", LocalPlayer.UserId)
                else
                    AddSetting(options.Name, tostring(Value), "SylveonHub", LocalPlayer.UserId)
                end
                return OldCallback(Value)
            end

            if #options.Default > 0 and options.Callback then
                if options.Multi then
                    local EncodeDefault = Http:JSONEncode(options.Default)
                    local DeleteDeafault = string.gsub(tostring(EncodeDefault), '"', " ")
                    DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(DeleteDeafault)
                    for i,v in next, options.Default do
                        table.insert(multi_table, v)
                    end
                    options.Callback(multi_table)
                else
                    DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(options.Default)
                    options.Callback(options.Default)
                end
            end

            for i,v in next, options.Table do
                local DropBtn = Instance.new("TextButton")
                local DropBtnCorner = Instance.new("UICorner")
                local DropBtnTitle = Instance.new("TextLabel")
                local CheckBoxItemBtn = Instance.new("Frame")
                local CheckBoxItemBtnCorner = Instance.new("UICorner")
                local CheckBoxFillItem = Instance.new("Frame")
                local CheckBoxFillItemCorner = Instance.new("UICorner")
                local CheckBoxIcon = Instance.new("ImageLabel")
                local CheckBoxItemBtnStroke = Instance.new("UIStroke")
                local IsSelectableChoosed = Instance.new("BoolValue")

                DropBtn.Name = "DropBtn"
                DropBtn.Parent = DropdownListFrame
                DropBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropBtn.BackgroundTransparency = 1.000
                DropBtn.Size = UDim2.new(0, 370, 0, 30)
                DropBtn.AutoButtonColor = false
                DropBtn.Font = Enum.Font.SourceSans
                DropBtn.Text = ""
                DropBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropBtn.TextSize = 14.000

                DropBtnCorner.CornerRadius = UDim.new(0, 5)
                DropBtnCorner.Name = "DropBtnCorner"
                DropBtnCorner.Parent = DropBtn

                DropBtnTitle.Name = "DropBtnTitle"
                DropBtnTitle.Parent = DropBtn
                DropBtnTitle.AnchorPoint = Vector2.new(0.5, 0.5)
                DropBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropBtnTitle.BackgroundTransparency = 1.000
                DropBtnTitle.BorderSizePixel = 0
                DropBtnTitle.Position = UDim2.new(0.180000007, 0, 0.5, 0)
                DropBtnTitle.Font = Enum.Font.GothamBold
                DropBtnTitle.Text = tostring(v)
                DropBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropBtnTitle.TextSize = 14.000
                DropBtnTitle.TextTransparency = 0.400
                DropBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

                CheckBoxItemBtn.Name = "CheckBoxItemBtn"
                CheckBoxItemBtn.Parent = DropBtn
                CheckBoxItemBtn.Active = true
                CheckBoxItemBtn.AnchorPoint = Vector2.new(0.5, 0.5)
                CheckBoxItemBtn.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
                CheckBoxItemBtn.BackgroundTransparency = 1.000
                CheckBoxItemBtn.Position = UDim2.new(0.0799999982, 0, 0.5, 0)
                CheckBoxItemBtn.Size = UDim2.new(0, 23, 0, 23)

                CheckBoxItemBtnCorner.CornerRadius = UDim.new(0, 4)
                CheckBoxItemBtnCorner.Name = "CheckBoxItemBtnCorner"
                CheckBoxItemBtnCorner.Parent = CheckBoxItemBtn

                CheckBoxFillItem.Name = "CheckBoxFillItem"
                CheckBoxFillItem.Parent = CheckBoxItemBtn
                CheckBoxFillItem.AnchorPoint = Vector2.new(0.5, 0.5)
                CheckBoxFillItem.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
                CheckBoxFillItem.ClipsDescendants = true
                CheckBoxFillItem.Position = UDim2.new(0.5, 0, 0.5, 0)

                CheckBoxFillItemCorner.CornerRadius = UDim.new(0, 4)
                CheckBoxFillItemCorner.Name = "CheckBoxFillItemCorner"
                CheckBoxFillItemCorner.Parent = CheckBoxFillItem

                CheckBoxIcon.Name = "CheckBoxIcon"
                CheckBoxIcon.Parent = CheckBoxFillItem
                CheckBoxIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                CheckBoxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                CheckBoxIcon.BackgroundTransparency = 1.000
                CheckBoxIcon.BorderSizePixel = 0
                CheckBoxIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
                CheckBoxIcon.Size = UDim2.new(0, 21, 0, 21)
                CheckBoxIcon.Image = "rbxassetid://11287988323"

                CheckBoxItemBtnStroke.Name = "CheckBoxItemBtnStroke"
                CheckBoxItemBtnStroke.Parent = CheckBoxItemBtn
                CheckBoxItemBtnStroke.Color = Color3.fromRGB(99, 98, 100)
                CheckBoxItemBtnStroke.Thickness = 1.5

                IsSelectableChoosed.Parent = DropBtn
                IsSelectableChoosed.Name = "IsChoosedVal"

                if #options.Default > 0 and options.Callback then
                    if options.Multi then
                        if table.find(multi_table, v) then
                            IsSelectableChoosed.Value = true
                            tweenObject(CheckBoxFillItem, {
                                Size = UDim2.new(0, 23, 0, 23)
                            }, 0.1)
                            tweenObject(CheckBoxItemBtnStroke, {
                                Color = Color3.fromRGB(192, 132, 204)
                            }, 0.1)
                            tweenObject(DropBtnTitle, {
                                TextTransparency = 0
                            }, 0.1)
                        end
                    else
                        IsSelectableChoosed.Value = true
                        tweenObject(CheckBoxFillItem, {
                            Size = UDim2.new(0, 23, 0, 23)
                        }, 0.1)
                        tweenObject(CheckBoxItemBtnStroke, {
                            Color = Color3.fromRGB(192, 132, 204)
                        }, 0.1)
                        tweenObject(DropBtnTitle, {
                            TextTransparency = 0
                        }, 0.1)
                        for _,v in next, DropdownListFrame:GetChildren() do
                            if v.Name == "DropBtn" then
                                if v.DropBtnTitle.Text ~= options.Default then
                                    v.IsChoosedVal.Value = nil
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxFillItem, {
                                        Size = UDim2.new(0, 0, 0, 0)
                                    }, 0.1)
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxItemBtnStroke, {
                                        Color = Color3.fromRGB(99, 98, 100)
                                    }, 0.1)
                                    tweenObject(v.DropBtnTitle, {
                                        TextTransparency = 0.4
                                    }, 0.1)
                                end
                            end
                        end
                    end
                end

                DropBtn.MouseButton1Click:Connect(function()
                    if options.Multi then
                        if not table.find(multi_table, v) then
                            table.insert(multi_table, v)
                            IsSelectableChoosed.Value = true
                            tweenObject(CheckBoxFillItem, {
                                Size = UDim2.new(0, 23, 0, 23)
                            }, 0.1)
                            tweenObject(CheckBoxItemBtnStroke, {
                                Color = Color3.fromRGB(192, 132, 204)
                            }, 0.1)
                            tweenObject(DropBtnTitle, {
                                TextTransparency = 0
                            }, 0.1)
                            local table,value = multi_table,v
                            local Encode = Http:JSONEncode(multi_table)
                            local Delete = string.gsub(tostring(Encode), '"', " ")
                            DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(Delete)
                            if options.Callback then
                                options.Callback(table, value)
                            end
                        else
                            IsSelectableChoosed.Value = nil
                            tweenObject(CheckBoxFillItem, {
                                Size = UDim2.new(0, 0, 0, 0)
                            }, 0.1)
                            tweenObject(CheckBoxItemBtnStroke, {
                                Color = Color3.fromRGB(99, 98, 100)
                            }, 0.1)
                            tweenObject(DropBtnTitle, {
                                TextTransparency = 0.4
                            }, 0.1)
                            for i2,v2 in pairs(multi_table) do
                                if v2 == v then
                                    table.remove(multi_table, i2)
                                end
                            end
                            local table,value = multi_table,v
                            local Encode = Http:JSONEncode(multi_table)
                            local Delete = string.gsub(tostring(Encode), '"', " ")
                            DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(Delete)
                            if options.Callback then
                                options.Callback(table, value)
                            end
                        end
                    else
                        for _,v in next, DropdownListFrame:GetChildren() do
                            if v.Name == "DropBtn" then
                                if v.DropBtnTitle.Text ~= DropBtnTitle.Text then
                                    v.IsChoosedVal.Value = nil
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxFillItem, {
                                        Size = UDim2.new(0, 0, 0, 0)
                                    }, 0.1)
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxItemBtnStroke, {
                                        Color = Color3.fromRGB(99, 98, 100)
                                    }, 0.1)
                                    tweenObject(v.DropBtnTitle, {
                                        TextTransparency = 0.4
                                    }, 0.1)
                                end
                            end
                        end
                        IsSelectableChoosed.Value = true
                        tweenObject(CheckBoxFillItem, {
                            Size = UDim2.new(0, 23, 0, 23)
                        }, 0.1)
                        tweenObject(CheckBoxItemBtnStroke, {
                            Color = Color3.fromRGB(192, 132, 204)
                        }, 0.1)
                        tweenObject(DropBtnTitle, {
                            TextTransparency = 0
                        }, 0.1)
                        tweenObject(Dropdown, {
                            Size = UDim2.new(0, 395, 0, 30)
                        }, 0.2)
                        DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(v)
                        DropTog = not DropTog
                        if options.Callback then
                            options.Callback(v)
                        end
                    end
                end)
            end
            RunService.Stepped:Connect(function ()
                pcall(function ()
                    DropdownListFrame.CanvasSize = UDim2.new(0, 0, 0, DropdownListFrameListLayout.AbsoluteContentSize.Y + 13)
                    PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageFrameListLayout.AbsoluteContentSize.Y + 10)
                end)
            end)

            function dropfuc:Clear()
                options.Default = GetSetting(name, "SylveonHub", LocalPlayer.UserId) or options.Default

                for i, v in next, DropdownListFrame:GetChildren() do
                    if v.Name == "DropBtn" then
                        v:Destroy()
                    end
                end
            end
            function dropfuc:Add(v)
                local DropBtn = Instance.new("TextButton")
                local DropBtnCorner = Instance.new("UICorner")
                local DropBtnTitle = Instance.new("TextLabel")
                local CheckBoxItemBtn = Instance.new("Frame")
                local CheckBoxItemBtnCorner = Instance.new("UICorner")
                local CheckBoxFillItem = Instance.new("Frame")
                local CheckBoxFillItemCorner = Instance.new("UICorner")
                local CheckBoxIcon = Instance.new("ImageLabel")
                local CheckBoxItemBtnStroke = Instance.new("UIStroke")
                local IsSelectableChoosed = Instance.new("BoolValue")

                DropBtn.Name = "DropBtn"
                DropBtn.Parent = DropdownListFrame
                DropBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropBtn.BackgroundTransparency = 1.000
                DropBtn.Size = UDim2.new(0, 370, 0, 30)
                DropBtn.AutoButtonColor = false
                DropBtn.Font = Enum.Font.SourceSans
                DropBtn.Text = ""
                DropBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropBtn.TextSize = 14.000

                DropBtnCorner.CornerRadius = UDim.new(0, 5)
                DropBtnCorner.Name = "DropBtnCorner"
                DropBtnCorner.Parent = DropBtn

                DropBtnTitle.Name = "DropBtnTitle"
                DropBtnTitle.Parent = DropBtn
                DropBtnTitle.AnchorPoint = Vector2.new(0.5, 0.5)
                DropBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropBtnTitle.BackgroundTransparency = 1.000
                DropBtnTitle.BorderSizePixel = 0
                DropBtnTitle.Position = UDim2.new(0.180000007, 0, 0.5, 0)
                DropBtnTitle.Font = Enum.Font.GothamBold
                DropBtnTitle.Text = tostring(v)
                DropBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropBtnTitle.TextSize = 14.000
                DropBtnTitle.TextTransparency = 0.400
                DropBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

                CheckBoxItemBtn.Name = "CheckBoxItemBtn"
                CheckBoxItemBtn.Parent = DropBtn
                CheckBoxItemBtn.Active = true
                CheckBoxItemBtn.AnchorPoint = Vector2.new(0.5, 0.5)
                CheckBoxItemBtn.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
                CheckBoxItemBtn.BackgroundTransparency = 1.000
                CheckBoxItemBtn.Position = UDim2.new(0.0799999982, 0, 0.5, 0)
                CheckBoxItemBtn.Size = UDim2.new(0, 23, 0, 23)

                CheckBoxItemBtnCorner.CornerRadius = UDim.new(0, 4)
                CheckBoxItemBtnCorner.Name = "CheckBoxItemBtnCorner"
                CheckBoxItemBtnCorner.Parent = CheckBoxItemBtn

                CheckBoxFillItem.Name = "CheckBoxFillItem"
                CheckBoxFillItem.Parent = CheckBoxItemBtn
                CheckBoxFillItem.AnchorPoint = Vector2.new(0.5, 0.5)
                CheckBoxFillItem.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
                CheckBoxFillItem.ClipsDescendants = true
                CheckBoxFillItem.Position = UDim2.new(0.5, 0, 0.5, 0)

                CheckBoxFillItemCorner.CornerRadius = UDim.new(0, 4)
                CheckBoxFillItemCorner.Name = "CheckBoxFillItemCorner"
                CheckBoxFillItemCorner.Parent = CheckBoxFillItem

                CheckBoxIcon.Name = "CheckBoxIcon"
                CheckBoxIcon.Parent = CheckBoxFillItem
                CheckBoxIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                CheckBoxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                CheckBoxIcon.BackgroundTransparency = 1.000
                CheckBoxIcon.BorderSizePixel = 0
                CheckBoxIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
                CheckBoxIcon.Size = UDim2.new(0, 21, 0, 21)
                CheckBoxIcon.Image = "rbxassetid://11287988323"

                CheckBoxItemBtnStroke.Name = "CheckBoxItemBtnStroke"
                CheckBoxItemBtnStroke.Parent = CheckBoxItemBtn
                CheckBoxItemBtnStroke.Color = Color3.fromRGB(99, 98, 100)
                CheckBoxItemBtnStroke.Thickness = 1.5

                IsSelectableChoosed.Parent = DropBtn
                IsSelectableChoosed.Name = "IsChoosedVal"

                if #options.Default > 0 and options.Callback then
                    if options.Multi then
                        if table.find(multi_table, v) then
                            IsSelectableChoosed.Value = true
                            tweenObject(CheckBoxFillItem, {
                                Size = UDim2.new(0, 23, 0, 23)
                            }, 0.1)
                            tweenObject(CheckBoxItemBtnStroke, {
                                Color = Color3.fromRGB(192, 132, 204)
                            }, 0.1)
                            tweenObject(DropBtnTitle, {
                                TextTransparency = 0
                            }, 0.1)
                        end
                    else
                        IsSelectableChoosed.Value = true
                        tweenObject(CheckBoxFillItem, {
                            Size = UDim2.new(0, 23, 0, 23)
                        }, 0.1)
                        tweenObject(CheckBoxItemBtnStroke, {
                            Color = Color3.fromRGB(192, 132, 204)
                        }, 0.1)
                        tweenObject(DropBtnTitle, {
                            TextTransparency = 0
                        }, 0.1)
                        for _,v in next, DropdownListFrame:GetChildren() do
                            if v.Name == "DropBtn" then
                                if v.DropBtnTitle.Text ~= options.Default then
                                    v.IsChoosedVal.Value = nil
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxFillItem, {
                                        Size = UDim2.new(0, 0, 0, 0)
                                    }, 0.1)
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxItemBtnStroke, {
                                        Color = Color3.fromRGB(99, 98, 100)
                                    }, 0.1)
                                    tweenObject(v.DropBtnTitle, {
                                        TextTransparency = 0.4
                                    }, 0.1)
                                end
                            end
                        end
                    end
                end

                DropBtn.MouseButton1Click:Connect(function()
                    if options.Multi then
                        if not table.find(multi_table, v) then
                            table.insert(multi_table, v)
                            IsSelectableChoosed.Value = true
                            tweenObject(CheckBoxFillItem, {
                                Size = UDim2.new(0, 23, 0, 23)
                            }, 0.1)
                            tweenObject(CheckBoxItemBtnStroke, {
                                Color = Color3.fromRGB(192, 132, 204)
                            }, 0.1)
                            tweenObject(DropBtnTitle, {
                                TextTransparency = 0
                            }, 0.1)
                            local table,value = multi_table,v
                            local Encode = Http:JSONEncode(multi_table)
                            local Delete = string.gsub(tostring(Encode), '"', " ")
                            DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(Delete)
                            if options.Callback then
                                options.Callback(table, value)
                            end
                        else
                            IsSelectableChoosed.Value = nil
                            tweenObject(CheckBoxFillItem, {
                                Size = UDim2.new(0, 0, 0, 0)
                            }, 0.1)
                            tweenObject(CheckBoxItemBtnStroke, {
                                Color = Color3.fromRGB(99, 98, 100)
                            }, 0.1)
                            tweenObject(DropBtnTitle, {
                                TextTransparency = 0.4
                            }, 0.1)
                            for i2,v2 in pairs(multi_table) do
                                if v2 == v then
                                    table.remove(multi_table, i2)
                                end
                            end
                            local table,value = multi_table,v
                            local Encode = Http:JSONEncode(multi_table)
                            local Delete = string.gsub(tostring(Encode), '"', " ")
                            DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(Delete)
                            if options.Callback then
                                options.Callback(table, value)
                            end
                        end
                    else
                        for _,v in next, DropdownListFrame:GetChildren() do
                            if v.Name == "DropBtn" then
                                if v.DropBtnTitle.Text ~= DropBtnTitle.Text then
                                    v.IsChoosedVal.Value = nil
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxFillItem, {
                                        Size = UDim2.new(0, 0, 0, 0)
                                    }, 0.1)
                                    tweenObject(v.CheckBoxItemBtn.CheckBoxItemBtnStroke, {
                                        Color = Color3.fromRGB(99, 98, 100)
                                    }, 0.1)
                                    tweenObject(v.DropBtnTitle, {
                                        TextTransparency = 0.4
                                    }, 0.1)
                                end
                            end
                        end
                        IsSelectableChoosed.Value = true
                        tweenObject(CheckBoxFillItem, {
                            Size = UDim2.new(0, 23, 0, 23)
                        }, 0.1)
                        tweenObject(CheckBoxItemBtnStroke, {
                            Color = Color3.fromRGB(192, 132, 204)
                        }, 0.1)
                        tweenObject(DropBtnTitle, {
                            TextTransparency = 0
                        }, 0.1)
                        tweenObject(Dropdown, {
                            Size = UDim2.new(0, 395, 0, 30)
                        }, 0.2)
                        DropdownTitle.Text = tostring(options.Name) .. " : " .. tostring(v)
                        DropTog = not DropTog
                        if options.Callback then
                            options.Callback(v)
                        end
                    end
                end)
            end
            return dropfuc
        end
        function ContainerContent:AddSection(options)
            local Section = Instance.new("Frame")
            local BorderSection = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")

            Section.Name = "Section"
            Section.Parent = PageFrame
            Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Section.BackgroundTransparency = 1.000
            Section.Size = UDim2.new(0, 395, 0, 30)

            BorderSection.Name = "BorderSection"
            BorderSection.Parent = Section
            BorderSection.AnchorPoint = Vector2.new(0.5, 0.5)
            BorderSection.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
            BorderSection.BorderSizePixel = 0
            BorderSection.Position = UDim2.new(0.5, 0, 0, 0)
            BorderSection.Size = UDim2.new(0, 395, 0, 2)

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.BorderSizePixel = 0
            SectionTitle.Position = UDim2.new(0.0199999996, 0, 0.5, 0)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = "# "..tostring(options.Title)
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 16.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        end
        function ContainerContent:AddInput(options)
            if options.Save then
                options.Default = GetSetting(options.Name, "SylveonHub", LocalPlayer.UserId) or options.Default 
                if not library.flags[options.Name] then 
                    library.flags[options.Name] = options.Default or ""
                end
            end
            local InputBox = Instance.new("Frame")
            local InputBoxTitle = Instance.new("TextLabel")
            local ContentFrame = Instance.new("Frame")
            local ContentFrameCorner = Instance.new("UICorner")
            local OutContentFrame = Instance.new("Frame")
            local OutContentFrameCorner = Instance.new("UICorner")
            local ContentBox = Instance.new("TextBox")

            InputBox.Name = "InputBox"
            InputBox.Parent = PageFrame
            InputBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            InputBox.BackgroundTransparency = 1.000
            InputBox.BorderSizePixel = 0
            InputBox.Size = UDim2.new(0, 395, 0, 30)

            InputBoxTitle.Name = "InputBoxTitle"
            InputBoxTitle.Parent = InputBox
            InputBoxTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            InputBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            InputBoxTitle.BackgroundTransparency = 1.000
            InputBoxTitle.BorderSizePixel = 0
            InputBoxTitle.Position = UDim2.new(0.0199999996, 0, 0.5, 0)
            InputBoxTitle.Font = Enum.Font.GothamBold
            InputBoxTitle.Text = options.Name
            InputBoxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            InputBoxTitle.TextSize = 14.000
            InputBoxTitle.TextXAlignment = Enum.TextXAlignment.Left

            ContentFrame.Name = "ContentFrame"
            ContentFrame.Parent = InputBox
            ContentFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            ContentFrame.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
            ContentFrame.BackgroundTransparency = 0.700
            ContentFrame.BorderSizePixel = 0
            ContentFrame.Position = UDim2.new(0.75, 0, 0.5, 0)
            ContentFrame.Size = UDim2.new(0, 200, 0, 25)

            ContentFrameCorner.CornerRadius = UDim.new(0, 6)
            ContentFrameCorner.Name = "ContentFrameCorner"
            ContentFrameCorner.Parent = ContentFrame

            OutContentFrame.Name = "OutContentFrame"
            OutContentFrame.Parent = ContentFrame
            OutContentFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            OutContentFrame.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
            OutContentFrame.BackgroundTransparency = 1.000
            OutContentFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            OutContentFrame.Size = UDim2.new(0, 198, 0, 23)

            OutContentFrameCorner.CornerRadius = UDim.new(0, 6)
            OutContentFrameCorner.Name = "OutContentFrameCorner"
            OutContentFrameCorner.Parent = OutContentFrame

            ContentBox.Name = "ContentBox"
            ContentBox.Parent = OutContentFrame
            ContentBox.AnchorPoint = Vector2.new(0.5, 0.5)
            ContentBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ContentBox.BackgroundTransparency = 1.000
            ContentBox.BorderSizePixel = 0
            ContentBox.Position = UDim2.new(0.513, 0, 0.5, 0)
            ContentBox.Size = UDim2.new(0, 195, 0, 23)
            ContentBox.Font = Enum.Font.GothamBold
            ContentBox.PlaceholderColor3 = Color3.fromRGB(155, 155, 155)
            ContentBox.PlaceholderText = options.Des
            ContentBox.Text = options.Default
            ContentBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            ContentBox.TextSize = 13.000
            ContentBox.TextWrapped = true
            ContentBox.TextXAlignment = Enum.TextXAlignment.Left

            if options.Save then
                local OldCallback = options.Callback or function() end
                options.Callback = function(Value)
                    library.flags[options.Name] = Value
                    AddSetting(options.Name, tostring(Value), "SylveonHub", LocalPlayer.UserId)
                    return OldCallback(Value)
                end
            end

            ContentBox.FocusLost:Connect(function()
                if #ContentBox.Text > 0 then
                    pcall(options.Callback, ContentBox.Text)
                end
            end)

            if options.Default and options.Callback and options.Save then
                options.Callback(options.Default)
            end

            PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageFrameListLayout.AbsoluteContentSize.Y + 10)
        end
        function ContainerContent:AddSlider(options)
            local dragging = false
            local Slider = Instance.new("Frame")
            local SliderTitle = Instance.new("TextLabel")
            local SliderFrame = Instance.new("Frame")
            local SliderFrameCorner = Instance.new("UICorner")
            local CurrentFrame = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Zip = Instance.new("Frame")
            local ZipCorner = Instance.new("UICorner")
            local ValueBubble = Instance.new("Frame")
            local ValueBubbleCorner = Instance.new("UICorner")
            local SquareBubble = Instance.new("Frame")
            local GlowBubble = Instance.new("ImageLabel")
            local ValueLabel = Instance.new("TextLabel")

            Slider.Name = "Slider"
            Slider.Parent = PageFrame
            Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider.BackgroundTransparency = 1.000
            Slider.BorderSizePixel = 0
            Slider.Size = UDim2.new(0, 395, 0, 35)

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.BorderSizePixel = 0
            SliderTitle.Position = UDim2.new(0.0199999996, 0, 0.300000012, 0)
            SliderTitle.Font = Enum.Font.GothamBold
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            SliderTitle.Text = tostring(options.Name)

            SliderFrame.Name = "SliderFrame"
            SliderFrame.Parent = Slider
            SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(84, 58, 89)
            SliderFrame.BackgroundTransparency = 0.700
            SliderFrame.Position = UDim2.new(0.5, 0, 0.800000012, 0)
            SliderFrame.Size = UDim2.new(0, 370, 0, 8)

            SliderFrameCorner.Name = "SliderFrameCorner"
            SliderFrameCorner.Parent = SliderFrame

            CurrentFrame.Name = "CurrentFrame"
            CurrentFrame.Parent = SliderFrame
            CurrentFrame.BackgroundColor3 = Color3.fromRGB(192, 132, 204)
            CurrentFrame.BackgroundTransparency = 0.700
            CurrentFrame.Size = UDim2.new((options.Start or 0) / options.Max, 0, 0, 8)

            UICorner.Parent = CurrentFrame

            Zip.Name = "Zip"
            Zip.Parent = SliderFrame
            Zip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Zip.BorderSizePixel = 0
            Zip.Position = UDim2.new((options.Start or 0)/options.Max, -6, -0.644999981, 0)
            Zip.Size = UDim2.new(0, 10, 0, 18)

            ZipCorner.CornerRadius = UDim.new(0, 3)
            ZipCorner.Name = "ZipCorner"
            ZipCorner.Parent = Zip

            ValueBubble.Name = "ValueBubble"
            ValueBubble.Parent = Zip
            ValueBubble.AnchorPoint = Vector2.new(0.5, 0.5)
            ValueBubble.BackgroundColor3 = Color3.fromRGB(153, 105, 163)
            ValueBubble.Position = UDim2.new(0.5, 0, -1.00800002, 0)
            ValueBubble.Size = UDim2.new(0, 36, 0, 21)
            ValueBubble.Visible = false

            Zip.MouseEnter:Connect(function()
                if dragging == false then
                    ValueBubble.Visible = true
                end
            end)
            
            Zip.MouseLeave:Connect(function()
                if dragging == false then
                    ValueBubble.Visible = false
                end
            end)

            ValueBubbleCorner.CornerRadius = UDim.new(0, 3)
            ValueBubbleCorner.Name = "ValueBubbleCorner"
            ValueBubbleCorner.Parent = ValueBubble

            SquareBubble.Name = "SquareBubble"
            SquareBubble.Parent = ValueBubble
            SquareBubble.AnchorPoint = Vector2.new(0.5, 0.5)
            SquareBubble.BackgroundColor3 = Color3.fromRGB(153, 105, 163)
            SquareBubble.BorderSizePixel = 0
            SquareBubble.Position = UDim2.new(0.493000001, 0, 0.637999952, 0)
            SquareBubble.Rotation = 45.000
            SquareBubble.Size = UDim2.new(0, 19, 0, 19)

            GlowBubble.Name = "GlowBubble"
            GlowBubble.Parent = ValueBubble
            GlowBubble.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            GlowBubble.BackgroundTransparency = 1.000
            GlowBubble.BorderSizePixel = 0
            GlowBubble.Position = UDim2.new(0, -15, 0, -15)
            GlowBubble.Size = UDim2.new(1, 30, 1, 30)
            GlowBubble.Image = "rbxassetid://4996891970"
            GlowBubble.ImageColor3 = Color3.fromRGB(153, 105, 163)
            GlowBubble.ImageTransparency = 0.700
            GlowBubble.ScaleType = Enum.ScaleType.Slice
            GlowBubble.SliceCenter = Rect.new(20, 20, 280, 280)

            ValueLabel.Name = "ValueLabel"
            ValueLabel.Parent = ValueBubble
            ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.BackgroundTransparency = 1.000
            ValueLabel.BorderSizePixel = 0
            ValueLabel.Size = UDim2.new(0, 36, 0, 21)
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.Text = tostring(options.Start and math.floor((options.Start / options.Max) * (options.Max - options.Min) + options.Min) or 0)
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 10.000

            local function move(input)
                local pos =
                    UDim2.new(
                        math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1),
                        -6,
                        -0.644999981,
                        0
                    )
                local pos1 =
                    UDim2.new(
                        math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1),
                        0,
                        0,
                        8
                    )
                CurrentFrame.Size = pos1
                Zip.Position = pos
                local value = math.floor(((pos.X.Scale * options.Max) / options.Max) * (options.Max - options.Min) + options.Min)
                ValueLabel.Text = tostring(value)
                pcall(options.Callback, value)
            end
            Zip.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    ValueBubble.Visible = true
                end
            end)
            Zip.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
					ValueBubble.Visible = false
				end
			end)
            game:GetService("UserInputService").InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					move(input)
				end
			end)
        end
        return ContainerContent
    end
    return window
end

local window = library:Window("[👊UPD 10] Anime Adventures")
local Tabs = {
    Main = window:Tab("AutoFarm", "Settings, AutoFarm", "rbxassetid://3926305904", Vector2.new(364, 484), Vector2.new(36, 36)),
    Test = window:Tab("Misc", "LocalPlayer, Gourd", "rbxassetid://3926305904", Vector2.new(364, 444), Vector2.new(36, 36)),
    Test2 = window:Tab("Aisdfdsfmbot2", "FOV, Smoothasd", "rbxassetid://6035039430")
}
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
local PlayerData = ReplicatedStorage["Player_Data"][LocalPlayer.Name]
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ToServer = Remotes:WaitForChild("To_Server")
local HandleFireServer = ToServer:WaitForChild("Handle_Initiate_S")
local HandleInvokeServer = ToServer:WaitForChild("Handle_Initiate_S_")
local FireServer = Instance.new("RemoteEvent").FireServer
local InvokeServer = Instance.new("RemoteFunction").InvokeServer
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
        task.wait(5)
        return true
    end
end
-- // Function \\ --
local function CallerRemote(Remote, ...)
    local Method = Remote.ClassName == ("RemoteEvent") and FireServer or Remote.ClassName == ("RemoteFunction") and InvokeServer
    return task.spawn(Method, Remote, ...)
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

local function IsMap()
    local Map = Workspace:FindFirstChild("Map")
    if (Map) then
        return { true, Map }
    end
    return { false, nil}
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
    local DamageAmounts = {math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919, math.huge, 919, math.huge}
    
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
    Start = 6,
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
task.spawn(function()
    while task.wait() do
        pcall(function()
            if (Settings.AutoFarm) then
                local Method = MethodFarm(Settings.FarmMethod)

                if not AutofarmDetails.Closest then
                    AutofarmDetails.Closest = GetClosest()
                end
                
                repeat task.wait()
                    Tween(AutofarmDetails.Closest:GetModelCFrame() * Method)
                until not Settings.AutoFarm or not AutofarmDetails.Closest.Parent --or not AutofarmDetails.Closest.Humanoid.Health <= 0
                AutofarmDetails.Closest = nil
            end
        end)
    end
end)
task.spawn(function()
    while task.wait() do
        if (Settings.KillAura) then
            pcall(Attack, AutofarmDetails.AttackMethods[Settings.KillAuraMethod])
            task.wait(2)
        end
    end
end)
