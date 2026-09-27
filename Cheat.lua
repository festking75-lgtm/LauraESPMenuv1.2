local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("FakeCheatGui") then
	CoreGui.FakeCheatGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FakeCheatGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Tema Renkleri
local Themes = {
	Dark = {
		Main = Color3.fromRGB(22, 22, 28),
		Sidebar = Color3.fromRGB(17, 17, 22),
		Accent = Color3.fromRGB(0, 180, 255),
		ButtonBg = Color3.fromRGB(30, 30, 40),
		Text = Color3.fromRGB(220, 220, 220)
	},
	Cyber = {
		Main = Color3.fromRGB(15, 12, 25),
		Sidebar = Color3.fromRGB(10, 8, 18),
		Accent = Color3.fromRGB(255, 0, 128),
		ButtonBg = Color3.fromRGB(35, 20, 50),
		Text = Color3.fromRGB(255, 150, 220)
	},
	Rose = {
		Main = Color3.fromRGB(28, 22, 25),
		Sidebar = Color3.fromRGB(20, 15, 18),
		Accent = Color3.fromRGB(255, 90, 120),
		ButtonBg = Color3.fromRGB(45, 30, 35),
		Text = Color3.fromRGB(255, 200, 210)
	}
}
local currentTheme = Themes.Dark

local themedButtons = {}
local themedTexts = {}
local themedAccents = {}
local themedFills = {}

-- Ana Menü
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 440)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -220)
MainFrame.BackgroundColor3 = currentTheme.Main
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Sabit Şeffaf Arka Plan Resmi Katmanı
local BgImageLabel = Instance.new("ImageLabel")
BgImageLabel.Name = "CustomBackgroundImage"
BgImageLabel.Size = UDim2.new(1, 0, 1, 0)
BgImageLabel.BackgroundTransparency = 1
BgImageLabel.Image = "rbxassetid://18917891781"
BgImageLabel.ImageTransparency = 0.5
BgImageLabel.ScaleType = Enum.ScaleType.Slice
BgImageLabel.ZIndex = 0
BgImageLabel.Parent = MainFrame

-- Sol Sekme Paneli (Sidebar)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = currentTheme.Sidebar
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 1
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

-- Başlık
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 140, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ReaperMenu"
TitleLabel.TextColor3 = currentTheme.Accent
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.ZIndex = 2
TitleLabel.Parent = Sidebar
table.insert(themedAccents, {Obj = TitleLabel, Property = "TextColor3"})

-- Profil ve İsim
local ProfileImage = Instance.new("ImageLabel")
ProfileImage.Size = UDim2.new(0, 38, 0, 38)
ProfileImage.Position = UDim2.new(0, 10, 1, -48)
ProfileImage.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ProfileImage.BorderSizePixel = 0
ProfileImage.ZIndex = 2
ProfileImage.Parent = Sidebar
Instance.new("UICorner", ProfileImage).CornerRadius = UDim.new(1, 0)

pcall(function()
	local content, isLoaded = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	if isLoaded then ProfileImage.Image = content end
end)

local NameLabel = Instance.new("TextLabel")
NameLabel.Size = UDim2.new(0, 80, 0, 38)
NameLabel.Position = UDim2.new(0, 55, 1, -48)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = LocalPlayer.Name
NameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
NameLabel.TextSize = 13
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
NameLabel.ZIndex = 2
NameLabel.Parent = Sidebar

-- İçerik Alanı
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -150, 1, -20)
ContentArea.Position = UDim2.new(0, 150, 0, 10)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 1
ContentArea.Parent = MainFrame

-- Sekme Butonları
local function createTabButton(name, yPos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 120, 0, 32)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = currentTheme.ButtonBg
	btn.BackgroundTransparency = 0.2
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(180, 180, 180)
	btn.TextSize = 13
	btn.Font = Enum.Font.GothamBold
	btn.ZIndex = 2
	btn.Parent = Sidebar
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	table.insert(themedButtons, btn)
	return btn
end

local tabVisuals = createTabButton("Visuals", 60)
local tabCombat = createTabButton("Combat", 98)
local tabTeleport = createTabButton("Teleport", 136)
local tabWorld = createTabButton("World", 174)
local tabPlayer = createTabButton("Player", 212)
local tabSettings = createTabButton("Settings", 250)

local function createPanel()
	local p = Instance.new("ScrollingFrame", ContentArea)
	p.Size = UDim2.new(1, 0, 1, 0)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ScrollBarThickness = 4
	p.CanvasSize = UDim2.new(0, 0, 0, 480)
	p.ZIndex = 2
	return p
end

local visualsPanel = createPanel() visualsPanel.Visible = true
local combatPanel = createPanel()
local teleportPanel = createPanel()
local worldPanel = createPanel()
local playerPanel = createPanel()
local settingsPanel = createPanel()

