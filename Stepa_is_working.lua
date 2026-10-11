repeat task.wait() until game:IsLoaded()

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

for _, v in pairs(PlayerGui:GetChildren()) do
	if v.Name == "MainGui" or v.Name == "ESP" then v:Destroy() end
end
task.wait(0.3)

local gui = Instance.new("ScreenGui")
gui.Name = "MainGui"
gui.ResetOnSpawn = false
gui.Enabled = true
gui.DisplayOrder = 999
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

local BLUE = Color3.fromRGB(0, 170, 255)
local RED = Color3.fromRGB(220, 50, 50)
local GREEN = Color3.fromRGB(50, 180, 50)
local GHOST = Color3.fromRGB(180, 180, 255)
local PURPLE = Color3.fromRGB(150, 50, 255)
local ORANGE = Color3.fromRGB(255, 150, 0)
local CYAN = Color3.fromRGB(0, 200, 200)
local FLING = Color3.fromRGB(255, 80, 80)
local TROLL = Color3.fromRGB(255, 200, 0)
local GIFT = Color3.fromRGB(200, 100, 255)
local WHITE_COLOR = Color3.new(1, 1, 1)
local DARK = Color3.fromRGB(35, 35, 35)
local DARKER = Color3.fromRGB(22, 22, 22)
local GRAY = Color3.fromRGB(55, 55, 55)

-- КНОПКА МЕНЮ
local menuBtn = Instance.new("TextButton")
menuBtn.Size = UDim2.new(0, 100, 0, 50)
menuBtn.Position = UDim2.new(1, -110, 0, 10)
menuBtn.BackgroundColor3 = BLUE
menuBtn.TextColor3 = WHITE_COLOR
menuBtn.Text = "МЕНЮ"
menuBtn.Font = Enum.Font.GothamBold
menuBtn.TextSize = 18
menuBtn.BorderSizePixel = 0
menuBtn.Parent = gui
Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(0, 10)

-- ГЛАВНОЕ МЕНЮ
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 260, 0, 340)
main.Position = UDim2.new(1, -270, 0.5, -170)
main.BackgroundColor3 = DARK
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = BLUE
mainStroke.Transparency = 0.3
mainStroke.Parent = main

local mainBar = Instance.new("Frame")
mainBar.Size = UDim2.new(1, 0, 0, 50)
mainBar.BackgroundColor3 = DARKER
mainBar.BorderSizePixel = 0
mainBar.Parent = main
Instance.new("UICorner", mainBar).CornerRadius = UDim.new(0, 12)

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(0, 180, 0, 50)
mainTitle.Position = UDim2.new(0, 15, 0, 0)
mainTitle.BackgroundTransparency = 1
mainTitle.TextColor3 = BLUE
mainTitle.Text = "🎮 МЕНЮ"
mainTitle.Font = Enum.Font.GothamBlack
mainTitle.TextSize = 24
mainTitle.TextXAlignment = Enum.TextXAlignment.Left
mainTitle.Parent = mainBar

local mainX = Instance.new("TextButton")
mainX.Size = UDim2.new(0, 35, 0, 35)
mainX.Position = UDim2.new(1, -42, 0, 8)
mainX.BackgroundColor3 = RED
mainX.TextColor3 = WHITE_COLOR
mainX.Text = "X"
mainX.Font = Enum.Font.GothamBold
mainX.TextSize = 18
mainX.BorderSizePixel = 0
mainX.Parent = mainBar
Instance.new("UICorner", mainX).CornerRadius = UDim.new(0, 6)
mainX.MouseButton1Click:Connect(function() main.Visible = false end)

-- Перетаскивание главного меню
local mainDragging = false
local mainDragStart = nil
local mainStartPos = nil

mainBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		mainDragging = true
		mainDragStart = input.Position
		mainStartPos = main.Position
	end
end)

mainBar.InputEnded:Connect(function() mainDragging = false end)

UIS.InputChanged:Connect(function(input)
	if mainDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - mainDragStart
		main.Position = UDim2.new(mainStartPos.X.Scale, mainStartPos.X.Offset + delta.X, mainStartPos.Y.Scale, mainStartPos.Y.Offset + delta.Y)
	end
end)

