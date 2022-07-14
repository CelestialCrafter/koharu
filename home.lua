local options = require('libraries.options')

-- @TODO sendfile/command, receivefile/command, gps
local apps = {
	{'/apps/chatroom', 'Chatroom'},
	{'/apps/painting', 'Painting'},
	{'/apps/sendFile', 'SendFile'},
	{'/apps/receiveFile', 'ReceiveFile'},
	{'/apps/shutdown', 'Shutdown'},
	{'/apps/reboot', 'Reboot'},
	{'/apps/worm', 'Worm'},
	{'/apps/createpassword', 'Create Password'}
}

options.generateMenu(apps, function (appPath) shell.run(appPath) end)