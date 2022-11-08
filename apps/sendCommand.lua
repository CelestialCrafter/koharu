local utils = require('/libraries/utils')

print('What device ID would you like to commands to?')
local stringIds = utils.split(read(), ' ')
while (true) do
	print('What command would you like to send?')
	write('$ ')
	local command = read()
	for id in tonumber(stringIds) do
		rednet.send(id, command, 'ssh')
	end
end
