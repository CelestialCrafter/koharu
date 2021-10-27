local y = 1
local keepUi = true
local optionsLength = 2
local options = {
	[1] = {'host', 'Host'},
	[2] = {'join', 'Join'}
}

function runChat(choice)
	if (choice == 'host') then
			print('What should the chatroom be called?')
			local name = io.read()
			shell.run('chat host ' .. name)
	else
		print('What chatroom do you want to join?')
		local room = io.read()
		print('What should you be called?')
		local name = io.read()
		shell.run('chat join ' .. room .. ' ' .. name)
	end
end

while keepUi do
	term.setBackgroundColor(colours.black)
	utils.clear()
	for i, app in ipairs(apps) do
    if (y == i) then
			term.setBackgroundColor(colors.white)
			term.setTextColor(colors.black)
		end
		print('-> ' .. options[2] .. ' <-')
    if (y == i) then
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
		end
	end
	
	local event, key = os.pullEvent('key')

	if key == keys.enter then
		utils.clear()
		keepUi = false
		runChat(options[y][1])
	elseif key == keys.up then
		if y > 1 then
			y = y - 1
		elseif y == 1 then
			y = optionsLength
		end
	elseif key == keys.down then
		if y < optionsLength then
			y = y + 1
		elseif y == optionsLength then
			y = 1
		end
	end
end