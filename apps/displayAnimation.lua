local utils = require('/libraries/utils')

local file = fs.open('files/animations', 'r')

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
		table.insert(parsedImages, paintutils.loadImage(fileName))
	end

	term.redirect(monitor)

	while True do
		for _, image in pairs(parsedImages) do
			monitor.setBackgroundColor(colors.black)
			monitor.clear()

			paintutils.drawImage(image, 1, 1)
			utils.sleep(200)
		end
	end

	term.redirect(originalTerm)
end
