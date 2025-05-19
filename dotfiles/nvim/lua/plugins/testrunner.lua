return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python", -- Python test adapter
    "Issafalcon/neotest-dotnet",  -- C# test adapter
    "williamboman/mason.nvim",    -- For managing test runners
  },
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-python")({
          -- Configure Python test runner (pytest recommended)
          runner = "pytest",
          args = { "--log-level=INFO" },
          python = function()
            return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
          end,
          dap = { justMyCode = false }, -- Integrate with nvim-dap for debugging
        }),
        require("neotest-dotnet")({
          -- Configure C# test runner (dotnet test)
          dap = { justMyCode = false }, -- Integrate with nvim-dap for debugging
          dotnet_additional_args = { "--no-build" }, -- Optimize for faster runs
        }),
      },
      output = { open_on_run = true }, -- Auto-open output panel
      quickfix = { enabled = true, open = false }, -- Populate quickfix list
    })

    -- Keybindings for testing (VSCode-like)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
    end

    map("<leader>tt", function() neotest.run.run() end, "Test: Run nearest test")
    map("<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, "Test: Run current file")
    map("<leader>ta", function() neotest.run.run(vim.fn.getcwd()) end, "Test: Run all tests")
    map("<leader>td", function() neotest.run.run({ strategy = "dap" }) end, "Test: Debug nearest test")
    map("<leader>to", function() neotest.output_panel.toggle() end, "Test: Toggle output panel")
    map("<leader>ts", function() neotest.summary.toggle() end, "Test: Toggle summary")
    map("]t", function() neotest.jump.next({ status = "failed" }) end, "Test: Next failed test")
    map("[t", function() neotest.jump.prev({ status = "failed" }) end, "Test: Previous failed test")

    -- Auto-refresh test summary on buffer changes
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("NeotestAutoRefresh", { clear = true }),
      callback = function()
        if neotest.summary.is_open() then
          neotest.summary.sync()
        end
      end,
    })
  end,
}
