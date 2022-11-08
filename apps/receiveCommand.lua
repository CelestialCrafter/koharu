local utils = require('/libraries/utils')

while (true) do
	local id, command = rednet.receive('ssh')

	if (not utils.hasValue(require('/files/authorizedMachines'), id)) then
		print('Recieved command from machine ' .. id .. ' Accept? (y/n)')
		print('Command: ' .. command)
		local confirmation = read()
		if (confirmation == 'y') then shell.run(command)
		else print('File Denied') end
	else
		print('Accepting command from machine ' .. id)
		print('Command: ' .. command)
		shell.run(command)
	end
end
