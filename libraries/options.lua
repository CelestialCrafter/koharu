-- @TODO sendfile/command, receivefile/command, gps, 

function generateMenu(options, select, padding)
	local y = 1
	local keepUi = true
	padding = padding or {'-> ', ' <-'}
	options = {
		{'option1', 'Option 1'},
		{'option2', 'Option 2'},
	}
	optionLength = utils.getTableLength(options)

	while keepUi do
		term.setBackgroundColor(colours.black)
		utils.clear()
		for i, option in ipairs(options) do
			if (y == i) then
				term.setBackgroundColor(colors.white)
				term.setTextColor(colors.black)
			end
			print(padding[1] .. options[i][2] .. padding[2])
			if (y == i) then
				term.setBackgroundColor(colors.black)
				term.setTextColor(colors.white)
			end
		end
		
		local event, key = os.pullEvent('key')

		if key == keys.enter then
			utils.clear()
			keepUi = false
			select(options[y][1])
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