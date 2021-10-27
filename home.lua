-- @TODO sendfile/command, receivefile/command, gps, 

local y = 1
local keepUi = true
local appsLength = 8
local apps = {
	[1] = {'/apps/chatroom', 'Chatroom'},
	[2] = {'/apps/painting', 'Painting'},
	[3] = {'/apps/sendFile', 'SendFile'},
	[4] = {'/apps/receiveFile', 'ReceiveFile'},
	[5] = {'/apps/shutdown', 'Shutdown'},
	[6] = {'/apps/reboot', 'Reboot'},
	[7] = {'/apps/worm', 'Worm'},
	[8] = {'/apps/createpassword', 'Create Password'}
}

options.generateMenu(apps, function () shell.run(apps[y][1]) end)