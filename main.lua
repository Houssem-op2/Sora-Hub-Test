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
		Note = "🎁 Get your key by clicking the button below.",
		FileName = "Sora-Hub",
		SaveKey = false,
		GrabKeyFromSite = true,
		Key = "https://loot-link.com/s?0raUATlv"-- Lootlink pastebin key
	}
})

-- 🏠 Home Tab
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
end)
