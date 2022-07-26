print('What file would you like to send?')
local fileName = io.read();
print('What device ID would you like to send it to?')
local id = io.read('n');

local file = fs.open(fileName, 'r')
local data = file.readAll()
file.close()
rednet.send(id, { name = file, data = data }, 'ftp')