local function hideAllPanels()
	visualsPanel.Visible = false
	combatPanel.Visible = false
	teleportPanel.Visible = false
	worldPanel.Visible = false
	playerPanel.Visible = false
	settingsPanel.Visible = false
	tabVisuals.TextColor3 = Color3.fromRGB(180, 180, 180)
	tabCombat.TextColor3 = Color3.fromRGB(180, 180, 180)
	tabTeleport.TextColor3 = Color3.fromRGB(180, 180, 180)
	tabWorld.TextColor3 = Color3.fromRGB(180, 180, 180)
	tabPlayer.TextColor3 = Color3.fromRGB(180, 180, 180)
	tabSettings.TextColor3 = Color3.fromRGB(180, 180, 180)
end

tabVisuals.MouseButton1Click:Connect(function() hideAllPanels() visualsPanel.Visible = true tabVisuals.TextColor3 = currentTheme.Accent end)
tabCombat.MouseButton1Click:Connect(function() hideAllPanels() combatPanel.Visible = true tabCombat.TextColor3 = currentTheme.Accent end)
tabTeleport.MouseButton1Click:Connect(function() hideAllPanels() teleportPanel.Visible = true tabTeleport.TextColor3 = currentTheme.Accent end)
tabWorld.MouseButton1Click:Connect(function() hideAllPanels() worldPanel.Visible = true tabWorld.TextColor3 = currentTheme.Accent end)
tabPlayer.MouseButton1Click:Connect(function() hideAllPanels() playerPanel.Visible = true tabPlayer.TextColor3 = currentTheme.Accent end)
tabSettings.MouseButton1Click:Connect(function() hideAllPanels() settingsPanel.Visible = true tabSettings.TextColor3 = currentTheme.Accent end)

-- Toggle + Keybind Oluşturucu
local function createToggleWithKeybind(parent, name, yPosition, defaultKey, callback)
	local container = Instance.new("Frame", parent)
	container.Size = UDim2.new(1, 0, 0, 38)
	container.Position = UDim2.new(0, 0, 0, yPosition)
	container.BackgroundTransparency = 1
	container.ZIndex = 2
	
	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(0, 155, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = currentTheme.Text
	label.TextSize = 12
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 2
	table.insert(themedTexts, label)
	
	local kbBtn = Instance.new("TextButton", container)
	kbBtn.Size = UDim2.new(0, 65, 0, 24)
	kbBtn.Position = UDim2.new(1, -150, 0.5, -12)
	kbBtn.BackgroundColor3 = currentTheme.ButtonBg
	kbBtn.BackgroundTransparency = 0.2
	kbBtn.Text = defaultKey and (typeof(defaultKey) == "EnumItem" and defaultKey.Name or tostring(defaultKey)) or "None"
	kbBtn.TextColor3 = currentTheme.Accent
	kbBtn.TextSize = 10
	kbBtn.Font = Enum.Font.GothamBold
	kbBtn.ZIndex = 2
	Instance.new("UICorner", kbBtn).CornerRadius = UDim.new(0, 6)
	table.insert(themedButtons, kbBtn)
	table.insert(themedAccents, {Obj = kbBtn, Property = "TextColor3"})
	
	local clearBtn = Instance.new("TextButton", container)
	clearBtn.Size = UDim2.new(0, 24, 0, 24)
	clearBtn.Position = UDim2.new(1, -80, 0.5, -12)
	clearBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
	clearBtn.BackgroundTransparency = 0.2
	clearBtn.Text = "X"
	clearBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
	clearBtn.TextSize = 11
	clearBtn.Font = Enum.Font.GothamBold
	clearBtn.ZIndex = 2
	Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 6)
	
	local bg = Instance.new("TextButton", container)
	bg.Size = UDim2.new(0, 45, 0, 24)
	bg.Position = UDim2.new(1, -50, 0.5, -12)
	bg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	bg.BackgroundTransparency = 0.2
	bg.Text = ""
	bg.AutoButtonColor = false
	bg.ZIndex = 2
	Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
	
	local dot = Instance.new("Frame", bg)
	dot.Size = UDim2.new(0, 18, 0, 18)
	dot.Position = UDim2.new(0, 3, 0.5, -9)
	dot.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
	dot.ZIndex = 2
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
	
	local isEnabled = false
	local isBinding = false
	local assignedKey = defaultKey
	
	local function setToggle(state)
		isEnabled = state
		bg.BackgroundColor3 = isEnabled and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(60, 60, 70)
		dot:TweenPosition(isEnabled and UDim2.new(0, 24, 0.5, -9) or UDim2.new(0, 3, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
		callback(isEnabled)
	end
	
	bg.MouseButton1Click:Connect(function() setToggle(not isEnabled) end)
	kbBtn.MouseButton1Click:Connect(function() isBinding = true kbBtn.Text = "..." end)
	clearBtn.MouseButton1Click:Connect(function() assignedKey = nil kbBtn.Text = "None" isBinding = false end)
	
	UserInputService.InputBegan:Connect(function(input, gpe)
		if isBinding then
			if input.UserInputType == Enum.UserInputType.Keyboard then
				if input.KeyCode == Enum.KeyCode.Backspace then assignedKey = nil kbBtn.Text = "None" else assignedKey = input.KeyCode kbBtn.Text = input.KeyCode.Name end
				isBinding = false
			elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3 then
				assignedKey = input.UserInputType
				kbBtn.Text = input.UserInputType.Name
				isBinding = false
			end
		elseif not gpe and assignedKey then
			if input.KeyCode == assignedKey or input.UserInputType == assignedKey then setToggle(not isEnabled) end
		end
	end)
	
	return bg, dot
end

-- Slider Oluşturucu (Genel)
local function createSlider(parent, name, min, max, default, yPosition, isDecimal, callback)
	local container = Instance.new("Frame", parent)
	container.Size = UDim2.new(1, 0, 0, 48)
	container.Position = UDim2.new(0, 0, 0, yPosition)
	container.BackgroundTransparency = 1
	container.ZIndex = 2
	
	local label = Instance.new("TextLabel", container)
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = name .. ": " .. tostring(default)
	label.TextColor3 = currentTheme.Text
	label.TextSize = 12
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 2
	table.insert(themedTexts, label)
	
	local sliderBar = Instance.new("TextButton", container)
	sliderBar.Size = UDim2.new(1, 0, 0, 8)
	sliderBar.Position = UDim2.new(0, 0, 0, 26)
	sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	sliderBar.BackgroundTransparency = 0.2
	sliderBar.Text = ""
	sliderBar.ZIndex = 2
	Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(1, 0)
	
	local fill = Instance.new("Frame", sliderBar)
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
	fill.BackgroundColor3 = currentTheme.Accent
	fill.ZIndex = 2
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
	table.insert(themedFills, fill)
	
	local draggingSlider = false
	sliderBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true end end)
	UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end end)
	UserInputService.InputChanged:Connect(function(input)
		if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
			local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(pos, 0, 1, 0)
			local val
			if isDecimal then
				val = math.floor((min + (max - min) * pos) * 10) / 10
				label.Text = name .. ": " .. string.format("%.1f", val) .. "s"
			else
				val = math.floor(min + (max - min) * pos)
				label.Text = name .. ": " .. val
			end
			callback(val)
		end
	end)
