return {
  "nvim-lualine/lualine.nvim",
  dependencies = { }, -- removed "arkav/lualine-lsp-progress.nvim"
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        icons_enabled = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = {
          'encoding', 'fileformat', 'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'neo-tree', 'fugitive' },
    })
  end,
}
