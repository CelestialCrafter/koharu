local prePullEvent = os.pullEvent
os.pullEvent = os.pullEventRaw

local sha256 = require('/libraries/sha256')

if (fs.exists('/files/password'))
then
	local keepPwd = true
	local index = 0
	local passwordFile = fs.open('/files/password', 'r')

	print('Enter Password:')
	while (keepPwd) do
		if (index == 3) then
			print('Too many tries. Shutting down')
			sleep(1)
			shell.run('shutdown')
		end

		local triedPassword = read('*')
		local password = passwordFile.readAll()

		if (password == sha256(triedPassword)) then
			keepPwd = false
		end

		if (not (password == triedPassword)) then
			print('Wrong password')
			index = index + 1
		end
	end

	passwordFile.close()
end

os.pullEvent = prePullEvent
-- shell.run('bg /internal/updater')
shell.run('/home')
