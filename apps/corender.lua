local utils = require('/libraries/utils')

local file = fs.open('files/animations', 'r')

local function split(tbl)
	local t1, t2 = {}, {}
	local state = true
	for k, v in pairs(tbl) do
		(state and t1 or t2)[k] = v
		state = not state
	end
	return t1, t2
end

if (not file) then
	print('You need an animations index!')
else
	local images = utils.split(file.readAll(), '\n')
	file.close()

	local originalTerm = term.current()
	local monitor = peripheral.wrap('left')
	monitor.setTextScale(0.5)

	local parsedImages = {}

	for _, fileName in pairs(images) do
		local parsed = paintutils.loadImage(fileName)
		local nimg, _ = split(parsed)
		table.insert(parsedImages, nimg)
	end

	term.redirect(monitor)

	while true do
		for _, image in pairs(parsedImages) do
			os.pullEvent('redstone')
			monitor.setBackgroundColor(colors.black)
			monitor.clear()
			local x, y = monitor.getSize()

			paintutils.drawImage(image, 1, y / 2)
		end
	end

	term.redirect(originalTerm)
end
