local fileName = ''
local file = fs.open('files/defaultImage', 'r')

if (not file) then
	print('Where do you want to read from?')
	fileName = read()
else
	fileName = file.readAll()
	file.close()
end

local image = paintutils.loadImage(fileName)
local monitor = peripheral.wrap('left')
monitor.setBackgroundColor(colors.black)
monitor.clear()
monitor.setTextScale(0.5)

local function renderImage()
	monitor.setBackgroundColor(colors.black)
	monitor.clear()
	local originalTerm = term.current()
	term.redirect(monitor)

	paintutils.drawImage(image, 1, 1)

	term.redirect(originalTerm)
end

renderImage()
