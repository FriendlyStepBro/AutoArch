require("keybinds")
require("core")
-- Lazy bootstrap configuration
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(require("plugins"))

vim.cmd([[ autocmd BufEnter * silent! lcd %:p:h ]])
