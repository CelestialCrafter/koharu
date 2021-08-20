-- I know its not a good way to store files but i dont feel like making reliable code rn
shell.run('paint /appdata/' .. sha256.sha256(math.random(1, 100000000)))