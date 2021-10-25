print("Are you sure you want to install? (THIS WILL WIPE YOUR DRIVE) [y/n]")
local confirmation = io.read()

if (confirmation == "y") then
	shell.run("rm /" .. arg[1] .. "/*")
	shell.run("mv ./* /" .. arg[1])
	print("Installation completed!")
else
	print("Installation stopped.")
end
