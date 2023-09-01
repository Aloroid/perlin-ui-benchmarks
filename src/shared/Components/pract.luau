local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Pract = require(ReplicatedStorage.Packages.Pract)
local constants = require(ReplicatedStorage.Shared.constants)
local perlin_image = require(ReplicatedStorage.Shared.perlin_image)
local utility = require(ReplicatedStorage.Shared.utility)

local function render()
	local value, setValue = Pract.useStateTyped(perlin_image.image)

	Pract.useEffect(function()
		local connection = RunService.Heartbeat:Connect(function()
			setValue(perlin_image.image)
		end)

		return function()
			connection:Disconnect()
		end
	end)

	local size = constants.size
	local pixel_size = constants.pixel_size

	local t = table.create(size.X * size.Y)

	for i = 1, size.X * size.Y do
		local x, y = utility.to_2d(i)
		local color = value[i]

		t[i] = Pract.create("Frame", {

			Position = UDim2.fromOffset(pixel_size.X * x, pixel_size.Y * y),
			Size = UDim2.fromOffset(pixel_size.X, pixel_size.Y),

			BackgroundColor3 = Color3.new(color, color, color),

			BorderSizePixel = 0

		})

	end

	return Pract.create("ScreenGui", {}, {

		Pract.create("Frame", {
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.one * 0.5,

			BorderSizePixel = 0

		}, t)

	})

end

return function()

	Pract.mount(Pract.create(render), Players.LocalPlayer.PlayerGui)

end