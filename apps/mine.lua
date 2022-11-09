local utils = require('/libraries/utils')

local currentTurn = false
turtle.turnRight()

local function refuel()
	local fuelLimit = turtle.getFuelLimit()
	if turtle.getFuelLevel() < fuelLimit / 16 then
		turtle.refuel(10)
	end
end

local j = 0
while true do
	j = j + 1
	for i = 1, 16 do
		refuel()
		local item = turtle.getItemDetail(i)
		local blacklistedItems = { 'minecraft:dirt', 'minecraft:cobblestone', 'minecraft:cobbled_deepslate', 'minecraft:tuff',
			'minecraft:gravel',
			'minecraft:flint' }
		if not (item == nil) then
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
		turtle.digDown()
		turtle.dig()
		turtle.forward()
	end

	if currentTurn then
		turtle.turnLeft()
	else
		turtle.turnRight()
	end

	turtle.digUp()
	turtle.dig()
	turtle.digDown()

	for i = 1, 16 do
		local item = turtle.getItemDetail(i)
		if not (item == nil) then
			if j % 5 == 0 and item.name == 'minecraft:torch' then
				turtle.select(i)
				turtle.placeDown()
			end
		end
	end

	turtle.forward()

	if currentTurn then
		turtle.turnLeft()
	else
		turtle.turnRight()
	end
end
