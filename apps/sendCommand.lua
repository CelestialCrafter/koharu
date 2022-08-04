local utils = require('/libraries/utils')

print('What device ID would you like to commands to?')
local stringIds = utils.split(read(), ' ')
for id in tonumber(stringIds) do
	print('What command would you like to send?')
	while (true) do
		write('$ ')
		local command = read()
		rednet.send(id, command, 'ssh')
	end
end