end

-- Değişkenler
local espEnabled = false
local chamsEnabled = false
local tracersEnabled = false
local aimEnabled = false
local fovHidden = false
local wallCheckEnabled = false
local crazyEnabled = false
local noclipEnabled = false
local flyEnabled = false
local espEffectType = "Rainbow"

-- Özellik Toggle'ları
createToggleWithKeybind(visualsPanel, "Enemy ESP (Glow)", 10, nil, function(state) espEnabled = state end)
createToggleWithKeybind(visualsPanel, "Enemy Chams", 55, nil, function(state) chamsEnabled = state end)
createToggleWithKeybind(visualsPanel, "Enemy Tracers", 100, nil, function(state) tracersEnabled = state end)

-- Stil Seçim Butonları
local styleLabel = Instance.new("TextLabel", visualsPanel)
styleLabel.Size = UDim2.new(1, 0, 0, 25)
styleLabel.Position = UDim2.new(0, 0, 0, 145)
styleLabel.BackgroundTransparency = 1
styleLabel.Text = "ESP & Tracers Effect Style"
styleLabel.TextColor3 = currentTheme.Text
styleLabel.TextSize = 12
styleLabel.Font = Enum.Font.GothamBold
styleLabel.TextXAlignment = Enum.TextXAlignment.Left
styleLabel.ZIndex = 2
table.insert(themedTexts, styleLabel)

local styleBtn1 = Instance.new("TextButton", visualsPanel)
styleBtn1.Size = UDim2.new(0, 190, 0, 30)
styleBtn1.Position = UDim2.new(0, 0, 0, 175)
styleBtn1.BackgroundColor3 = currentTheme.ButtonBg
styleBtn1.BackgroundTransparency = 0.2
styleBtn1.Text = "Style: Rainbow [ACTIVE]"
styleBtn1.TextColor3 = currentTheme.Accent
styleBtn1.TextSize = 11
styleBtn1.Font = Enum.Font.GothamBold
styleBtn1.ZIndex = 2
Instance.new("UICorner", styleBtn1).CornerRadius = UDim.new(0, 6)
table.insert(themedButtons, styleBtn1)
table.insert(themedAccents, {Obj = styleBtn1, Property = "TextColor3"})

