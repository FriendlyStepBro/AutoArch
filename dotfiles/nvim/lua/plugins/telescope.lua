return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
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
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    -- Telescope builtins key mappings under <leader>f prefix
    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
    vim.keymap.set("n", "<leader><leader>", require("telescope.builtin").live_grep, { desc = "[ ][ ]Find by Grep" })
    vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind [B]uffers" })
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
    vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, { desc = "[F]ind [K]eymaps" })
    -- Additional Telescope mappings
    vim.keymap.set("n", "<leader>fe", require("telescope.builtin").diagnostics, { desc = "[F]ind [E]rrors" })
    vim.keymap.set("n", "<leader>fs", require("telescope.builtin").grep_string, { desc = "[F]ind by Grep [S]tring" })
    vim.keymap.set("n", "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "[F]uzzy Search in Buffer" })
    vim.keymap.set("n", "<leader>fn", function()
      require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[F]ind [N]eovim Config Files" })
  end,
}
