local opt = vim.opt
local g = vim.g

opt.number = true
opt.numberwidth = 2
opt.expandtab = true
opt.termguicolors = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.scrolloff = 999
opt.mouse = ""
opt.timeoutlen = 1500
opt.relativenumber = true
opt.cursorline = true
opt.showmode = false
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.confirm = true
opt.inccommand = 'nosplit'
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.whichwrap:append "hl"
g.have_nerd_font = true


-- Stops whichkey checkhealth warning reports
-- only shows actual errors
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd([[silent! checkhealth]])
--   end,
-- })
