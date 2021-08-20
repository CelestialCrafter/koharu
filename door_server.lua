---@diagnostic disable: undefined-global
local sides = {"front", "back", "left", "right", "top", "bottom"}

local modem = nil

for k, side in ipairs(sides) do
	if peripheral.isPresent(side) then
		if peripheral.getType(side) == "modem" then
			modem = peripheral.wrap(side)
		end
	end
end

modem.open(20482)

---@diagnostic disable-next-line: undefined-field
local event, modemSide, senderChannel, replyChannel, message = os.pullEvent("modem_message")

if message == "open_door" then
	
end