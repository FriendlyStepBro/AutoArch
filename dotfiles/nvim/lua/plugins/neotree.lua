return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "right",
        width = 32,
      },
      auto_refresh = true,       -- live updates enabled
      follow_current_file = {    -- automatically update explorer to follow the current file
        enabled = true,
        leave_open = false,
      },
      filesystem = {
        filtered_items = {
          visible = true,    
          hide_dotfiles = false,
        },
      },
      git_status = {
        window = {
          position = "right",
          width = 32,
        },
      },
    })
    -- Keybindings
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "[E]xplorer Toggle" })
  end,
}
