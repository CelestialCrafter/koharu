local sha256 = require('/libraries/sha256')
local utils = require('/libraries/utils')

local function createPassword()
	print('Enter Password:')
	local password = read('*')

	print('Please re-enter the Password:')
	local confirmedPassword = read('*')

	if (password == confirmedPassword) then
		local passwordFile = fs.open('/internal/password', 'w')
		passwordFile.write(sha256(password))
		passwordFile.close()
	else
		print('Passwords do not match. Please retry')
		sleep(1)
		utils.clear()
		createPassword()
	end
end

createPassword()
