return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local status, null_ls = pcall(require, "null-ls")
    if not status then
      return
    end
    null_ls.setup({
      on_init = function(client)
        if client._request_name_to_capability == nil then
          client._request_name_to_capability = {}
        end
      end,
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "lua", "html", "css", "json" },
        }),
        null_ls.builtins.formatting.stylua,
      },
      -- Optional: add additional autoformatting callbacks or settings here
    })
  end,
}
