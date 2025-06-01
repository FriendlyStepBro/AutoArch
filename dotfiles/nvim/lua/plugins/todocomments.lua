return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        require("todo-comments").setup({
            signs = true,
            sign_priority = 8,
            colors = {
                fix = { "#FF364E" },
                todo = { "#588F4E" },
                hack = { "#A03200" },
                warn = { "#A03297" },
                perf = { "#00AAFF" },
                note = { "#FFFF19" },
                hint = { "DiagnosticHint" },
                default = { "Identifier" },
            },
            keywords = {
                FIX  = { icon = " ", color = "fix"  }, -- FIX
                TODO = { icon = " ", color = "todo" }, -- TODO
                HACK = { icon = "󰯈 ", color = "hack" }, -- HACK
                WARN = { icon = " ", color = "warn" }, -- WARN
                PERF = { icon = "󰓅 ", color = "perf" }, -- PERF
                NOTE = { icon = " ", color = "note" }, -- NOTE
            },
            gui_style = {
                fg = "NONE",
                bg = "NONE"
            },
            highlight = {
                before = "",
                keyword = "wide",
                after = "",
                comments_only = true,
                exclude = {},
                pattern = [[.*<(KEYWORDS)\s*:]],
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                comments_only = true,
                pattern = [[.*<(KEYWORDS):\s*]],
            }
        })
        require("telescope").load_extension("todo-comments")
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "[F]ind [T]odo's" })
    end,
}
