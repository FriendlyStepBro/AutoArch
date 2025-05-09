return {
  "tpope/vim-fugitive",
  config = function()
    -- Set up keybindings for Git actions using Fugitive
    vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
    vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "[G]it [C]ommit" })
    vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "[G]it [P]ush" })
    vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "[G]it [L]og" })
    -- ...additional configuration if needed...
  end,
}
