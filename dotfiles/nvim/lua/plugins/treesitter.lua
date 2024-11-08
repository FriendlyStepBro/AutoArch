return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
         auto_install = true,
			--ensure_installed = { "lua", "javascript", "c_sharp", "python", "cpp", "c", "json", "xml", "html", "css" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
