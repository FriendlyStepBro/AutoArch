return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      highlight = { enable = true },
      indent = { enable = true },
      playground = {
        enable = true,
        updatetime = 25,
        persist_queries = false,
      },
    })
  end,
}
