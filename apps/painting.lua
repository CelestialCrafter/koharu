print('What should the painting be called?')
local fileName = read()
shell.run('paint /files/' .. fileName)
