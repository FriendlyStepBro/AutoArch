return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    -- Configure inline diagnostics to show all diagnostics
    vim.diagnostic.config({
      virtual_text = true
    })

    -- Mason setup for automatic installation of LSP servers and formatters
    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = { "omnisharp" },
    })

    local lspconfig = require("lspconfig")

    -- Replace the on_attach function with comprehensive keybinds and auto commands
    local on_attach = function(client, bufnr)
      local bufopts = { buffer = bufnr, silent = true }
      local map = function(mode, lhs, rhs, desc)
        -- if desc then
        --   desc = "LSP: " .. desc
        -- end
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", bufopts, { desc = desc }))
      end

      -- LSP navigation and actions
      map("n", "gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
      map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map("n", "gi", vim.lsp.buf.implementation, "[G]oto [i]mplementation")
      map("n", "<leader>fr", require("telescope.builtin").lsp_references, "[F]ind [R]eferences")
      -- map("n", "gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")

      -- Code actions, refactor, rename
      map("n", "grn", vim.lsp.buf.rename, "[G]lobal [r]e[n]ame")
      map("n", "gca", vim.lsp.buf.code_action, "[G]lobal [c]ode [a]ction")

      -- Diagnostics
      map("n", "<leader>ds", vim.diagnostic.open_float, "[D]iagnostic [S]how")
      map("n", "gp", vim.diagnostic.goto_prev, "[G]oto [P]revious Diagnostic")
      map("n", "gn", vim.diagnostic.goto_next, "[G]oto [N]ext Diagnostic")

      -- Hover & signature help
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Toggle inlay hints (if supported)
      map("n", "<leader>dt", function()
        if vim.lsp.inlay_hint then
          local enabled = vim.b.lsp_inlay_hint_enabled or false
          vim.b.lsp_inlay_hint_enabled = not enabled
          vim.lsp.inlay_hint(bufnr, not enabled)
        end
      end, "[D]iagnostics [T]oggle")

      -- Format on save
      local lsp_format_grp = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
      vim.api.nvim_clear_autocmds({ group = lsp_format_grp, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_format_grp,
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
      })

      -- Codelens support: auto-refresh and a manual trigger
      if client.server_capabilities.codeLensProvider then
        local clgroup = vim.api.nvim_create_augroup("LspCodeLens", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = bufnr,
          group  = clgroup,
          callback = vim.lsp.codelens.refresh,
        })
        vim.keymap.set("n", "<leader>dr", vim.lsp.codelens.refresh, { buffer = bufnr, desc = "[D]iagnostic [R]efresh" })
      end
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    lspconfig.omnisharp.setup({
      cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("*.sln", ".git"),
      flags = { debounce_text_changes = 150 },
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      },
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

    -- Automatic LSP buffer attachment and diagnostic refresh on buffer enter
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("LspAutoAttach", { clear = true }),
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
        if vim.tbl_isempty(clients) then
          vim.cmd("LspStart")
        else
          vim.lsp.buf_request(bufnr, "textDocument/publishDiagnostics",
            { textDocument = vim.lsp.util.make_text_document_params() },
            function() end
          )
        end
      end,
    })

    -- Keybind to toggle inline diagnostics (virtual text) on/off
    vim.keymap.set("n", "<leader>td", function()
      local current = vim.diagnostic.config().virtual_text
      if current and current ~= false then
        vim.diagnostic.config({ virtual_text = false })
        print("Inline diagnostics disabled")
      else
        vim.diagnostic.config({ virtual_text = true })
        print("Inline diagnostics enabled")
      end
    end, { desc = "Toggle inline diagnostics" })
  end,
}
