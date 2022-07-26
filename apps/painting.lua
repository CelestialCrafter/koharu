print('What should the painting be called?')
local fileName = io.read()
shell.run('paint /files/' .. fileName)
