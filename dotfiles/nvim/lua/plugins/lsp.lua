return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvimtools/none-ls.nvim", -- updated fork of null-ls
  },
  config = function()
    vim.diagnostic.config({ virtual_text = true })

    -- Setup Mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = { "omnisharp", "pylsp" },
    })

    local lspconfig = require("lspconfig")

    -- Global hover/signature borders
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, { border = "rounded" }
    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, { border = "rounded" }
    )

    -- Formatting on demand
    vim.keymap.set("n", "<leader>df", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "[D]iagnostics [F]ormat buffer" })

    -- Inlay hint toggle
    vim.keymap.set("n", "<leader>dT", function()
      if vim.lsp.inlay_hint then
        local enabled = vim.b.lsp_inlay_hint_enabled or false
        vim.b.lsp_inlay_hint_enabled = not enabled
        vim.lsp.inlay_hint(0, not enabled)
      end
    end, { desc = "[D]iagnostics [T]oggle Inlay Hints" })

    local on_attach = function(client, bufnr)
      local bufopts = { buffer = bufnr, silent = true }
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", bufopts, { desc = desc }))
      end

      map("n", "gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
      map("n", "gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
      map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map("n", "gi", vim.lsp.buf.implementation, "[G]oto [i]mplementation")
      map("n", "<leader>fr", require("telescope.builtin").lsp_references, "[F]ind [R]eferences")
      map("n", "grn", vim.lsp.buf.rename, "[G]lobal [r]e[n]ame")
      map("n", "gca", vim.lsp.buf.code_action, "[G]lobal [c]ode [a]ction")
      map("n", "<leader>ds", vim.diagnostic.open_float, "[D]iagnostic [S]how")
      map("n", "gp", vim.diagnostic.goto_prev, "[G]oto [P]revious Diagnostic")
      map("n", "gn", vim.diagnostic.goto_next, "[G]oto [N]ext Diagnostic")
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      if client.server_capabilities.documentFormattingProvider then
        local format_grp = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
        vim.api.nvim_clear_autocmds({ group = format_grp, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = format_grp,
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
        })
      end

      if client.server_capabilities.codeLensProvider then
        local clgroup = vim.api.nvim_create_augroup("LspCodeLens", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold" }, {
          buffer = bufnr,
          group  = clgroup,
          callback = vim.lsp.codelens.refresh,
        })
        map("n", "<leader>dr", vim.lsp.codelens.refresh, "[D]iagnostic [R]efresh")
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    lspconfig.pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
          },
        },
      },
    })

    lspconfig.omnisharp.setup({
      cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
      flags = { debounce_text_changes = 150 },
      settings = {
        omnisharp = {
          useModernNet = true,
          enableRoslynAnalyzers = true,
          organizeImportsOnFormat = true,
          formattingOptions = {
            OrganizeImports = true,
          },
        },
      },
    })

    -- Setup null-ls (formatter backend)
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,       -- Python
        null_ls.builtins.formatting.prettier,    -- JS/TS/HTML/CSS/JSON
        null_ls.builtins.formatting.csharpier,   -- C#
      },
      on_attach = on_attach,
    })
  end,
}
