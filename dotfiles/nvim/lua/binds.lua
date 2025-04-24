-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.keymap.set('v', '<Space>', '<NOP>', { noremap = true, silent = true })

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

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
