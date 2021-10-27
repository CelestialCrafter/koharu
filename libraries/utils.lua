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

function getModem()
	return modem
end

function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function fileExists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function clear()
	term.clear()
	term.setCursorPos(1, 1)
end

scanForModem()
