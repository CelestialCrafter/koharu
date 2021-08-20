---@diagnostic disable: undefined-global
local sides = {"front", "back", "left", "right", "top", "bottom"}

local modem = nil

for k, side in ipairs(sides) do
	if peripheral.isPresent(side) then
		if peripheral.getType(side) == "modem" then
			modem = peripheral.wrap(side)
		end
	end
end

modem.transmit(20482, 0, "open_door")