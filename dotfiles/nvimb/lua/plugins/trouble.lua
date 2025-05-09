return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({ icons = false })
    local map = vim.keymap.set
    map("n", "<leader>tf", "<cmd>Trouble<cr>", { desc = "[T]rouble [F]ind" })
    map("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "[T]rouble [W]orkspace" })
    map("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", { desc = "[T]rouble [D]iagnostics" })
    map("n", "<leader>tl", "<cmd>Trouble loclist<cr>", { desc = "[T]rouble [L]ocal List" })
    map("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { desc = "[T]rouble [Q]uickfix" })
    map("n", "<leader>tr", "<cmd>Trouble lsp_references<cr>", { desc = "[T]rouble [R]eferences" })
  end,
}
