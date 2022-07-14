print("Are you sure you want to install? (THIS WILL WIPE YOUR DRIVE) [y/n]")
local confirmation = io.read()
local drive = ...

if (confirmation == "y") then
	shell.run("rm /" .. drive .. "/*")
	shell.run("cp ./* /" .. drive)
	print("Installation completed!")
else
	print("Installation stopped.")
end
