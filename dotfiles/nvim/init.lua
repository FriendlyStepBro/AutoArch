-- Add /home/fsb/.local/share/nvim/site to runtimepath
vim.opt.runtimepath:append("/home/fsb/.local/share/nvim/site")

-- Load keybinds and core settings
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

-- Load plugins
require("lazy").setup("plugins") -- Changed to string to load ~/.config/nvim/lua/plugins/*.lua

-- Set working directory to current file's directory
vim.cmd([[ autocmd BufEnter * silent! lcd %:p:h ]])