-- Прокрутка
local scrollMenu = Instance.new("ScrollingFrame")
scrollMenu.Size = UDim2.new(1, -10, 1, -60)
scrollMenu.Position = UDim2.new(0, 5, 0, 55)
scrollMenu.BackgroundTransparency = 1
scrollMenu.BorderSizePixel = 0
scrollMenu.ScrollBarThickness = 4
scrollMenu.ScrollBarImageColor3 = BLUE
scrollMenu.CanvasSize = UDim2.new(0, 0, 0, 560)
scrollMenu.Parent = main

local menuLayout = Instance.new("UIListLayout")
menuLayout.Padding = UDim.new(0, 6)
menuLayout.Parent = scrollMenu

-- 11 КНОПОК
local menuItems = {
	{name = "✈  ПОЛЁТ", color = BLUE},
	{name = "📡  ТЕЛЕПОРТ К ИГРОКУ", color = GREEN},
	{name = "👻  РЕЖИМ ПРИЗРАКА", color = GHOST},
	{name = "🧱  СКВОЗЬ СТЕНЫ", color = PURPLE},
	{name = "⏰  АНТИ-АФК", color = ORANGE},
	{name = "👁  ESP", color = WHITE_COLOR},
	{name = "⚡  БЕГ / ПРЫЖОК", color = CYAN},
	{name = "💨  ОТКИДАЛКА", color = FLING},
	{name = "🎭  ТРОЛЛИНГ", color = TROLL},
	{name = "🎁  ВЫДАТЬ ВСЕ ПРЕДМЕТЫ", color = GIFT},
	{name = "🔄  СМЕНИТЬ СЕРВЕР", color = Color3.fromRGB(255, 100, 100)}
}

local createdButtons = {}

for i, item in pairs(menuItems) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -6, 0, 44)
	btn.BackgroundColor3 = GRAY
	btn.TextColor3 = WHITE_COLOR
	btn.Text = item.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	btn.Name = "Btn"..i
	btn.Parent = scrollMenu
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local accent = Instance.new("Frame")
	accent.Size = UDim2.new(0, 4, 1, -10)
	accent.Position = UDim2.new(0, 0, 0, 5)
	accent.BackgroundColor3 = item.color
	accent.BorderSizePixel = 0
	accent.Parent = btn
	Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 2)

	createdButtons[i] = btn
end

-- ФУНКЦИЯ ОКНА
local function makeWin(title, h)
	local win = Instance.new("Frame")
	win.Size = UDim2.new(0, 340, 0, h)
	win.Position = UDim2.new(0.5, -170, 0.5, -h/2)
	win.BackgroundColor3 = DARK
	win.BorderSizePixel = 0
	win.Visible = false
	win.Parent = gui
	Instance.new("UICorner", win).CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = BLUE
	stroke.Transparency = 0.3
	stroke.Parent = win

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(1, 0, 0, 50)
	bar.BackgroundColor3 = DARKER
	bar.BorderSizePixel = 0
	bar.Parent = win
	Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 12)

	local ttl = Instance.new("TextLabel")
	ttl.Size = UDim2.new(0, 220, 0, 50)
	ttl.Position = UDim2.new(0, 15, 0, 0)
	ttl.BackgroundTransparency = 1
	ttl.TextColor3 = WHITE_COLOR
	ttl.Text = title
	ttl.Font = Enum.Font.GothamBold
	ttl.TextSize = 18
	ttl.TextXAlignment = Enum.TextXAlignment.Left
	ttl.Parent = bar

	local xBtn = Instance.new("TextButton")
	xBtn.Size = UDim2.new(0, 35, 0, 35)
	xBtn.Position = UDim2.new(1, -42, 0, 8)
	xBtn.BackgroundColor3 = RED
	xBtn.TextColor3 = WHITE_COLOR
	xBtn.Text = "X"
	xBtn.Font = Enum.Font.GothamBold
	xBtn.TextSize = 18
	xBtn.BorderSizePixel = 0
	xBtn.Parent = bar
	Instance.new("UICorner", xBtn).CornerRadius = UDim.new(0, 6)
	xBtn.MouseButton1Click:Connect(function() win.Visible = false end)

	local dragging = false
	local dragStart = nil
	local startPos = nil

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = win.Position
		end
	end)

	bar.InputEnded:Connect(function() dragging = false end)

	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	return win
end

