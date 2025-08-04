return {
<<<<<<< HEAD
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            auto_install = true,
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true },
            playground = {
                enable = true,
                updatetime = 25,
                persist_queries = false,
            },
        })
    end,
=======
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      playground = {
        enable = true,
        updatetime = 25,
        persist_queries = false,
      },
    })
  end,
>>>>>>> 4cd7d5b (Moved most configuration over to hyprland desktop.)
}
