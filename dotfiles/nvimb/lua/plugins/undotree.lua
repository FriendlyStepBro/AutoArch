return {
	"mbbill/undotree",
	-- Lazily load when toggling undo tree
	cmd = "UndotreeToggle",
	keys = {
		{ "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
	},
	config = function()
		-- make Undotree open on the right, 30 cols wide
		vim.g.undotree_CustomUndotreeCmd = "rightbelow vertical 35 new"
		-- make its diff panel open below the tree, 12 lines high
		vim.g.undotree_CustomDiffpanelCmd = "wincmd p | belowright 12 new"
		-- Layout: 2 = right split, 1 = horizontal
		vim.g.undotree_WindowLayout = 2
		-- Width of the vertical split
		vim.g.undotree_SplitWidth = 40
		-- Focus the undo-tree window when toggled
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
