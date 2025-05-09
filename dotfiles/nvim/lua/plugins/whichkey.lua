return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup({
      sort_by = "description",  -- sort keys by description
      mode = "helix",           -- use helix mode
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      icons = {
        breadcrumb = " » ",
        separator = "  ",
        group = " + ",
      },
      window = {  -- revert from "win" to "window"
        border = "single",
        position = "right", -- set window to appear on the right
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "right",
      },
      ignore_missing = false,  -- revert to original option
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:" },
      show_help = true,
    })
  end,
}
