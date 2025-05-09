-- lua/plugins/codi.lua
-- Lazy.nvim plugin spec for codi.vim with global availability, C# REPL support, and robust keybindings
return {
	"metakirby5/codi.vim",
	cmd = "Codi",
	keys = {
		{ "<leader><CR>", "<Cmd>CodiUpdate<CR>", mode = { "n", "v" }, desc = "Codi: execute code or update REPL" },
		{ "<leader><S-CR>", "<Cmd>Codi!!<CR>", mode = "n", desc = "Codi: toggle REPL" },
	},
	config = function()
		-- Interpret C# using dotnet-script, fallback to defaults for other langs
		vim.g["codi#interpreters"] = { cs = "dotnet script" }
		-- open REPL on right and auto-close on buffer leave
		vim.g["codi#rightsplit"] = 1
		vim.g["codi#autoclose"] = 1
		-- trigger on buffer write or CursorHold for live updates
		vim.g["codi#autocmd"] = { "BufWritePost", "CursorHold" }
	end,
}
