return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",  -- added dependency required by nvim-dap-ui
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    -- Example adapter configuration for .NET debugging using netcoredbg
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg', -- Ensure netcoredbg is installed and in your PATH
      args = { '--interpreter=vscode' },
    }

    -- Example configuration for C# debugging
    dap.configurations.cs = {
      {
        type = "coreclr",
        request = "launch",
        name = "Launch .NET Core",
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }

    -- Automatically open and close dap-ui on debug events
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keybindings for debugging
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
    -- Additional keybind to toggle the debugging UI
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
  end,
}
