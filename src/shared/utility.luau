local constants = require(script.Parent.constants)

local size_x = constants.size.X

local function to_1d(x: number, y: number)
	return (x - 1) + (y - 1) * size_x + 1
end

local function to_2d(i: number)
	i -= 1
	local x = i % size_x

	return x, (i - x) / size_x
end

return {
	to_1d = to_1d,
	to_2d = to_2d
}