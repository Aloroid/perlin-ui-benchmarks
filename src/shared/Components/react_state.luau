local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local constants = require(ReplicatedStorage.Shared.constants)
local perlin_image = require(ReplicatedStorage.Shared.perlin_image)
local utility = require(ReplicatedStorage.Shared.utility)

local Perlin = React.Component:extend("Perlin")

local c = React.createElement

function Perlin:componentWillMount()

	self:setState({
		image = perlin_image.image
	})
	
	self.connection = RunService.Heartbeat:Connect(function()
		self:setState({
			image = perlin_image.image
		})
	end)

end

function Perlin:render()

	local size = constants.size
	local pixel_size = constants.pixel_size

	local t = table.create(size.X * size.Y)

	for i = 1, size.X * size.Y do
		local x, y = utility.to_2d(i)
		local color = self.state.image[i]

		t[i] = c("Frame", {

			Position = UDim2.fromOffset(pixel_size.X * x, pixel_size.Y * y),
			Size = UDim2.fromOffset(pixel_size.X, pixel_size.Y),

			BackgroundColor3 = Color3.new(color, color, color),

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

function Perlin:componentWillUnmount()

	self.connection:Disconnect()
end

return function()

	local root = ReactRoblox.createRoot(Players.LocalPlayer.PlayerGui)
	root:render(c(Perlin))

end