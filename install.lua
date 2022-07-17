local json = require('json')

local function save(data, file)
	local file = shell.resolve(file:gsub("%%20", " "))
	if not
			(
			fs.exists(string.sub(file, 1, #file - #fs.getName(file))) and fs.isDir(string.sub(file, 1, #file - #fs.getName(file)))
			) then
		if fs.exists(string.sub(file, 1, #file - #fs.getName(file))) then fs.delete(string.sub(file, 1,
				#file - #fs.getName(file)))
		end
		fs.makeDir(string.sub(file, 1, #file - #fs.getName(file)))
	end
	local f = fs.open(file, "w")
	f.write(data)
	f.close()
end

local function install(user, repo, branch, path)
	local data = json.decode(http.get('https://api.github.com/repos/' ..
		user .. '/' .. repo .. '/git/trees/' .. branch .. '?recursive=1').readAll())
	if data.message and data.message:find('API rate limit exceeded') then error('Out of API calls, try again later') end
	if data.message and data.message == 'Not found' then error('Invalid repository', 2) else
		for k, v in pairs(data.tree) do
			if v.type == "tree" then
				fs.makeDir(fs.combine(path, v.path))
			end
		end
		local filecount = 0
		local downloaded = 0
		local paths = {}
		local failed = {}
		for k, v in pairs(data.tree) do
			if v.type == "blob" then
				v.path = v.path:gsub("%s", "%%20")
				local url = 'https://raw.github.com/' .. user .. '/' .. repo .. '/' .. branch .. '/' .. v.path
				http.request(url)
				paths[url] = fs.combine(path, v.path)
				filecount = filecount + 1
			end
		end
		while downloaded < filecount do
			local e, a, b = os.pullEvent()
			if e == 'http_success' then
				save(b.readAll(), paths[a])
				downloaded = downloaded + 1
			elseif e == 'http_failure' then
				-- Retry in 3 seconds
				failed[os.startTimer(3)] = a
			elseif e == 'timer' and failed[a] then
				http.request(failed[a])
			end
		end
	end
end

print('Are you sure you want to install? (THIS WILL WIPE YOUR DRIVE) [y/n]')
local confirmation = io.read()
local drive = ...

if (confirmation == 'y') then
	install('CelestialCrafter', 'bonfire', 'master', drive)
	print('Installation completed!')
else
	print('Installation stopped.')
end
