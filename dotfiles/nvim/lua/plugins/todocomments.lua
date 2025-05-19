return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        require("todo-comments").setup({
            signs = true,
            sign_priority = 8,
            keywords = {
                TODO = { icon = " ", color = "info" },
                FIX = { icon = " ", color = "error" },
                HACK = { icon = "󰯈 ", color = "warning" },
                WARN = { icon = " ", color = "warning" },
                PERF = { icon = "󰓅 ", color = "hint" },
                NOTE = { icon = " ", color = "hint" },
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                },
                pattern = [[\b(KEYWORDS)\b]]
            }
        })
        -- Load telescope extension for todo-comments
        require("telescope").load_extension("todo-comments")
        -- Optionally, add a keybinding to invoke todo-comments search via Telescope
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "[F]ind [T]odo's" })
    end,
}
