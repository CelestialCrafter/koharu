local utils = {
	detectedSide = nil,
	hasRednet = false
}
local sides = { "front", "back", "left", "right", "top", "bottom" }
local modem = nil

function utils.scanForModem()
	for k, v in ipairs(sides) do
		if peripheral.isPresent(v) then
			if peripheral.getType(v) == 'modem' then
				utils.detectedSide = v
				utils.hasRednet = true
				modem = peripheral.wrap(v)
				break
			end
		end
	end
end

function utils.getModem()
	return modem
end

function utils.openRednet()
	return rednet.open(modem)
end

function utils.getTableLength(tableTg)
	local length = 0
	for k, v in pairs(tableTg) do
		length = length + 1
	end
	return length
end

function utils.hasValue(tab, val)
	for i, v in ipairs(tab) do
		if v == val then
			return true
		end
	end

	return false
end

function utils.fileExists(name)
	local f = io.open(name, 'r')
	if f ~= nil then io.close(f) return true else return false end
end

function utils.clear()
	term.clear()
	term.setCursorPos(1, 1)
end

function utils.filterTable(table, filterFunction)
	local output = {}

	for k, v in pairs(table) do
		if filterFunction(v, k, table) then table.insert(output, v) end
	end

	return output
end

utils.scanForModem()

return utils
