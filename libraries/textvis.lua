local textvis = {}

function textvis.hideText()
	local backgroundColor = term.getBackgroundColor()
	term.setTextColor(backgroundColor)
end

function textvis.showText()
	local textColor = term.getTextColor()
	term.setTextColor(textColor)
end

return textvis