-- ПОЛЁТ
local flyWin = makeWin("✈ ПОЛЁТ", 150)
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1, -20, 0, 50)
flyBtn.Position = UDim2.new(0, 10, 0, 60)
flyBtn.BackgroundColor3 = GREEN
flyBtn.TextColor3 = WHITE_COLOR
flyBtn.Text = "🚀 АКТИВИРОВАТЬ ПОЛЁТ"
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 16
flyBtn.BorderSizePixel = 0
flyBtn.Parent = flyWin
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 10)
flyBtn.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
	end)
end)

-- ТЕЛЕПОРТ
local tpWin = makeWin("📡 ТЕЛЕПОРТ", 340)
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 55)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = BLUE
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.Parent = tpWin
Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 5)

local function updateTPList()
	for _, c in pairs(scroll:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	local players = game.Players:GetPlayers()
	local total = 0
	for _, p in pairs(players) do
		if p ~= Player then
			local b = Instance.new("TextButton")
			b.Size = UDim2.new(1, -4, 0, 40)
			b.BackgroundColor3 = GRAY
			b.TextColor3 = WHITE_COLOR
			b.Text = "👤 " .. p.Name
			b.Font = Enum.Font.Gotham
			b.TextSize = 14
			b.BorderSizePixel = 0
			b.Parent = scroll
			Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
			b.MouseButton1Click:Connect(function()
				if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
					Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
					tpWin.Visible = false
				end
			end)
			total = total + 45
		end
	end
	scroll.CanvasSize = UDim2.new(0, 0, 0, total)
end

-- ПРИЗРАК
local ghostWin = makeWin("👻 РЕЖИМ ПРИЗРАКА", 170)
local ghostBtn = Instance.new("TextButton")
ghostBtn.Size = UDim2.new(1, -20, 0, 50)
ghostBtn.Position = UDim2.new(0, 10, 0, 60)
ghostBtn.BackgroundColor3 = GHOST
ghostBtn.TextColor3 = WHITE_COLOR
ghostBtn.Text = "👻 СТАТЬ ПРИЗРАКОМ"
ghostBtn.Font = Enum.Font.GothamBold
ghostBtn.TextSize = 16
ghostBtn.BorderSizePixel = 0
ghostBtn.Parent = ghostWin
Instance.new("UICorner", ghostBtn).CornerRadius = UDim.new(0, 10)

local ghostOn = false
local ghostConn = nil

ghostBtn.MouseButton1Click:Connect(function()
	ghostOn = not ghostOn
	if ghostOn then
		if ghostConn then ghostConn:Disconnect() end
		ghostConn = RS.Stepped:Connect(function()
			if Player.Character then
				for _, v in pairs(Player.Character:GetDescendants()) do
					if v:IsA("BasePart") then v.LocalTransparencyModifier = 0.7 end
				end
			end
		end)
		ghostBtn.Text = "🔙 СТАТЬ ВИДИМЫМ"
		ghostBtn.BackgroundColor3 = RED
	else
		if ghostConn then ghostConn:Disconnect(); ghostConn = nil end
		if Player.Character then
			for _, v in pairs(Player.Character:GetDescendants()) do
				if v:IsA("BasePart") then v.LocalTransparencyModifier = 0 end
			end
		end
		ghostBtn.Text = "👻 СТАТЬ ПРИЗРАКОМ"
		ghostBtn.BackgroundColor3 = GHOST
	end
end)

-- НОКЛИП
local ncWin = makeWin("🧱 СКВОЗЬ СТЕНЫ", 170)
local ncBtn = Instance.new("TextButton")
ncBtn.Size = UDim2.new(1, -20, 0, 50)
ncBtn.Position = UDim2.new(0, 10, 0, 60)
ncBtn.BackgroundColor3 = GREEN
ncBtn.TextColor3 = WHITE_COLOR
ncBtn.Text = "🔓 ВКЛЮЧИТЬ НОКЛИП"
ncBtn.Font = Enum.Font.GothamBold
ncBtn.TextSize = 16
ncBtn.BorderSizePixel = 0
ncBtn.Parent = ncWin
Instance.new("UICorner", ncBtn).CornerRadius = UDim.new(0, 10)

local ncOn = false
local ncConn = nil

ncBtn.MouseButton1Click:Connect(function()
	ncOn = not ncOn
	if ncOn then
		if ncConn then ncConn:Disconnect() end
		ncConn = RS.Stepped:Connect(function()
			if Player.Character then
				for _, v in pairs(Player.Character:GetDescendants()) do
					if v:IsA("BasePart") then v.CanCollide = false end
				end
			end
		end)
		ncBtn.Text = "🔒 ВЫКЛЮЧИТЬ НОКЛИП"
		ncBtn.BackgroundColor3 = RED
	else
		if ncConn then ncConn:Disconnect(); ncConn = nil end
		if Player.Character then
			for _, v in pairs(Player.Character:GetDescendants()) do
				if v:IsA("BasePart") then v.CanCollide = true end
			end
		end
		ncBtn.Text = "🔓 ВКЛЮЧИТЬ НОКЛИП"
		ncBtn.BackgroundColor3 = GREEN
	end
end)

-- АНТИ-АФК
local afkWin = makeWin("⏰ АНТИ-АФК", 150)
local afkBtn = Instance.new("TextButton")
afkBtn.Size = UDim2.new(1, -20, 0, 50)
afkBtn.Position = UDim2.new(0, 10, 0, 60)
afkBtn.BackgroundColor3 = ORANGE
afkBtn.TextColor3 = WHITE_COLOR
afkBtn.Text = "⏰ ВКЛЮЧИТЬ АНТИ-АФК"
afkBtn.Font = Enum.Font.GothamBold
afkBtn.TextSize = 16
afkBtn.BorderSizePixel = 0
afkBtn.Parent = afkWin
Instance.new("UICorner", afkBtn).CornerRadius = UDim.new(0, 10)

local afkOn = false
local afkConn = nil
local afkDir = 1
local afkTimer = 0

afkBtn.MouseButton1Click:Connect(function()
	afkOn = not afkOn
	if afkOn then
		afkTimer = 0
		afkDir = 1
		if afkConn then afkConn:Disconnect() end
		afkConn = RS.Heartbeat:Connect(function(dt)
			afkTimer = afkTimer + dt
			if afkTimer > 3 then
				afkTimer = 0
				afkDir = afkDir * -1
			end
			if Player.Character and Player.Character:FindFirstChild("Humanoid") then
				Player.Character.Humanoid.MoveDirection = Vector3.new(afkDir, 0, 0)
			end
		end)
		afkBtn.Text = "⏸ ОСТАНОВИТЬ"
		afkBtn.BackgroundColor3 = RED
	else
		if afkConn then afkConn:Disconnect(); afkConn = nil end
		if Player.Character and Player.Character:FindFirstChild("Humanoid") then
			Player.Character.Humanoid.MoveDirection = Vector3.zero
		end
		afkBtn.Text = "⏰ ВКЛЮЧИТЬ АНТИ-АФК"
		afkBtn.BackgroundColor3 = ORANGE
	end
end)

-- ESP
local espWin = makeWin("👁 ESP", 150)
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(1, -20, 0, 50)
espBtn.Position = UDim2.new(0, 10, 0, 60)
espBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
espBtn.TextColor3 = WHITE_COLOR
espBtn.Text = "👁 ВКЛЮЧИТЬ ESP"
espBtn.Font = Enum.Font.GothamBold
espBtn.TextSize = 16
espBtn.BorderSizePixel = 0
espBtn.Parent = espWin
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 10)

