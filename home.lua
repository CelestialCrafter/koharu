local function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local approvedDevice = updater.deviceIsApproved()

term.clear()
print('Welcome back to Bonfire!')
print('Apps:')
print('-> Chatroom')
print('-> Painting')
print('-> SendFile')
print('-> ReceiveFile')
print('-> Clock')
print('-> Shutdown')
print('-> Reboot')
print('-> Worm')
print('-> Create Password')

if (approvedDevice) then
	print('-> Run Server-Side Updater')
end

local keepUi = true

while (keepUi)
do
	local apps = {'/apps/chatroom', '/apps/painting', '/apps/sendFile', '/apps/receiveFile', '/apps/clock', '/apps/shutdown', '/apps/reboot', '/apps/worm', '/apps/createpassword'}
	local event, button, x, y = os.pullEvent('mouse_click')

	if (apps[y - 3]) then shell.run(apps[y - 3]) end

	if (approvedDevice and y == 13)
		then
			keepUi = false
			shell.run('/internal/updater')
		end
end