local styleBtn2 = Instance.new("TextButton", visualsPanel)
styleBtn2.Size = UDim2.new(0, 190, 0, 30)
styleBtn2.Position = UDim2.new(0, 200, 0, 175)
styleBtn2.BackgroundColor3 = currentTheme.ButtonBg
styleBtn2.BackgroundTransparency = 0.2
styleBtn2.Text = "Style: Galaxy (Yellow/Purple/White)"
styleBtn2.TextColor3 = currentTheme.Text
styleBtn2.TextSize = 10
styleBtn2.Font = Enum.Font.GothamBold
styleBtn2.ZIndex = 2
Instance.new("UICorner", styleBtn2).CornerRadius = UDim.new(0, 6)
table.insert(themedButtons, styleBtn2)
table.insert(themedTexts, styleBtn2)

styleBtn1.MouseButton1Click:Connect(function()
	espEffectType = "Rainbow"
	styleBtn1.Text = "Style: Rainbow [ACTIVE]"
	styleBtn2.Text = "Style: Galaxy (Yellow/Purple/White)"
	styleBtn1.TextColor3 = currentTheme.Accent
	styleBtn2.TextColor3 = currentTheme.Text
end)

styleBtn2.MouseButton1Click:Connect(function()
	espEffectType = "Galaxy"
	styleBtn2.Text = "Style: Galaxy [ACTIVE]"
	styleBtn1.Text = "Style: Rainbow"
	styleBtn2.TextColor3 = currentTheme.Accent
	styleBtn1.TextColor3 = currentTheme.Text
end)

createToggleWithKeybind(combatPanel, "Enable Aimbot", 10, nil, function(state) aimEnabled = state end)
createToggleWithKeybind(combatPanel, "Hide FOV Circle", 55, nil, function(state) fovHidden = state end)
createToggleWithKeybind(combatPanel, "Wall Check (Visible)", 100, nil, function(state) wallCheckEnabled = state end)

createToggleWithKeybind(worldPanel, "Crazy Mode (Optimized)", 10, nil, function(state) crazyEnabled = state end)

createToggleWithKeybind(playerPanel, "NoClip (Pass Walls)", 10, nil, function(state) noclipEnabled = state end)
createToggleWithKeybind(playerPanel, "Fly Mode", 55, nil, function(state) flyEnabled = state end)

-- Teleport Sekmesi İçeriği
local refreshTpBtn = Instance.new("TextButton", teleportPanel)
refreshTpBtn.Size = UDim2.new(1, 0, 0, 28)
refreshTpBtn.Position = UDim2.new(0, 0, 0, 5)
refreshTpBtn.BackgroundColor3 = currentTheme.ButtonBg
refreshTpBtn.BackgroundTransparency = 0.2
refreshTpBtn.Text = "Refresh Player List"
refreshTpBtn.TextColor3 = currentTheme.Text
refreshTpBtn.TextSize = 11
refreshTpBtn.Font = Enum.Font.GothamBold
refreshTpBtn.ZIndex = 2
Instance.new("UICorner", refreshTpBtn).CornerRadius = UDim.new(0, 6)
table.insert(themedButtons, refreshTpBtn)
table.insert(themedTexts, refreshTpBtn)

-- Takım Filtresi Seçim Butonu (All / Enemy Only)
local tpFilterMode = "All" -- "All" veya "Enemy"
local filterModeBtn = Instance.new("TextButton", teleportPanel)
filterModeBtn.Size = UDim2.new(1, 0, 0, 28)
filterModeBtn.Position = UDim2.new(0, 0, 0, 38)
filterModeBtn.BackgroundColor3 = currentTheme.ButtonBg
filterModeBtn.BackgroundTransparency = 0.2
filterModeBtn.Text = "TP Target Filter: All Players"
filterModeBtn.TextColor3 = currentTheme.Accent
filterModeBtn.TextSize = 11
filterModeBtn.Font = Enum.Font.GothamBold
filterModeBtn.ZIndex = 2
Instance.new("UICorner", filterModeBtn).CornerRadius = UDim.new(0, 6)
table.insert(themedButtons, filterModeBtn)
table.insert(themedAccents, {Obj = filterModeBtn, Property = "TextColor3"})

-- Sıra Sıra Işınlanma Toggle'ı
local sequentialTpEnabled = false
createToggleWithKeybind(teleportPanel, "Sequential TP (Auto)", 70, nil, function(state)
	sequentialTpEnabled = state
end)

-- Işınlanma Hızı Slider'ı (0.1s - 5.0s arası)
local tpDelay = 1.0
createSlider(teleportPanel, "TP Interval (Speed)", 0.1, 5.0, 1.0, 110, true, function(val)
	tpDelay = val
end)

