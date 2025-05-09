return {
	"EdenEast/nightfox.nvim",
	name = "nigthfox",
	priority = 1000,
	config = function()
		local palettes = require("nightfox.palette").load("carbonfox")
		local specs = require("nightfox.spec").load("carbonfox")

		require("nightfox").setup({ palettes = palettes, specs = specs })
		vim.cmd("colorscheme carbonfox")
	end,
}