local espOn = false
local espGui = nil
local espConn = nil

local function createESP()
	if espGui then espGui:Destroy() end
	espGui = Instance.new("ScreenGui")
	espGui.Name = "ESP"
	espGui.ResetOnSpawn = false
	espGui.Parent = PlayerGui
end

local function updateESP()
	if not espGui then return end
	for _, v in pairs(espGui:GetChildren()) do v:Destroy() end
	local camera = workspace.CurrentCamera
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= Player and p.Character and p.Character:FindFirstChild("Head") then
			local pos, onScreen = camera:WorldToViewportPoint(p.Character.Head.Position)
			if onScreen then
				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(0, 200, 0, 20)
				label.Position = UDim2.new(0, pos.X - 100, 0, pos.Y - 35)
				label.BackgroundTransparency = 1
				label.TextColor3 = WHITE_COLOR
				label.Text = p.Name
				label.Font = Enum.Font.GothamBold
				label.TextSize = 14
				label.TextStrokeTransparency = 0
				label.TextStrokeColor3 = Color3.new(0, 0, 0)
				label.Parent = espGui
			end
		end
	end
end

espBtn.MouseButton1Click:Connect(function()
	espOn = not espOn
	if espOn then
		createESP()
		if espConn then espConn:Disconnect() end
		espConn = RS.RenderStepped:Connect(updateESP)
		espBtn.Text = "🔙 ВЫКЛЮЧИТЬ ESP"
		espBtn.BackgroundColor3 = RED
	else
		if espGui then espGui:Destroy(); espGui = nil end
		if espConn then espConn:Disconnect(); espConn = nil end
		espBtn.Text = "👁 ВКЛЮЧИТЬ ESP"
		espBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	end
end)

