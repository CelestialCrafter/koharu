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
