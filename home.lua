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

while keepUi do
	term.setBackgroundColor(colours.black)
	utils.clear()
	for i, app in ipairs(apps) do
    if (y == i) then
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
		end
		print('-> ' .. app[2] .. ' <-')
    if (y == i) then
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
		end
	end
	
	local event, key = os.pullEvent('key')

	if key == keys.enter then
		utils.clear()
		keepUi = false
		shell.run(apps[y][1])
	elseif key == keys.up then
		if y > 1 then
			y = y - 1
		elseif y == 1 then
			y = appsLength
		end
	elseif key == keys.down then
		if y < appsLength then
			y = y + 1
		elseif y == appsLength then
			y = 1
		end
	end
end