-- БЕГ / ПРЫЖОК
local spWin = makeWin("⚡ БЕГ / ПРЫЖОК", 260)
local spLab = Instance.new("TextLabel")
spLab.Size = UDim2.new(1, -20, 0, 22)
spLab.Position = UDim2.new(0, 10, 0, 60)
spLab.BackgroundTransparency = 1
spLab.TextColor3 = WHITE_COLOR
spLab.Text = "🏃 Скорость: 16"
spLab.Font = Enum.Font.GothamBold
spLab.TextSize = 14
spLab.TextXAlignment = Enum.TextXAlignment.Left
spLab.Parent = spWin

local spSlide = Instance.new("Frame")
spSlide.Size = UDim2.new(1, -80, 0, 26)
spSlide.Position = UDim2.new(0, 10, 0, 87)
spSlide.BackgroundColor3 = DARKER
spSlide.BorderSizePixel = 0
spSlide.Parent = spWin
Instance.new("UICorner", spSlide).CornerRadius = UDim.new(0, 6)

local spFill = Instance.new("Frame")
spFill.Size = UDim2.new(0, 0, 1, 0)
spFill.BackgroundColor3 = BLUE
spFill.BorderSizePixel = 0
spFill.Parent = spSlide
Instance.new("UICorner", spFill).CornerRadius = UDim.new(0, 6)

local spBox = Instance.new("TextBox")
spBox.Size = UDim2.new(0, 55, 0, 26)
spBox.Position = UDim2.new(1, -60, 0, 87)
spBox.BackgroundColor3 = GRAY
spBox.TextColor3 = WHITE_COLOR
spBox.Text = "16"
spBox.Font = Enum.Font.Gotham
spBox.TextSize = 13
spBox.BorderSizePixel = 0
spBox.Parent = spWin
Instance.new("UICorner", spBox).CornerRadius = UDim.new(0, 5)

local jpLab = Instance.new("TextLabel")
jpLab.Size = UDim2.new(1, -20, 0, 22)
jpLab.Position = UDim2.new(0, 10, 0, 125)
jpLab.BackgroundTransparency = 1
jpLab.TextColor3 = WHITE_COLOR
jpLab.Text = "🦘 Прыжок: 50"
jpLab.Font = Enum.Font.GothamBold
jpLab.TextSize = 14
jpLab.TextXAlignment = Enum.TextXAlignment.Left
jpLab.Parent = spWin

local jpSlide = Instance.new("Frame")
jpSlide.Size = UDim2.new(1, -80, 0, 26)
jpSlide.Position = UDim2.new(0, 10, 0, 152)
jpSlide.BackgroundColor3 = DARKER
jpSlide.BorderSizePixel = 0
jpSlide.Parent = spWin
Instance.new("UICorner", jpSlide).CornerRadius = UDim.new(0, 6)

local jpFill = Instance.new("Frame")
jpFill.Size = UDim2.new(0, 0, 1, 0)
jpFill.BackgroundColor3 = CYAN
jpFill.BorderSizePixel = 0
jpFill.Parent = jpSlide
Instance.new("UICorner", jpFill).CornerRadius = UDim.new(0, 6)

local jpBox = Instance.new("TextBox")
jpBox.Size = UDim2.new(0, 55, 0, 26)
jpBox.Position = UDim2.new(1, -60, 0, 152)
jpBox.BackgroundColor3 = GRAY
jpBox.TextColor3 = WHITE_COLOR
jpBox.Text = "50"
jpBox.Font = Enum.Font.Gotham
jpBox.TextSize = 13
jpBox.BorderSizePixel = 0
jpBox.Parent = spWin
Instance.new("UICorner", jpBox).CornerRadius = UDim.new(0, 5)

