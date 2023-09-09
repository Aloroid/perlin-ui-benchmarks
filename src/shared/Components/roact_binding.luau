
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Roact = require(ReplicatedStorage.Packages.Roact)
local constants = require(ReplicatedStorage.Shared.constants)
local perlin_image = require(ReplicatedStorage.Shared.perlin_image)
local utility = require(ReplicatedStorage.Shared.utility)

local Perlin = Roact.Component:extend("Perlin")

local c = Roact.createElement

function Perlin:init()

	local value, set = Roact.createBinding(perlin_image.image)
	self.value = value

	self.connection = RunService.Heartbeat:Connect(function()
		set(perlin_image.image)
	end)

end

function Perlin:render()

	local size = constants.size
	local pixel_size = constants.pixel_size

	local t = table.create(size.X * size.Y)

	for i = 1, size.X * size.Y do
		local x, y = utility.to_2d(i)

		t[i] = c("Frame", {

			Position = UDim2.fromOffset(pixel_size.X * x, pixel_size.Y * y),
			Size = UDim2.fromOffset(pixel_size.X, pixel_size.Y),

			BackgroundColor3 = self.value:map(function(value)
				return Color3.new(value[i], value[i], value[i])
			end),

			BorderSizePixel = 0

		})

	end


	return c("ScreenGui", {}, {

		c("Frame", {
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.one * 0.5,

			BorderSizePixel = 0

		}, t)

	})

end

function Perlin:unmount()

	self.connection:Disconnect()
end

return function(parent)

	Roact.mount(c(Perlin), parent)

end