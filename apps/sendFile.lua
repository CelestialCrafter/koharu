print('What file would you like to send?')
local fileName = io.read()
print('What device ID would you like to send it to?')
local id = io.read()

local file = fs.open(fileName, 'r')
if (not file) then
	print('That file does not exist!')
else
	local data = file.readAll()
	file.close()
	rednet.send(id, { name = file, data = data }, 'ftp')
end
