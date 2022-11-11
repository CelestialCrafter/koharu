print('Where do you want to read from?')
local fileName = read()

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