local tpListContainer = Instance.new("ScrollingFrame", teleportPanel)
tpListContainer.Size = UDim2.new(1, 0, 0, 220)
tpListContainer.Position = UDim2.new(0, 0, 0, 165)
tpListContainer.BackgroundTransparency = 1
tpListContainer.ScrollBarThickness = 4
tpListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
tpListContainer.ZIndex = 2

local function updateTpList()
	for _, child in ipairs(tpListContainer:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	local yOffset = 0
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local isEnemy = true
			if LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then isEnemy = false end
			
			if tpFilterMode == "All" or (tpFilterMode == "Enemy" and isEnemy) then
				local pBtn = Instance.new("TextButton", tpListContainer)
				pBtn.Size = UDim2.new(1, -10, 0, 32)
				pBtn.Position = UDim2.new(0, 0, 0, yOffset)
				pBtn.BackgroundColor3 = currentTheme.ButtonBg
				pBtn.BackgroundTransparency = 0.2
				pBtn.Text = "   TP to: " .. p.Name .. (isEnemy and " [Enemy]" or " [Team]")
				pBtn.TextColor3 = isEnemy and Color3.fromRGB(255, 100, 100) or currentTheme.Text
				pBtn.TextSize = 11
				pBtn.Font = Enum.Font.GothamBold
				pBtn.TextXAlignment = Enum.TextXAlignment.Left
				pBtn.ZIndex = 2
				Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 6)
				table.insert(themedButtons, pBtn)
				
				pBtn.MouseButton1Click:Connect(function()
					if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
						LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
					end
				end)
				
				yOffset = yOffset + 38
			end
		end
	end
	tpListContainer.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

filterModeBtn.MouseButton1Click:Connect(function()
	if tpFilterMode == "All" then
		tpFilterMode = "Enemy"
		filterModeBtn.Text = "TP Target Filter: Enemy Only"
	else
		tpFilterMode = "All"
		filterModeBtn.Text = "TP Target Filter: All Players"
	end
	updateTpList()
end)

refreshTpBtn.MouseButton1Click:Connect(updateTpList)
task.spawn(updateTpList)

-- Filtreye Uyumlu Sıra Sıra Işınlanma Döngüsü
local sequentialIndex = 1
task.spawn(function()
	while true do
		task.wait(tpDelay)
		if sequentialTpEnabled then
			local validPlayers = {}
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					local isEnemy = true
					if LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then isEnemy = false end
					
					if tpFilterMode == "All" or (tpFilterMode == "Enemy" and isEnemy) then
						table.insert(validPlayers, p)
					end
				end
			end
			
			if #validPlayers > 0 then
				if sequentialIndex > #validPlayers then
					sequentialIndex = 1
				end
				
				local targetPlayer = validPlayers[sequentialIndex]
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
				end
				
				sequentialIndex = sequentialIndex + 1
			end
		end
	end
end)

-- Aimbot Tuş Ayarı
local currentAimKey = Enum.UserInputType.MouseButton2 
local bindingAimKey = false

local keybindContainer = Instance.new("Frame", combatPanel)
keybindContainer.Size = UDim2.new(1, 0, 0, 40)
keybindContainer.Position = UDim2.new(0, 0, 0, 260)
keybindContainer.BackgroundTransparency = 1
keybindContainer.ZIndex = 2

local keybindLabel = Instance.new("TextLabel", keybindContainer)
keybindLabel.Size = UDim2.new(0, 170, 1, 0)
keybindLabel.BackgroundTransparency = 1
keybindLabel.Text = "Aimbot Hold Key"
keybindLabel.TextColor3 = currentTheme.Text
keybindLabel.TextSize = 13
keybindLabel.Font = Enum.Font.GothamBold
keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
keybindLabel.ZIndex = 2
table.insert(themedTexts, keybindLabel)

local keybindButton = Instance.new("TextButton", keybindContainer)
keybindButton.Size = UDim2.new(0, 85, 0, 26)
keybindButton.Position = UDim2.new(1, -125, 0.5, -13)
keybindButton.BackgroundColor3 = currentTheme.ButtonBg
keybindButton.BackgroundTransparency = 0.2
keybindButton.Text = "MouseButton2"
keybindButton.TextColor3 = currentTheme.Accent
keybindButton.TextSize = 11
keybindButton.Font = Enum.Font.GothamBold
keybindButton.ZIndex = 2
Instance.new("UICorner", keybindButton).CornerRadius = UDim.new(0, 6)
table.insert(themedButtons, keybindButton)
table.insert(themedAccents, {Obj = keybindButton, Property = "TextColor3"})

