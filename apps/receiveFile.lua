while (true) do
	local id, data = rednet.receive('ftp')
	print('Recieved file from machine ' .. id .. ' named' .. data.name .. ' Accept? (y/n)')
	local confirmation = io.read()
	if (confirmation == 'y') then
		local file = fs.open(data.name, 'w')
		file.write(data.data)
		file.close()
	else
		print('File Denied')
	end
end
