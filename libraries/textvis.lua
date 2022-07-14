local backgroundColor = term.getBackgroundColor()
local textColor = term.getTextColor()

local function hideText()
	term.setTextColor(backgroundColor)
end

local function showText()
	term.setTextColor(textColor)
end

return { hideText = hideText, showText = showText }