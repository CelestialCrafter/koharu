local utils = require('/libraries/utils')

print('What device ID would you like to commands to?')
local stringIds = utils.split(read(), ' ')
while (true) do
	print('What command would you like to send?')
	write('$ ')
	local command = read()
	for k, id in pairs(stringIds) do
		id = tonumber(id)
		rednet.send(id, command, 'ssh')
	end
end
