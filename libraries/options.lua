-- @TODO sendfile/command, receivefile/command, gps,
local utils = require('/libraries/utils')
local options = {}

function options.generateMenu(options, select, padding, persist)
	local y = 1
	persist = persist or false
	padding = padding or { '-> ', ' <-' }
	options = options or {
		{ 'option1', 'Option 1' },
		{ 'option2', 'Option 2' }
	}
	local optionsLength = utils.getTableLength(options)

	while true do
		term.setBackgroundColor(colors.black)
		utils.clear()
		for i, option in ipairs(options) do
			if (y == i) then
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
			end
			print(padding[1] .. option[2] .. padding[2])
			if (y == i) then
				term.setBackgroundColor(colors.black)
				term.setTextColor(colors.white)
			end
		end

		local event, key = os.pullEvent('key')

		if key == keys.enter then
			utils.clear()
			if (not persist) then break end
			select(options[y][1])
			break
		elseif key == keys.up then
			if y > 1 then
				y = y - 1
			elseif y == 1 then
				y = optionsLength
			end
		elseif key == keys.down then
			if y < optionsLength then
				y = y + 1
			elseif y == optionsLength then
				y = 1
			end
		end
	end
end

return options
