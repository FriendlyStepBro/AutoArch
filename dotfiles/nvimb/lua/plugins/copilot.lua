return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
	dependencies = { "zbirenbaum/copilot-cmp" },
	opts = {
		plugin_manager_path = vim.fn.stdpath("data") .. "/lazy",
		copilot_node_command = "node",

		suggestion = {
			enabled = false,       -- no in-line ghost text
			auto_trigger = false,  -- don’t auto-show completions
			-- you can still accept a suggestion when panel is open:
			keymap = {
				accept  = "<C-y>",
				next    = "<M-]>",
				prev    = "<M-[>",
				dismiss = "<C-e>",
			},
		},

		panel = {
			enabled     = true,
			auto_refresh = false,    -- manual refresh preferred
			keymap = {
				jump_prev = "<leader>cp",           -- previous suggestion
				jump_next = "<leader>cn",           -- next suggestion
				accept    = "<leader>ca",        -- accept from panel
				refresh   = "<leader>cr",           -- refresh list
				open      = "<leader>co",   -- open Copilot panel
			},
		},
	},
	config = function(_, opts)
		require("copilot").setup(opts)
	end,
}
