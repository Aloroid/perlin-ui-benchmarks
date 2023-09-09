
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local constants = require(ReplicatedStorage.Shared.constants)
local perlin_image = require(ReplicatedStorage.Shared.perlin_image)
local utility = require(ReplicatedStorage.Shared.utility)

local New = Fusion.New
local Value = Fusion.Value
local Computed = Fusion.Computed
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

return function(parent)

	local image = Value(perlin_image.image)
	local pixel_size = constants.pixel_size

	local connection = RunService.Heartbeat:Connect(function()
		image:set(perlin_image.image)
	end)

	return New "ScreenGui" {

		Parent = parent,

		[Children] = New "Frame" {

			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.one * 0.5,
			
			[Children] = Computed(function()

				local t = {}
				for i = 1, constants.size.X * constants.size.Y do
					local x, y = utility.to_2d(i)

					t[i] = New "Frame" {
						
						Name = `{x}:{y}:{i}`,

						Position = UDim2.fromOffset(pixel_size.X * x, pixel_size.Y * y),
						Size = UDim2.fromOffset(pixel_size.X, pixel_size.Y),

						BackgroundColor3 = Computed(function()
							local value = image:get()[i]
							return Color3.new(value, value, value)
						end)

					}
				end

				return t

			end, Fusion.cleanup)

		},

		[OnEvent "Destroying"] = function()
			connection:Disconnect()
		end

	}

end