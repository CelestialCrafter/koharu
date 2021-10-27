prePullEvent = os.pullEvent
os.pullEvent = os.pullEventRaw

os.loadAPI("/libraries/sha256.lua")
os.loadAPI("/libraries/textvis.lua")
os.loadAPI("/libraries/base64.lua")
os.loadAPI("/libraries/options.lua")
os.loadAPI("/libraries/utils.lua")
os.loadAPI("/internal/updater.lua")

if (fs.exists('/appdata/password'))
then
	local keepPwd = true
	local index = 0
	local passwordFile = fs.open('/appdata/password', 'r')

	print('Enter Password:')
	while (keepPwd) do
		if (index == 3) then
			textvis.showText()
			print('Too many tries. Shutting down')
			sleep(1)
			shell.run('shutdown')
		end

		textvis.hideText()
		local triedPassword = io.read()
		local password = passwordFile.readAll()

		if (password == sha256.sha256(triedPassword)) then
			keepPwd = false
		end

		if (not (password == triedPassword)) then
			textvis.showText()
			print('Wrong password')
			index = index + 1
		end
	end

	passwordFile.close()
end

os.pullEvent = prePullEvent
shell.run('bg /internal/updater')
shell.run('/home')
	