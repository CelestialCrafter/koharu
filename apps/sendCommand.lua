print('What device ID would you like to commands to?')
local id = tonumber(read())

while (true) do
	print('What command would you like to send?')
	write('$ ')
	local command = read()
	rednet.send(id, command, 'ssh')
end