local clearAimKeyBtn = Instance.new("TextButton", keybindContainer)
clearAimKeyBtn.Size = UDim2.new(0, 26, 0, 26)
clearAimKeyBtn.Position = UDim2.new(1, -30, 0.5, -13)
clearAimKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
clearAimKeyBtn.BackgroundTransparency = 0.2
clearAimKeyBtn.Text = "X"
clearAimKeyBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
clearAimKeyBtn.TextSize = 11
clearAimKeyBtn.Font = Enum.Font.GothamBold
clearAimKeyBtn.ZIndex = 2
Instance.new("UICorner", clearAimKeyBtn).CornerRadius = UDim.new(0, 6)

keybindButton.MouseButton1Click:Connect(function() bindingAimKey = true keybindButton.Text = "Press key..." end)
clearAimKeyBtn.MouseButton1Click:Connect(function() currentAimKey = nil keybindButton.Text = "None" bindingAimKey = false end)

UserInputService.InputBegan:Connect(function(input)
	if bindingAimKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.Backspace then currentAimKey = nil keybindButton.Text = "None" else currentAimKey = input.KeyCode keybindButton.Text = input.KeyCode.Name end
			bindingAimKey = false
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3 then
			currentAimKey = input.UserInputType
			keybindButton.Text = input.UserInputType.Name
			bindingAimKey = false
		end
	end
end)

-- Değerler
local fovRadius = 120
local maxAimDistance = 500
local customWalkSpeed = 16

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Radius = fovRadius
fovCircle.Color = currentTheme.Accent
fovCircle.Thickness = 1.5
fovCircle.Filled = false
fovCircle.Transparency = 0.7

createSlider(combatPanel, "Aimbot FOV", 50, 300, 120, 150, false, function(val) fovRadius = val fovCircle.Radius = val end)
createSlider(combatPanel, "Max Distance", 50, 2000, 500, 205, false, function(val) maxAimDistance = val end)
createSlider(playerPanel, "WalkSpeed", 16, 100, 16, 100, false, function(val) customWalkSpeed = val end)

-- Settings Sekmesi
local themeLabel = Instance.new("TextLabel", settingsPanel)
themeLabel.Size = UDim2.new(1, 0, 0, 25)
themeLabel.Position = UDim2.new(0, 0, 0, 10)
themeLabel.BackgroundTransparency = 1
themeLabel.Text = "Menu Theme"
themeLabel.TextColor3 = currentTheme.Text
themeLabel.TextSize = 13
themeLabel.Font = Enum.Font.GothamBold
themeLabel.TextXAlignment = Enum.TextXAlignment.Left
themeLabel.ZIndex = 2
table.insert(themedTexts, themeLabel)

local function applyTheme(themeData)
	currentTheme = themeData
	MainFrame.BackgroundColor3 = currentTheme.Main
	Sidebar.BackgroundColor3 = currentTheme.Sidebar
	fovCircle.Color = currentTheme.Accent
	
	for _, btn in ipairs(themedButtons) do btn.BackgroundColor3 = currentTheme.ButtonBg end
	for _, txt in ipairs(themedTexts) do txt.TextColor3 = currentTheme.Text end
	for _, item in ipairs(themedAccents) do item.Obj[item.Property] = currentTheme.Accent end
	for _, fill in ipairs(themedFills) do fill.BackgroundColor3 = currentTheme.Accent end
end

local function createThemeButton(name, xPos, themeData)
	local btn = Instance.new("TextButton", settingsPanel)
	btn.Size = UDim2.new(0, 110, 0, 28)
	btn.Position = UDim2.new(0, xPos, 0, 38)
	btn.BackgroundColor3 = currentTheme.ButtonBg
	btn.BackgroundTransparency = 0.2
	btn.Text = name
	btn.TextColor3 = currentTheme.Text
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	btn.ZIndex = 2
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	table.insert(themedButtons, btn)
	table.insert(themedTexts, btn)
	btn.MouseButton1Click:Connect(function() applyTheme(themeData) end)
end

createThemeButton("Dark Theme", 0, Themes.Dark)
createThemeButton("Cyber Neon", 115, Themes.Cyber)
createThemeButton("Rose Pink", 230, Themes.Rose)

-- Menü Açma Tuşu
local menuKeyLabel = Instance.new("TextLabel", settingsPanel)
menuKeyLabel.Size = UDim2.new(1, 0, 0, 25)
menuKeyLabel.Position = UDim2.new(0, 0, 0, 90)
menuKeyLabel.BackgroundTransparency = 1
menuKeyLabel.Text = "Menu Open/Close Key"
menuKeyLabel.TextColor3 = currentTheme.Text
menuKeyLabel.TextSize = 13
menuKeyLabel.Font = Enum.Font.GothamBold
menuKeyLabel.TextXAlignment = Enum.TextXAlignment.Left
menuKeyLabel.ZIndex = 2
table.insert(themedTexts, menuKeyLabel)

