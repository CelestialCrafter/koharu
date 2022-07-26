print('What file would you like to send?')
local fileName = read()

local file = fs.open(fileName, 'r')
if (not file) then
	print('That file does not exist!')
else
	print('What device ID would you like to send it to?')
	local id = tonumber(read())
	local data = file.readAll()
	file.close()
	rednet.send(id, { name = fileName, data = data }, 'ftp')
end
