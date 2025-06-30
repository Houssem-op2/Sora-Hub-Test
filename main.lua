local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- 🪟 Main Window
local Window = Rayfield:CreateWindow({
	Name = "Sora-Hub universal script",
	LoadingTitle = "Sora-Hub",
	LoadingSubtitle = "By Sky",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil,
		FileName = "Sora-Hub"
	},
	KeySystem = true,
	KeySettings = {
		Title = "Sora-Hub universal script",
		Subtitle = "Key Required",
		Note = "🎁 Press Get Key if you don't have one.",
		FileName = "Sora-Hub",
		SaveKey = false,
		GrabKeyFromSite = true,
		Key = "https://pastebin.com/raw/MjBBc3t2", -- Lootlink pastebin key
	}
})

-- 🔔 Notify user during key input screen
Rayfield:Notify({
	Title = "Key Required",
	Content = "Press 'Get Key' to copy the key link, then 'Check Key' after pasting.",
	Duration = 8
})

-- 🏠 Home Tab (after key accepted)
local Home = Window:CreateTab("Home", 4483362458)

Home:CreateButton({
	Name = "Get Key",
	Callback = function()
		setclipboard("https://loot-link.com/s?0raUATlv")
		Rayfield:Notify({
			Title = "Sora-Hub",
			Content = "Key link copied to clipboard!",
			Duration = 4
		})
	end,
})

Home:CreateButton({
	Name = "Check Key",
	Callback = function()
		Rayfield:PromptKey()
	end,
})

-- 💥 Exploits Tab
local Exploits = Window:CreateTab("Exploits", 13273922996)

-- 🔘 Instant Interaction Section
local InstantSection = Exploits:CreateSection("Instant Interaction")

-- ⚡ Speed Changer Slider
Exploits:CreateSlider({
	Name = "Speed Changer",
	SectionParent = InstantSection,
	Range = {1, 80},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 16,
	Flag = "SpeedChanger",
	Callback = function(Value)
		local plr = game.Players.LocalPlayer
		if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
			plr.Character.Humanoid.WalkSpeed = Value
		end
	end,
})

-- ⚡ Instant Interact Toggle
local ProximityPromptService = game:GetService("ProximityPromptService")
local instantInteractEnabled = false

Exploits:CreateToggle({
	Name = "Instant Interact",
	SectionParent = InstantSection,
	CurrentValue = false,
	Flag = "InstantToggle",
	Callback = function(Value)
		instantInteractEnabled = Value
	end,
})

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt, player)
	if instantInteractEnabled then
		fireproximityprompt(prompt)
	end
})
-- 💣 Fling Section
local FlingSection = Exploits:CreateSection("Fling")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local flungPlayers = {}
local selectedTarget = nil

-- 🔁 Function to get player names
local function getPlayerNames()
	local names = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			table.insert(names, p.Name)
		end
	end
	return names
end

-- 👤 Player Dropdown
local PlayerDropdown = Exploits:CreateDropdown({
	Name = "Select Player to Fling",
	Options = getPlayerNames(),
	CurrentOption = "",
	Flag = "FlingTarget",
	SectionParent = FlingSection,
	Callback = function(Option)
		selectedTarget = Option
	end,
})

-- 🔄 Refresh Button
Exploits:CreateButton({
	Name = "Refresh Player List",
	SectionParent = FlingSection,
	Callback = function()
		PlayerDropdown:SetOptions(getPlayerNames())
	end,
})

-- 🚀 Fling Logic
local function flingPlayer(targetName)
	local target = Players:FindFirstChild(targetName)
	if not target or flungPlayers[targetName] then return end

	local Thrust = Instance.new("BodyThrust")
	Thrust.Force = Vector3.new(99999,99999,99999)
	Thrust.Name = "FlingForce"
	Thrust.Parent = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

	coroutine.wrap(function()
		while target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") do
			LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = target.Character.HumanoidRootPart.CFrame
			Thrust.Location = target.Character.HumanoidRootPart.Position
			RunService.Heartbeat:Wait()
		end
	end)()

	flungPlayers[targetName] = true
end

-- 🎯 Fling Selected Button
Exploits:CreateButton({
	Name = "Fling Selected Player",
	SectionParent = FlingSection,
	Callback = function()
		if selectedTarget then
			flingPlayer(selectedTarget)
		end
	end,
})

-- 💥 Fling All Button
Exploits:CreateButton({
	Name = "Fling All Players",
	SectionParent = FlingSection,
	Callback = function()
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				flingPlayer(p.Name)
				task.wait(0.5)
			end
		end
	end,
})
-- 🎯 Aimbot Section
local AimbotSection = Exploits:CreateSection("Aimbot")

local aimbotEnabled = false
local checkTeam = false
local checkAlive = false
local checkForceField = false
local checkWalls = false
local smoothness = 1

-- Main Toggle
Exploits:CreateToggle({
	Name = "Enable Aimbot",
	CurrentValue = false,
	Flag = "EnableAimbot",
	SectionParent = AimbotSection,
	Callback = function(Value)
		aimbotEnabled = Value
	end,
})

-- Checks Section
local ChecksSection = Exploits:CreateSection("Aimbot Checks")

Exploits:CreateToggle({
	Name = "Team Check",
	CurrentValue = false,
	Flag = "AimbotTeamCheck",
	SectionParent = ChecksSection,
	Callback = function(Value)
		checkTeam = Value
	end,
})

Exploits:CreateToggle({
	Name = "Alive Check",
	CurrentValue = false,
	Flag = "AimbotAliveCheck",
	SectionParent = ChecksSection,
	Callback = function(Value)
		checkAlive = Value
	end,
})

Exploits:CreateToggle({
	Name = "ForceField Check",
	CurrentValue = false,
	Flag = "AimbotForcefieldCheck",
	SectionParent = ChecksSection,
	Callback = function(Value)
		checkForceField = Value
	end,
})

Exploits:CreateToggle({
	Name = "Wall Check (Raycast)",
	CurrentValue = false,
	Flag = "AimbotWallCheck",
	SectionParent = ChecksSection,
	Callback = function(Value)
		checkWalls = Value
	end,
})

-- Smoothness Section
local SmoothnessSection = Exploits:CreateSection("Aimbot Smoothness")

Exploits:CreateSlider({
	Name = "Smoothness",
	Range = {1, 25},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 5,
	Flag = "AimbotSmoothness",
	SectionParent = SmoothnessSection,
	Callback = function(Value)
		smoothness = Value
	end,
})