local appBtn = Instance.new("TextButton")
appBtn.Size = UDim2.new(1, -20, 0, 42)
appBtn.Position = UDim2.new(0, 10, 0, 200)
appBtn.BackgroundColor3 = BLUE
appBtn.TextColor3 = WHITE_COLOR
appBtn.Text = "✅ ПРИМЕНИТЬ"
appBtn.Font = Enum.Font.GothamBold
appBtn.TextSize = 16
appBtn.BorderSizePixel = 0
appBtn.Parent = spWin
Instance.new("UICorner", appBtn).CornerRadius = UDim.new(0, 10)

local spVal = 16
local jpVal = 50

local function updSp(v)
	v = math.clamp(tonumber(v) or 16, 16, 1000)
	spVal = v
	spLab.Text = "🏃 Скорость: " .. math.floor(v)
	spFill.Size = UDim2.new((v - 16) / (1000 - 16), 0, 1, 0)
	spBox.Text = tostring(math.floor(v))
end

local function updJp(v)
	v = math.clamp(tonumber(v) or 50, 50, 1000)
	jpVal = v
	jpLab.Text = "🦘 Прыжок: " .. math.floor(v)
	jpFill.Size = UDim2.new((v - 50) / (1000 - 50), 0, 1, 0)
	jpBox.Text = tostring(math.floor(v))
end

spSlide.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		local function update(input)
			local rel = math.clamp((input.Position.X - spSlide.AbsolutePosition.X) / spSlide.AbsoluteSize.X, 0, 1)
			updSp(16 + (1000 - 16) * rel)
		end
		update(i)
		local conn = UIS.InputChanged:Connect(function(ch)
			if ch.UserInputType == Enum.UserInputType.MouseMovement or ch.UserInputType == Enum.UserInputType.Touch then
				update(ch)
			end
		end)
		local ec = UIS.InputEnded:Connect(function()
			conn:Disconnect()
			ec:Disconnect()
		end)
	end
end)

jpSlide.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		local function update(input)
			local rel = math.clamp((input.Position.X - jpSlide.AbsolutePosition.X) / jpSlide.AbsoluteSize.X, 0, 1)
			updJp(50 + (1000 - 50) * rel)
		end
		update(i)
		local conn = UIS.InputChanged:Connect(function(ch)
			if ch.UserInputType == Enum.UserInputType.MouseMovement or ch.UserInputType == Enum.UserInputType.Touch then
				update(ch)
			end
		end)
		local ec = UIS.InputEnded:Connect(function()
			conn:Disconnect()
			ec:Disconnect()
		end)
	end
end)

spBox.FocusLost:Connect(function() updSp(spBox.Text) end)
jpBox.FocusLost:Connect(function() updJp(jpBox.Text) end)

appBtn.MouseButton1Click:Connect(function()
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		Player.Character.Humanoid.WalkSpeed = spVal
		Player.Character.Humanoid.JumpPower = jpVal
		Player.Character.Humanoid.UseJumpPower = true
	end
end)

Player.CharacterAdded:Connect(function()
	task.wait(0.5)
	if Player.Character and Player.Character:FindFirstChild("Humanoid") then
		Player.Character.Humanoid.WalkSpeed = spVal
		Player.Character.Humanoid.JumpPower = jpVal
		Player.Character.Humanoid.UseJumpPower = true
	end
end)

-- ОТКИДАЛКА
local flingWin = makeWin("💨 ОТКИДАЛКА", 150)
local flingBtn = Instance.new("TextButton")
flingBtn.Size = UDim2.new(1, -20, 0, 50)
flingBtn.Position = UDim2.new(0, 10, 0, 60)
flingBtn.BackgroundColor3 = FLING
flingBtn.TextColor3 = WHITE_COLOR
flingBtn.Text = "💨 ЗАПУСТИТЬ ОТКИДАЛКУ"
flingBtn.Font = Enum.Font.GothamBold
flingBtn.TextSize = 14
flingBtn.BorderSizePixel = 0
flingBtn.Parent = flingWin
Instance.new("UICorner", flingBtn).CornerRadius = UDim.new(0, 10)
flingBtn.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/miso517/scirpt/refs/heads/main/main.lua"))()
	end)
