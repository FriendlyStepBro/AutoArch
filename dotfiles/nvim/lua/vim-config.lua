vim.cmd("set expandtab")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")
vim.cmd("set scrolloff=999")
vim.cmd("set mouse=")
-- vim.cmd("set wildmenu=true")

vim.opt.relativenumber = true
vim.opt.number = true

vim.keymap.set('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.keymap.set('v', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = " "

-- additional keybinds
vim.keymap.set('n', '<leader>fq', ":qa!<CR>", {})
vim.keymap.set('n', '<leader>wq', ":wa<CR>:qa<CR>:", {})

vim.keymap.set('n', '<leader>h', '^', { noremap = false, silent = true })
vim.keymap.set('n', '<leader>l', '$', { noremap = false, silent = true })
vim.keymap.set('v', '<leader>h', '^', { noremap = false, silent = true })
vim.keymap.set('v', '<leader>l', '$', { noremap = false, silent = true })

-- insert line about without entering insert mode
vim.keymap.set('n', '<leader>o', 'm`o<Esc>``', { noremap = false, silent = true })
vim.keymap.set('n', '<leader>O', 'm`O<Esc>``', { noremap = false, silent = true })

vim.keymap.set('n', '<leader>p', '"+p', { noremap = false, silent = true})
vim.keymap.set('n', '<leader>y', '"+yy', { noremap = false, silent = true})
vim.keymap.set('v', '<leader>y', '"+y', { noremap = false, silent = true})

--vim.keymap.set('v', '<leader>j', ':move v:count+1<CR>gv', { noremap = true, silent = true })
--vim.keymap.set('v', '<leader>k', ':move .-2<CR>gv', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>j', ':move +1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>k', ':move -2<CR>', { noremap = true, silent = true })
