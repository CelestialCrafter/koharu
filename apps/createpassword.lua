local textvis = require('/libraries/textvis')
local sha256 = require('/libraries/sha256')
local utils = require('/libraries/utils')

local function createPassword()
	print('Enter Password:')
	textvis.hideText()
	local password = io.read()
	textvis.showText()

	print('Please re-enter the Password:')
	textvis.hideText()
	local confirmedPassword = io.read()
	textvis.showText()

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
