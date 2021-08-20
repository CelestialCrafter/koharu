local function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function deviceIsApproved()
	local approvedDevices = {}
	local deviceId = os.getComputerID()

	return hasValue(approvedDevices, deviceId)
end

local sides = {"front", "back", "left", "right", "top", "bottom"}

local modem = nil

for k, side in ipairs(sides) do
	if peripheral.isPresent(side) then
		if peripheral.getType(side) == "modem" then
			modem = peripheral.wrap(side)
		end
	end
end

modem.open(20482)

---@diagnostic disable-next-line: undefined-field
local event, modemSide, senderChannel, replyChannel, message = os.pullEvent("modem_message")

print(senderChannel)