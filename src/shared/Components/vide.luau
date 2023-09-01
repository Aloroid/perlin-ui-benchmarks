local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local vide = require(ReplicatedStorage.Packages.vide)
local constants = require(ReplicatedStorage.Shared.constants)
local perlin_image = require(ReplicatedStorage.Shared.perlin_image)
local utility = require(ReplicatedStorage.Shared.utility)

local create = vide.create
local source = vide.source
local indexes = vide.indexes

return function()

	local image = source(perlin_image.image)
	local pixel_size = constants.pixel_size

	local connection = RunService.Heartbeat:Connect(function()
		image(perlin_image.image)
	end)

	return create "ScreenGui" {

		Parent = Players.LocalPlayer.PlayerGui,

		create "Frame" {

			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.one * 0.5,
			
			indexes(image, function(value, index)

				local x, y = utility.to_2d(index)

				return create "Frame" {
					
					Name = `{x}:{y}:{index}`,

					Position = UDim2.fromOffset(pixel_size.X * x, pixel_size.Y * y),
					Size = UDim2.fromOffset(pixel_size.X, pixel_size.Y),

					BackgroundColor3 = function()
						return Color3.new(value(), value(), value())
					end

				}

			end)

		},

		Destroying = function()
			connection:Disconnect()
		end

	}

end