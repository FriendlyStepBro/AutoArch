return {
  -- Active plugins:
    require("plugins.telescope"),
    require("plugins.treesitter"),
    require("plugins.textobjects"), -- Added improved text objects plugin
    require("plugins.lsp"), -- Added LSP configuration
    require("plugins.debug"), -- Added Debugging configuration
    require("plugins.theme"), -- Added Theme configuration (carbonfox)
    require("plugins.neotree"), -- Added Neo-tree explorer configuration
    require("plugins.lualine"), -- Added Lualine configuration
    require("plugins.fugitive"), -- Added Fugitive integration
    require("plugins.neodev"), -- Added Neodev for Neovim config development
    require("plugins.surround"), -- Added Vim-surround by tpope
    require("plugins.autopairs"), -- Added autopairs
    require("plugins.cmp"), -- Added nvim-cmp completions
    require("plugins.gitsigns"), -- Added Gitsigns for Git integration
    require("plugins.whichkey"), -- Added which-key integration
    require("plugins.todocomments"), -- Added TODO Comments integration with Telescope
    require("plugins.lazygit"), -- Added LazyGit integration
    require("plugins.testrunner")
  -- To disable a plugin, comment out its require call:
}
