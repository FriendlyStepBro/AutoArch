return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim", -- Added
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    require("mason").setup()
    require("mason-nvim-dap").setup({
      ensure_installed = { "python", "netcoredbg" },
      automatic_installation = true,
    })

    require("dap-python").setup("python")

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      },
    }

    dap.adapters.netcoredbg = {
      type = "executable",
      command = "netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "netcoredbg",
        name = "Launch .NET Core",
        request = "launch",
        program = function()
          local cwd = vim.fn.getcwd()
          local dll = vim.fn.glob(cwd .. "/bin/Debug/*/*.dll")
          if dll == "" then
            return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/", "file")
          end
          return dll
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
      },
    }

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
  end,
}