end)

-- ТРОЛЛИНГ
local trollWin = makeWin("🎭 ТРОЛЛИНГ", 150)
local trollBtn = Instance.new("TextButton")
trollBtn.Size = UDim2.new(1, -20, 0, 50)
trollBtn.Position = UDim2.new(0, 10, 0, 60)
trollBtn.BackgroundColor3 = TROLL
trollBtn.TextColor3 = Color3.new(0, 0, 0)
trollBtn.Text = "🎭 ЗАПУСТИТЬ ТРОЛЛИНГ"
trollBtn.Font = Enum.Font.GothamBold
trollBtn.TextSize = 14
trollBtn.BorderSizePixel = 0
trollBtn.Parent = trollWin
Instance.new("UICorner", trollBtn).CornerRadius = UDim.new(0, 10)
trollBtn.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(game:HttpGet("https://pastebin.com/raw/FWwdST5Y"))()
	end)
end)

-- ВЫДАТЬ ВСЕ ПРЕДМЕТЫ
local giftWin = makeWin("🎁 ВЫДАТЬ ВСЕ ПРЕДМЕТЫ", 150)
local giftBtn = Instance.new("TextButton")
giftBtn.Size = UDim2.new(1, -20, 0, 50)
giftBtn.Position = UDim2.new(0, 10, 0, 60)
giftBtn.BackgroundColor3 = GIFT
giftBtn.TextColor3 = WHITE_COLOR
giftBtn.Text = "🎁 ВЫДАТЬ ВСЕ ПРЕДМЕТЫ"
giftBtn.Font = Enum.Font.GothamBold
giftBtn.TextSize = 14
giftBtn.BorderSizePixel = 0
giftBtn.Parent = giftWin
Instance.new("UICorner", giftBtn).CornerRadius = UDim.new(0, 10)
giftBtn.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Ctepa1511/scripts1/main/gametoolgiver.lua"))()
	end)
end)

-- СМЕНИТЬ СЕРВЕР
local rejoinWin = makeWin("🔄 СМЕНИТЬ СЕРВЕР", 180)
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(1, -20, 0, 50)
rejoinBtn.Position = UDim2.new(0, 10, 0, 60)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
rejoinBtn.TextColor3 = WHITE_COLOR
rejoinBtn.Text = "🔄 ПЕРЕЗАЙТИ"
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.TextSize = 14
rejoinBtn.BorderSizePixel = 0
rejoinBtn.Parent = rejoinWin
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 10)
rejoinBtn.MouseButton1Click:Connect(function()
	pcall(function()
		TeleportService:Teleport(game.PlaceId, Player)
	end)
end)

-- СВЯЗИ
menuBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

if createdButtons[1] then createdButtons[1].MouseButton1Click:Connect(function() flyWin.Visible = true end) end
if createdButtons[2] then createdButtons[2].MouseButton1Click:Connect(function() updateTPList() tpWin.Visible = true end) end
if createdButtons[3] then createdButtons[3].MouseButton1Click:Connect(function() ghostWin.Visible = true end) end
if createdButtons[4] then createdButtons[4].MouseButton1Click:Connect(function() ncWin.Visible = true end) end
if createdButtons[5] then createdButtons[5].MouseButton1Click:Connect(function() afkWin.Visible = true end) end
if createdButtons[6] then createdButtons[6].MouseButton1Click:Connect(function() espWin.Visible = true end) end
if createdButtons[7] then createdButtons[7].MouseButton1Click:Connect(function() spWin.Visible = true end) end
if createdButtons[8] then createdButtons[8].MouseButton1Click:Connect(function() flingWin.Visible = true end) end
if createdButtons[9] then createdButtons[9].MouseButton1Click:Connect(function() trollWin.Visible = true end) end
if createdButtons[10] then createdButtons[10].MouseButton1Click:Connect(function() giftWin.Visible = true end) end
if createdButtons[11] then createdButtons[11].MouseButton1Click:Connect(function() rejoinWin.Visible = true end) end

UIS.InputBegan:Connect(function(i, gpe)
	if not gpe and i.KeyCode == Enum.KeyCode.M then main.Visible = not main.Visible end
end)

updateTPList()
print("✅ Меню загружено")