local menuKeyButton = Instance.new("TextButton", settingsPanel)
menuKeyButton.Size = UDim2.new(0, 120, 0, 28)
menuKeyButton.Position = UDim2.new(0, 0, 0, 120)
menuKeyButton.BackgroundColor3 = currentTheme.ButtonBg
menuKeyButton.BackgroundTransparency = 0.2
menuKeyButton.Text = "Zero (0)"
menuKeyButton.TextColor3 = currentTheme.Accent
menuKeyButton.TextSize = 11
menuKeyButton.Font = Enum.Font.GothamBold
menuKeyButton.ZIndex = 2
Instance.new("UICorner", menuKeyButton).CornerRadius = UDim.new(0, 6)
table.insert(themedButtons, menuKeyButton)
table.insert(themedAccents, {Obj = menuKeyButton, Property = "TextColor3"})

local currentMenuKey = Enum.KeyCode.Zero
local bindingMenuKey = false

menuKeyButton.MouseButton1Click:Connect(function() bindingMenuKey = true menuKeyButton.Text = "Press key..." end)

UserInputService.InputBegan:Connect(function(input)
	if bindingMenuKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then currentMenuKey = input.KeyCode menuKeyButton.Text = input.KeyCode.Name bindingMenuKey = false end
	else
		if input.KeyCode == currentMenuKey then MainFrame.Visible = not MainFrame.Visible end
	end
end)

local saveConfigBtn = Instance.new("TextButton", settingsPanel)
saveConfigBtn.Size = UDim2.new(1, 0, 0, 35)
saveConfigBtn.Position = UDim2.new(0, 0, 0, 170)
saveConfigBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 60)
saveConfigBtn.BackgroundTransparency = 0.2
saveConfigBtn.Text = "Save Config"
saveConfigBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveConfigBtn.TextSize = 13
saveConfigBtn.Font = Enum.Font.GothamBold
saveConfigBtn.ZIndex = 2
Instance.new("UICorner", saveConfigBtn).CornerRadius = UDim.new(0, 6)

local notificationLabel = Instance.new("TextLabel", settingsPanel)
notificationLabel.Size = UDim2.new(1, 0, 0, 30)
notificationLabel.Position = UDim2.new(0, 0, 0, 210)
notificationLabel.BackgroundTransparency = 1
notificationLabel.Text = ""
notificationLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
notificationLabel.TextSize = 12
notificationLabel.Font = Enum.Font.GothamBold
notificationLabel.TextXAlignment = Enum.TextXAlignment.Center
notificationLabel.ZIndex = 2

saveConfigBtn.MouseButton1Click:Connect(function()
	notificationLabel.Text = "Config Successfully Saved!"
	task.wait(2)
	notificationLabel.Text = ""
end)

-- Menü Sürüklenebilirlik
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Crazy Modu Değişkenleri
local customSky = nil
local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalPartColors = {}
local lastCrazyUpdate = 0

-- Aimbot Tuş Kontrolü
local isAimKeyDown = false
UserInputService.InputBegan:Connect(function(input, gpe)
	if not bindingAimKey and currentAimKey and not gpe then
		if input.KeyCode == currentAimKey or input.UserInputType == currentAimKey then
			isAimKeyDown = true
		end
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if currentAimKey and (input.KeyCode == currentAimKey or input.UserInputType == currentAimKey) then
		isAimKeyDown = false
	end
end)

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

local activeTracers = {}

local function clearDrawings()
	for _, tr in pairs(activeTracers) do tr:Remove() end
	activeTracers = {}
end

