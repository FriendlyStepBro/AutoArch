return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern" },
      patterns = { "*.sln", "*.csproj", ".git" },
      ignore_lsp = {}, -- make LSP respect project.nvim's root
    })

    require("telescope").load_extension("projects")
  end,
  event = "VeryLazy",
}
