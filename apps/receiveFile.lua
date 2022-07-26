local utils = require('/libraries/utils')

local function acceptFile(data)
	local file = fs.open(data.name, 'w')
	file.write(data.data)
	file.close()
	print('File Accepted')
end

while (true) do
	local id, data = rednet.receive('ftp')

	if (not utils.hasValue(require('/files/authorizedMachines'), id)) then
		print('Recieved file from machine ' .. id .. ' named ' .. data.name .. ' Accept? (y/n)')
		local confirmation = read()
		if (confirmation == 'y') then acceptFile(data)
		else print('File Denied') end
	else
		print('Accepting file ' .. data.name .. 'from machine ' .. id)
		acceptFile(data)
	end
end
