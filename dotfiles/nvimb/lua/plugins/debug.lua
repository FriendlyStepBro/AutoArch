return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",         -- added nvim-nio
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-nvim-dap").setup()
    require("nvim-dap-virtual-text").setup()

    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui"]    = function() dapui.close() end

    local map = vim.keymap.set
    map("n", "<F5>",  dap.continue,      { desc = "[X] Debug Continue" })
    map("n", "<F10>", dap.step_over,     { desc = "[X] Debug Step Over" })
    map("n", "<F11>", dap.step_into,     { desc = "[X] Debug Step Into" })
    map("n", "<F12>", dap.step_out,      { desc = "[X] Debug Step Out" })
    map("n", "<leader>xb", dap.toggle_breakpoint,   { desc = "[X] Toggle [B]reakpoint" })
    map("n", "<leader>xB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end,   { desc = "[X] Toggle Conditional [B]reakpoint" })
  end,
}
