

local RunService = game:GetService("RunService")

local TOTAL = 100
local results = {}

return function()

	local screen_gui = Instance.new("ScreenGui")
	screen_gui.Name = "fps"

	local frame = Instance.new("TextLabel")
	frame.AutomaticSize = Enum.AutomaticSize.XY
	frame.Position = UDim2.fromScale(0.5, 1)
	frame.AnchorPoint = Vector2.new(0.5, 1)
	frame.BackgroundTransparency = 1

	frame.Font = Enum.Font.SourceSansBold
	frame.TextSize = 24
	frame.TextColor3 = Color3.new(1, 1, 1)
	frame.Text = ""
	
	local connection = RunService.Heartbeat:Connect(function(dt)
		table.remove(results, TOTAL)
		table.insert(results, 1, dt)

		local average = 0
		for _, result in results do
			average += result
		end

		frame.Text = string.format("%.3g", average / TOTAL)
	end)

	frame.Parent = screen_gui
	screen_gui.Parent = game:GetService("Players").LocalPlayer.PlayerGui

	screen_gui.Destroying:Connect(function()
		print("destroying")
		connection:Disconnect()
	end)


end