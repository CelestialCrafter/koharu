local windowManager = {}

local parentTerm = term.current()
local w, h = parentTerm.getSize()

-- tProcesses
local processList = {}
local currentProcess = nil

local function resumeProcess(processName, event, ...)
	local process = processList[processName]
	local filter = process.filter
	if filter == nil or filter == event or event == "terminate" then
		local nPreviousProcess = currentProcess
		currentProcess = processName
		term.redirect(process.terminal)
		local ok, result = coroutine.resume(process.co, event, ...)
		process.terminal = term.current()
		if ok then
			process.sFilter = result
		else
			print(result)
		end
		currentProcess = nPreviousProcess
	end
end

local function launchProcess(focusWindow, env, path, ...)
	local args = table.pack(...)
	local nProcess = #processList + 1
	local newProcess = {}
	newProcess.window = window.create(parentTerm, 1, 1, w, h, false)
	newProcess.co = coroutine.create(function()
		os.run(env, path, table.unpack(args, 1, args.n))
	end)
	newProcess.filter = nil
	newProcess.terminal = newProcess.window
	newProcess[nProcess] = newProcess
	if focusWindow then windowManager.selectProcess(nProcess) end
	resumeProcess(nProcess)
	return nProcess
end

function windowManager.selectProcess(newProcessName)
	if currentProcess ~= newProcessName then
		if currentProcess then
			local oldProcess = processList[currentProcess]
			oldProcess.window.setVisible(false)
		end
		currentProcess = newProcessName
		if currentProcess then
			local process = processList[currentProcess]
			process.window.setVisible(true)
		end
	end
end

local function resizeWindows()
	local windowY, windowHeight
	windowY = 1
	windowHeight = h

	for i = 1, #processList do
		local process = processList[i]
		local x, y = process.window.getCursorPos()
		if y > windowHeight then
			process.window.scroll(y - windowHeight)
			process.window.setCursorPos(x, windowHeight)
		end
		process.window.reposition(1, windowY, w, windowHeight)
	end
	bWindowsResized = true
end

function windowManager.launch(focus, env, path, ...)
	local previousTerm = term.current()
	local result = launchProcess(focus, env, path, ...)
	term.redirect(previousTerm)
	return result
end

function windowManager.getCurrentProcess()
	return currentProcess
end

function windowManager.getCount()
	return #processList
end

parentTerm.clear()
setMenuVisible(false)
launchProcess(true, {
	["shell"] = shell,
	["multishell"] = multishell,
}, "/rom/programs/shell.lua")

-- Run processes
while #tProcesses > 0 do
	-- Get the event
	local tEventData = table.pack(os.pullEventRaw())
	local sEvent = tEventData[1]
	if sEvent == "term_resize" then
		-- Resize event
		w, h = parentTerm.getSize()
		resizeWindows()
		redrawMenu()

	elseif sEvent == "char" or sEvent == "key" or sEvent == "key_up" or sEvent == "paste" or sEvent == "terminate" then
		-- Keyboard event
		-- Passthrough to current process
		resumeProcess(nCurrentProcess, table.unpack(tEventData, 1, tEventData.n))
		if cullProcess(nCurrentProcess) then
			setMenuVisible(#tProcesses >= 2)
			redrawMenu()
		end

	elseif sEvent == "mouse_click" then
		-- Click event
		local button, x, y = tEventData[2], tEventData[3], tEventData[4]
		if bShowMenu and y == 1 then
			-- Switch process
			if x == 1 and nScrollPos ~= 1 then
				nScrollPos = nScrollPos - 1
				redrawMenu()
			elseif bScrollRight and x == term.getSize() then
				nScrollPos = nScrollPos + 1
				redrawMenu()
			else
				local tabStart = 1
				if nScrollPos ~= 1 then
					tabStart = 2
				end
				for n = nScrollPos, #tProcesses do
					local tabEnd = tabStart + #tProcesses[n].sTitle + 1
					if x >= tabStart and x <= tabEnd then
						selectProcess(n)
						redrawMenu()
						break
					end
					tabStart = tabEnd + 1
				end
			end
		else
			-- Passthrough to current process
			resumeProcess(nCurrentProcess, sEvent, button, x, bShowMenu and y - 1 or y)
			if cullProcess(nCurrentProcess) then
				setMenuVisible(#tProcesses >= 2)
				redrawMenu()
			end
		end

	elseif sEvent == "mouse_drag" or sEvent == "mouse_up" or sEvent == "mouse_scroll" then
		-- Other mouse event
		local p1, x, y = tEventData[2], tEventData[3], tEventData[4]
		if bShowMenu and sEvent == "mouse_scroll" and y == 1 then
			if p1 == -1 and nScrollPos ~= 1 then
				nScrollPos = nScrollPos - 1
				redrawMenu()
			elseif bScrollRight and p1 == 1 then
				nScrollPos = nScrollPos + 1
				redrawMenu()
			end
		elseif not (bShowMenu and y == 1) then
			-- Passthrough to current process
			resumeProcess(nCurrentProcess, sEvent, p1, x, bShowMenu and y - 1 or y)
			if cullProcess(nCurrentProcess) then
				setMenuVisible(#tProcesses >= 2)
				redrawMenu()
			end
		end

	else
		-- Other event
		-- Passthrough to all processes
		local nLimit = #tProcesses -- Storing this ensures any new things spawned don't get the event
		for n = 1, nLimit do
			resumeProcess(n, table.unpack(tEventData, 1, tEventData.n))
		end
		if cullProcesses() then
			setMenuVisible(#tProcesses >= 2)
			redrawMenu()
		end
	end

	if bWindowsResized then
		-- Pass term_resize to all processes
		local nLimit = #tProcesses -- Storing this ensures any new things spawned don't get the event
		for n = 1, nLimit do
			resumeProcess(n, "term_resize")
		end
		bWindowsResized = false
		if cullProcesses() then
			setMenuVisible(#tProcesses >= 2)
			redrawMenu()
		end
	end
end

-- Shutdown
term.redirect(parentTerm)

return windowManager
