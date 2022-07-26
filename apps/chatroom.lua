local options = require('/libraries/options')

local chatOptions = {
	[1] = { 'host', 'Host' },
	[2] = { 'join', 'Join' }
}

local function runChat(choice)
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

options.generateMenu(chatOptions, runChat)
