vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 999
vim.opt.mouse = ""
vim.opt.timeoutlen = 1500
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.have_nerd_font = true
vim.opt.signcolumn = 'yes'
vim.opt.confirm = true
vim.opt.inccommand = 'nosplit'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Highlights text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Allows for autosave and open buffer search (Telescope)
vim.keymap.set('n', '<leader>qb', function()
    vim.cmd('w')         -- Save current buffer
    vim.cmd('bd')        -- Close (delete) current buffer
    vim.cmd('Telescope find_files')  -- Open Telescope buffer picker
end, { desc = "Save & close buffer, then pick new one" })

-- Stops whichkey checkhealth warning reports
-- only shows actual errors
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd([[silent! checkhealth]])
--   end,
-- })
