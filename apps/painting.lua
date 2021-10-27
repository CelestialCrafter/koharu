print('What should the painting be called?')
local fileName = io.read()
shell.run('paint /appdata/' .. fileName)