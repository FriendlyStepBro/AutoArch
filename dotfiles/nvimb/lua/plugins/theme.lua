return {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	priority = 1000,
	config = function()
		local palettes = require("nightfox.palette").load("carbonfox")
		local specs    = require("nightfox.spec").load("carbonfox")

		require("nightfox").setup({
			palettes = palettes,
			specs    = specs,
			options  = {
				-- transparent  = true,  -- no background
				dim_inactive = true,  -- fade inactive windows
				styles = {
					comments  = "italic",
					keywords  = "bold",
					functions = "italic,bold",
				},
				inverse = {
					match_paren = true,
					visual      = false,
					search      = false,
				},
			},
		})

		vim.cmd("colorscheme carbonfox")
	end,
}
