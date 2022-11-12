local options = require('/libraries/options')

-- @TODO sendfile/command, receivefile/command, gps
local apps = {
	{ '/apps/receiveFile', 'ReceiveFile' },
	{ '/apps/receiveCommand', 'ReceiveCommand' },
	{ '/apps/shutdown', 'Shutdown' },
	{ '/apps/reboot', 'Reboot' },
	{ '/apps/mine', 'Mine (5xInfinityx3)' }
}

options.generateMenu(apps, function(appPath) shell.run(appPath) end, nil, true)
