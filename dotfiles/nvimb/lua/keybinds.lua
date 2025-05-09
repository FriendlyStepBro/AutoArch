-- lua/keymaps.lua
---------------------------------------------------------------------------------------------------
-- Helper to set mappings with a description
local function map(mode, lhs, rhs, desc)
	local opts = { noremap = true, silent = true }
	if desc then
		opts.desc = desc
	end
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Set <Space> as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------------------------------------------------------------------------------------------------
-- Clear search highlight with Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Improved scrolling: center cursor
map("n", "<C-d>", "<C-d>zz", "Scroll down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll up and center")

-- Better yank: Y to y$
map("n", "Y", "y$", "Yank to end of line")

---------------------------------------------------------------------------------------------------
-- Clipboard: use the + register
map("n", "<leader>p", '"+p', "[P]aste from + register")
map("v", "<leader>p", '"+p', "[P]aste from + register")
map("n", "<leader>y", '"+yy', "[Y]ank [L]ine to + register")
map("v", "<leader>y", '"+y', "[Y]ank to + register")

-- Preserve default register when pasting in visual
map("v", "p", '"_dP', "Paste without yanking")

-- Indent and reselect in visual mode
map("v", "<", "<gv", "Indent left and reselect")
map("v", ">", ">gv", "Indent right and reselect")

---------------------------------------------------------------------------------------------------
-- Split navigation (CTRL + hjkl)
map("n", "<C-h>", "<C-w>h", "Move to [L]eft window")
map("n", "<C-l>", "<C-w>l", "Move to [R]ight window")
map("n", "<C-j>", "<C-w>j", "Move to [D]own window")
map("n", "<C-k>", "<C-w>k", "Move to [U]p window")

-- Resize splits with Ctrl + arrow keys
map("n", "<C-Left>",  ":vertical resize +2<CR>", "Increase window width")
map("n", "<C-Right>", ":vertical resize -2<CR>", "Decrease window width")
map("n", "<C-Up>",    ":resize +2<CR>",          "Increase window height")
map("n", "<C-Down>",  ":resize -2<CR>",          "Decrease window height")

---------------------------------------------------------------------------------------------------
-- New file: prompt for name
map("n", "<leader>nf", function()
	vim.ui.input({ prompt = "New file name: " }, function(input)
		if input and #input > 0 then
			vim.cmd("edit " .. input)
		end
	end)
end, "[N]ew [F]ile")

---------------------------------------------------------------------------------------------------
-- Essential file/buffer commands
map("n", "<leader>so", ":source $MYVIMRC<CR>", "[S]ource config")

---------------------------------------------------------------------------------------------------
-- Buffer navigation: Tab / Shift-Tab
-- map("n", "<Tab>",     ":bnext<CR>",    "Next buffer")
-- map("n", "<S-Tab>",   ":bprevious<CR>","Previous buffer")

---------------------------------------------------------------------------------------------------
-- Additional note: vim-surround is enabled.
-- Use its default mappings (e.g., ysiw, ds, cs) to wrap or change surroundings.
