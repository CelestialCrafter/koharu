local y = 1
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

while true do
	-- Draw a white space at the current x/y co-ord:
	term.setBackgroundColor(colours.black)
	clear()
	for i, app in pairs(apps) do
    if (y == i) term.setBackgroundColor(colors.white)
		print('-> ' .. app[2] .. ' <-')
    if (y == i) term.setBackgroundColor(colors.black)
	end
	
	local event, key = os.pullEvent("key")
	
	if key == keys.up && y > 1 then
		y = y - 1
	else if key == keys.down && y < appsLength then
		y = y + 1
	end
end