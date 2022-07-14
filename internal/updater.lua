local utils = require('libraries.utils')

local function deviceIsApproved()
	local approvedDevices = {}
	local deviceId = os.getComputerID()

	return utils.hasValue(approvedDevices, deviceId)
end

return { deviceIsApproved = deviceIsApproved }