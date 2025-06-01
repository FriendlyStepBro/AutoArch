return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        local function get_buffer_content(prompt)
            local bufnr = vim.fn.bufnr(prompt)
            if bufnr ~= -1 then
                return { prompt = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) }
            end

            return nil
        end

        require("telescope").setup({
            defaults = {
                prompt_prefix = "  ",

                layout_config = { width = 0.75 },
                mappings = {
                    i = {
                        ["<A-j>"] = require("telescope.actions").move_selection_next,
                        ["<A-k>"] = require("telescope.actions").move_selection_previous,
                        ["<A-l>"] = require("telescope.actions").select_default,
                    },
                    n = {
                        ["<A-j>"] = require("telescope.actions").move_selection_next,
                        ["<A-k>"] = require("telescope.actions").move_selection_previous,
                        ["<A-l>"] = require("telescope.actions").select_default,
                    },
                },
                file_ignore_patterns = {},
                path_display = { "smart" },
                find_command = function()
                    local bufnr = vim.fn.bufnr(vim.fn.expand("%"))

                    if bufnr ~= -1 then
                        return vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) and vim.fn.expand("%") or nil
                    end
                    return nil
                end,
            },
            pickers = {
                find_files = {
                    on_input_filter_cb = get_buffer_content,
                },
                live_grep = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob=!.git/",
                        "--no-ignore-vcs",
                    },
                    -- Search open buffers first, then disk
                    on_input_filter_cb = function(prompt)
                        local results = {}
                        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                            if vim.api.nvim_buf_is_loaded(buf) then
                                local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                                local fname = vim.api.nvim_buf_get_name(buf)
                                for lnum, line in ipairs(lines) do
                                    if line:find(prompt) then
                                        table.insert(results, { filename = fname, lnum = lnum, text = line })
                                    end
                                end
                            end
                        end
                        return { results = results }
                    end,

                },
            },

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
                ["todo-comments"] = {
                    use_buffers = true,
                    -- Override search to check buffers first
                    search = function(opts)
                        local results = {}
                        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                            if vim.api.nvim_buf_is_loaded(buf) then
                                local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                                local fname = vim.api.nvim_buf_get_name(buf)
                                for lnum, line in ipairs(lines) do

                                    if line:match(opts.pattern) then
                                        table.insert(results, { filename = fname, lnum = lnum, text = line })
                                    end

                                end
                            end

                        end
                        return results
                    end,
                },
            },
        })
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
        vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
        vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind [B]uffers" })
        vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
        vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, { desc = "[F]ind [K]eymaps" })
        vim.keymap.set("n", "<leader>fe", require("telescope.builtin").diagnostics, { desc = "[F]ind [E]rrors" })
        vim.keymap.set("n", "<leader>fs", require("telescope.builtin").grep_string, { desc = "[F]ind by Grep [S]tring" })
        vim.keymap.set("n", "<leader>fn", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "[F]ind [N]eovim Config Files" })
        vim.keymap.set("n", "<leader><leader>", require("telescope.builtin").live_grep, { desc = "[ ][ ]Find by Grep" })
        vim.keymap.set("n", "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "[F]uzzy Search in Buffer" })
    end,
}
