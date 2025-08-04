return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        require("todo-comments").setup({
            signs = true,
            -- sign_priority = 8,
            merge_keywords = true,
            colors = {
                fix = { "#FF364E" },
                todo = { "#588F4E" },
                hack = { "#A03200" },
                warn = { "#A03297" },
                perf = { "#00AAFF" },
                note = { "#FFFF19" },
            },
            keywords = {
                FIX  = { icon = " ", color = "fix"  }, -- FIX:
                TODO = { icon = " ", color = "todo" }, -- TODO:
                HACK = { icon = "󰯈 ", color = "hack" }, -- HACK:
                WARN = { icon = " ", color = "warn" }, -- WARN:
                PERF = { icon = "󰓅 ", color = "perf" }, -- PERF:
                NOTE = { icon = " ", color = "note" }, -- NOTE:
            },
            highlight = {
                before = "bg",
                keyword = "wide",
                after = "fg",
                comments_only = true,
                exclude = {},
                pattern = [[\b(KEYWORDS):\b]],
            },
            search = {
                command = "rg",
                args = {
                    "--smart-case",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                },
                pattern = [[\b(KEYWORDS):]],
            },
        })
        require("telescope").load_extension("todo-comments")
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "[F]ind [T]odo's" })
    end,
}
