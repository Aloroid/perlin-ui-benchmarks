
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local constants = require(ReplicatedStorage.Shared.constants)
local perlin_image = require(ReplicatedStorage.Shared.perlin_image)
local utility = require(ReplicatedStorage.Shared.utility)

return function(parent)

	local pixel_size = constants.pixel_size
	local pixels = {}
	
	local screen_gui = Instance.new("ScreenGui")
	
	local frame = Instance.new("Frame")
	frame.AutomaticSize = Enum.AutomaticSize.XY
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.AnchorPoint = Vector2.one * 0.5

	frame.BorderSizePixel = 0

	for i = 1, constants.size.X * constants.size.Y do
		
		local x, y = utility.to_2d(i)

		local pixel = Instance.new("Frame")
		
		pixel.Name = `{x}:{y}:{i}`
		pixel.Position = UDim2.fromOffset(pixel_size.X * x, pixel_size.Y * y)
		pixel.Size = UDim2.fromOffset(pixel_size.X, pixel_size.Y)
		pixel.BorderSizePixel = 0

		pixel.Parent = frame

		pixels[i] = pixel

	end

	local connection = RunService.Heartbeat:Connect(function()
		for i, value in perlin_image.image do
			local pixel = pixels[i]
			pixel.BackgroundColor3 = Color3.new(value, value, value)
		end
	end)

	frame.Parent = screen_gui
	screen_gui.Parent = parent

	screen_gui.Destroying:Connect(function()
		connection:Disconnect()
	end)

end