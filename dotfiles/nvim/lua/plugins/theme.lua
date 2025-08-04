return {
	"EdenEast/nightfox.nvim",
	name = "nightfox",
	priority = 1000,
	config = function()
		local palettes = require("nightfox.palette").load("carbonfox")
		local specs    = require("nightfox.spec").load("carbonfox")

		require("nightfox").setup({
			palettes    = palettes,
			specs       = specs,
			options  = {
<<<<<<< HEAD
=======
				transparent  = true,  -- no background
>>>>>>> 4cd7d5b (Moved most configuration over to hyprland desktop.)
				dim_inactive = true,  -- fade inactive windows
                transparent = false,
				styles = {
					comments  = "italic",
					-- keywords  = "bold",
					functions = "bold",
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
