local backgroundColor = term.getBackgroundColor()
local textColor = term.getTextColor()

function hideText
	term.setTextColor(backgroundColor)
end

function showText
	term.setTextColor(textColor);
end