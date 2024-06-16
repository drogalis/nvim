# Comment

N - gcc - line comment
N - gcb - block comment
N - gcO - comment on line above
N - gco - comment on line below
V - gc - line comment
V - gb - block comment

# Compiler Explorer

maybe c

:CECompile Compile the source code in the current buffer and dump assembly output to a new window. Also accepts a visual selection. source code buffer
:CECompileLive Same as :CECompile, ut it will also try to recompile the source code every time the buffer is saved. source code buffer
:CEFormat Format the source code. source code buffer
:CEAddLibrary Add a library to be used by future calls of :CECompile. source code buffer
:CELoadExample Load an existing code example to a new tab. any buffer
:CEOpenWebsite Open the website using the source code and compilers from previous :CECompile calls. any buffer
:CEDeleteCache Clear the json cache where the compilers and languages are stored. any buffer
:CEShowTooltip Show information about a specific instruction under cursor. assembly buffer
:CEGotoLabel Jump to the label definition under cursor. assembly buffer

# Conform

N / V - <leader>mp - format code

# Coverage

N - <leader>vl - load and display coverage
N - <leader>vs - code coverage summary
N - <leader>vt - toggle code coverage

# Dadbod
N - <leader>Dt - toggle UI
N - <leader>Df - find buffer
N - <leader>Dr - rename buffer
N - <leader>Dq - last query info

# Flash
N / V - s - jump to target
N / V - S - jump to Treesitter object
N - r - remote to target
N - R - remote to Treesitter object
N - <C-s> - toggle flash menu

# GitSigns

N - <leader>i[ - previous hunk
N - <leader>i] - next hunk
N / V - <leader>is - stage hunk
N / V - <leader>ir - reset hunk
N - <leader>iS - stage buffer
N - <leader>iR - reset buffer
N - <leader>iu - undo stage hunk
N - <leader>ip - preview hunk
N - <leader>ib - blame line
N - <leader>iB - toggle current line blame
N - <leader>id - diff against last commit
N - <leader>iD - diff against last commit (~1)
N - <leader>itd - toggle word diff
N - <leader>ix - toggle deleted

# Glance

N - gD - glance definition
N - gR - glance references
N - gY - glance type definition
N - gM - glance implementations

# Auto Cmp

N - <Tab> - select
N - <C-q> - next item
N - <C-w> - previous item
N - <C-e> - abort

# LSP Neovim

N - <leader>lR - show LSP references
N - <leader>lD - go to declaration
N - <leader>ld - show LSP definitions
N - <leader>li - LSP implementations
N - <leader>lt - LSP type definitions
N / V - <leader>la - see all available code actions
N - <leader>lrn - smart rename
N - <leader>ldd - show line diagnostic
N - <leader>lpd - previous diagnostic
N - <leader>lnd - next diagnostic
N - K - show documentation for what is under cursor
N - <leader>lrs - restart LSP

# UndoTree

N - <leader><F5> - toggle undo tree

# Trouble

N - <leader>xx - document diagnostics
N - <leader>xp - toggle trouble
N - <leader>xw - workspace diagnostics
N - <leader>xl - location list
N - <leader>xq - quickfix
N - gR - show LSP references

# Treesitter

N - <leader>nc - next class
N - <leader>nf - next function
N - <leader>np - next parameter
N - <leader>pf - prev function
N - <leader>pc - prev class
N - <leader>pp - prev parameter

# Tmux

N - <C-h> - navigate left
N - <C-j> - navigate down
N - <C-k> - navigate up
N - <C-l> - navigate right

# Telescope

N - <leader>sf - find files
N - <leader>sg - live grep
N - <leader>so - old files
N - <leader>st - git files

# Tagbar

N - <F4> - toggle tagbar

# Spelunker

N - ZL - correct all word in buffer
N - Zl - correct word under cursor
N - ZC - correct all word in buffer by insertion
N - Zc - correct word under cursor by insertion
N - ZF / Zf - dont use this command
N - Zg / Zw / Zug / Zuw - add word to spell file
N - ZG ZW ZUG ZUW - add word to internal word list
N - ZN / ZP - jump to next misspelled word
N - ZT / Zt - toggle spellchecker

# Nvim Tree

N - <leader>e - toggle tree
N - <leader>ef - open current file in tree
N - <leader>er - refresh tree

# Neotest

N - <leader>yr - run tests
N - <leader>ys - stop tests
N - <leader>yo - open tests
N - <leader>yt - toggle tests

# Neogen

N - <leader>com - comment function

# Lint

N - <leader>b - try linting

# Lazy Git

N - <leader>lg - open lazy git

# Harpoon

N - <leader>HP - harpoon menu
N - <leader>1 - harpoon to file
N - <leader>2 - harpoon to file
N - <leader>3 - harpoon to file
N - <leader>4 - harpoon to file
N - <leader>5 - harpoon to file
N - <leader>hp1 - set harpon for file
N - <leader>hp2 - set harpon for file
N - <leader>hp3 - set harpon for file
N - <leader>hp4 - set harpon for file
N - <leader>hp5 - set harpon for file

# Dap UI

N - <leader>dt - toggle breakpoint
N - <leader>dc - dap continue

# Vim Illuminate
You'll also get <a-n> and <a-p> as keymaps to move between references
<a-i> as a textobject for the reference illuminated under the cursor.

# Yanky
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
