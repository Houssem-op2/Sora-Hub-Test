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
