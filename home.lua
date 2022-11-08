local options = require('/libraries/options')

-- @TODO sendfile/command, receivefile/command, gps
local apps = {
	{ '/apps/chatroom', 'Chatroom' },
	{ '/apps/painting', 'Painting' },
	{ '/apps/sendFile', 'SendFile' },
	{ '/apps/receiveFile', 'ReceiveFile' },
	{ '/apps/sendCommand', 'SendCommand' },
	{ '/apps/receiveCommand', 'ReceiveCommand' },
	{ '/apps/shutdown', 'Shutdown' },
	{ '/apps/reboot', 'Reboot' },
	{ '/apps/createpassword', 'Create Password' }
}

if turtle then
	local turtleApps = {
		'/apps/mine', 'Mine (5xInfinityx3)'
	}

	for _, app in ipairs(turtleApps) do
		table.insert(apps, app)
	end
end

options.generateMenu(apps, function(appPath) shell.run(appPath) end, nil, true)
