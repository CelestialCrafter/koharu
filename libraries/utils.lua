local sides = {"front", "back", "left", "right", "top", "bottom"}
local detectedSide = nil
local modem = nil
local hasRednet = false

function scanForModem()
	for k, v in ipairs(sides) do
		if peripheral.isPresent(v) then
			if peripheral.getType(v) == "modem" then
				detectedSide = v
				hasRednet = true
				modem = peripheral.wrap(v)
				break
			end
		end
	end
end

scanForModem()

function getModem()
	return modem
end

function clear()
	term.clear()
	term.setCursorPos(1, 1)
end