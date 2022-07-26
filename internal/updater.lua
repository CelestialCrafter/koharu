local utils = require('/libraries/utils')
local updater = {}

function updater.deviceIsApproved()
	local approvedDevices = {}
	local deviceId = os.getComputerID()

	return utils.hasValue(approvedDevices, deviceId)
end

return updater