-- Render Döngüsü
RunService.RenderStepped:Connect(function()
	local rainbowColor = Color3.fromHSV((tick() % 5) / 5, 1, 1)
	
	local t = (tick() % 4) / 4
	local galaxyColor
	if t < 0.33 then
		galaxyColor = Color3.fromRGB(255, 215, 0):Lerp(Color3.fromRGB(138, 43, 226), t * 3)
	elseif t < 0.66 then
		galaxyColor = Color3.fromRGB(138, 43, 226):Lerp(Color3.fromRGB(255, 255, 255), (t - 0.33) * 3)
	else
		galaxyColor = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(255, 215, 0), (t - 0.66) * 3)
	end

	clearDrawings()

	local activeEffectColor = (espEffectType == "Galaxy") and galaxyColor or rainbowColor

	local char = LocalPlayer.Character
	if char and char:FindFirstChildOfClass("Humanoid") then
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		
		if crazyEnabled then
			if not customSky then
				originalAmbient = Lighting.Ambient
				originalOutdoorAmbient = Lighting.OutdoorAmbient
				customSky = Instance.new("Sky")
				customSky.Name = "CrazyRainbowSky"
				customSky.SkyboxBk = "rbxassetid://60685915"
				customSky.SkyboxDn = "rbxassetid://60685915"
				customSky.SkyboxFt = "rbxassetid://60685915"
				customSky.SkyboxLf = "rbxassetid://60685915"
				customSky.SkyboxRt = "rbxassetid://60685915"
				customSky.SkyboxUp = "rbxassetid://60685915"
				customSky.Parent = Lighting
			end
			Lighting.Ambient = rainbowColor
			Lighting.OutdoorAmbient = rainbowColor
			hum.WalkSpeed = customWalkSpeed
			
			if tick() - lastCrazyUpdate > 0.15 then
				lastCrazyUpdate = tick()
				for _, obj in ipairs(workspace:GetDescendants()) do
					if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
						if not originalPartColors[obj] then originalPartColors[obj] = obj.Color end
						pcall(function() obj.Color = Color3.fromHSV(((tick() + obj.Position.X) % 5) / 5, 1, 1) end)
					end
				end
			end
		else
			if customSky then customSky:Destroy() customSky = nil end
			Lighting.Ambient = originalAmbient
			Lighting.OutdoorAmbient = originalOutdoorAmbient
			hum.WalkSpeed = customWalkSpeed
			
			if next(originalPartColors) ~= nil then
				for obj, col in pairs(originalPartColors) do
					if obj and obj.Parent then obj.Color = col end
				end
				originalPartColors = {}
			end
		end
		
		if noclipEnabled then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
		
		if flyEnabled and root then
			hum.PlatformStand = true
			local camCFrame = Camera.CFrame
			local moveVector = Vector3.new()
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + camCFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - camCFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - camCFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + camCFrame.RightVector end
			root.Velocity = moveVector * 50
			root.CFrame = CFrame.new(root.Position, root.Position + camCFrame.LookVector)
		else
			if hum.PlatformStand and not flyEnabled then hum.PlatformStand = false end
		end
	end

	-- Rakip ESP, Chams ve Tracers
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			local pChar = p.Character
			local isEnemy = true
			if LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then isEnemy = false end
			
			if isEnemy then
				local hl = pChar:FindFirstChild("EnemyEspHL")
				if espEnabled then
					if not hl then
						hl = Instance.new("Highlight")
						hl.Name = "EnemyEspHL"
						hl.FillTransparency = 0.3
						hl.OutlineTransparency = 0
						hl.Parent = pChar
					end
					hl.Enabled = true
					hl.FillColor = activeEffectColor
					hl.OutlineColor = Color3.fromRGB(255, 255, 255)
				else
					if hl then hl.Enabled = false end
				end

				local chams = pChar:FindFirstChild("EnemyChamsHL")
				if chamsEnabled then
					if not chams then
						chams = Instance.new("Highlight")
						chams.Name = "EnemyChamsHL"
						chams.FillTransparency = 0.2
						chams.OutlineTransparency = 0
						chams.Parent = pChar
					end
					chams.Enabled = true
					chams.FillColor = activeEffectColor
					chams.OutlineColor = activeEffectColor
				else
					if chams then chams.Enabled = false end
				end

				if tracersEnabled and pChar:FindFirstChild("HumanoidRootPart") then
					local hrp = pChar.HumanoidRootPart
					local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
					if onScreen then
						local tracer = Drawing.new("Line")
						tracer.Visible = true
						tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
						tracer.To = Vector2.new(screenPos.X, screenPos.Y)
						tracer.Color = activeEffectColor
						tracer.Thickness = 1.5
						tracer.Transparency = 0.8
						table.insert(activeTracers, tracer)
					end
				end
			else
				local hl = pChar:FindFirstChild("EnemyEspHL") if hl then hl.Enabled = false end
				local chams = pChar:FindFirstChild("EnemyChamsHL") if chams then chams.Enabled = false end
			end
		end
	end

	if aimEnabled and not fovHidden then
		fovCircle.Visible = true
		fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	else
		fovCircle.Visible = false
	end
	
	if aimEnabled and isAimKeyDown then
		local closestTarget = nil
		local shortestDistance = fovRadius
		local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		
		if myRoot then
			raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
					local isEnemy = true
					if LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then isEnemy = false end
					
					if isEnemy then
						local head = p.Character.Head
						if (head.Position - myRoot.Position).Magnitude <= maxAimDistance then
							local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
							if humanoid and humanoid.Health > 0 then
								local isVisible = true
								if wallCheckEnabled then
									local origin = Camera.CFrame.Position
									local direction = (head.Position - origin)
									local res = workspace:Raycast(origin, direction, raycastParams)
									if res and not res.Instance:IsDescendantOf(p.Character) then isVisible = false end
								end
								if isVisible then
									local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
									if onScreen then
										local magnitude = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
										if magnitude < shortestDistance then
											shortestDistance = magnitude
											closestTarget = head
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if closestTarget then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
		end
	end
end)
