local utils = require('/libraries/utils')

local currentTurn = false
turtle.turnRight()

local function refuel()
	local fuelLimit = turtle.getFuelLimit()
	if turtle.getFuelLevel() < fuelLimit / 16 then
		turtle.refuel(10)
	end
end

local i = -1

while true do
	i = i + 1
	for i = 1, 16 do
		refuel()
		local item = turtle.getItemDetail(i)
		local blacklistedItems = { 'minecraft:dirt', 'minecraft:cobblestone', 'minecraft:cobbled_deepslate', 'minecraft:tuff',
			'minecraft:gravel',
			'minecraft:flint' }
		if not (item == nil) then
			if (i / 5) - math.abs(i / 5) == 0 and item.name == 'minecraft:torch' then
				turtle.select(i)
				turtle.placeDown()
			end
			if utils.hasValue(blacklistedItems, item.name) then
				turtle.select(i)
				turtle.drop(64)
			end
		end
	end
	turtle.select(1)

	currentTurn = not currentTurn

	for i = 1, 5, 1 do
		turtle.digUp()
		turtle.dig()
		turtle.forward()

	end

	if not currentTurn then
		turtle.turnRight()
		turtle.digUp()
		turtle.dig()
		turtle.digDown()
		turtle.forward()
		turtle.turnRight()
	else
		turtle.turnLeft()
		turtle.digUp()
		turtle.dig()
		turtle.digDown()
		turtle.forward()
		turtle.turnLeft()
	end
end
