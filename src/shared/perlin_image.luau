--!native
--!optimize 2
--[[

	This updates a perlin noise image.

]]

local RunService = game:GetService("RunService")

local constants = require(script.Parent.constants)
local utility = require(script.Parent.utility)

local to_1d = utility.to_1d

local module = {}
local image = {}

local z = 0

local function update()

	z += 1

	image = table.create(constants.size.X * constants.size.Y)

	for x = 1, constants.size.X do
		for y = 1, constants.size.Y do
			image[to_1d(x, y)] = math.noise(x / 30, y / 30, z / 60) + 0.5
		end
	end

	module.image = image

end

update()
RunService.Heartbeat:Connect(update)

return module