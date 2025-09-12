return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim", -- For managing test runners
        "Issafalcon/neotest-dotnet", -- C# test adapter
        "nvim-neotest/neotest-python", -- Python test adapter
        "vim-test/vim-test",
        "nvim-neotest/neotest-vim-test",
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
                    dap = { justMyCode = false },    -- Integrate with nvim-dap for debugging
                    dotnet_additional_args = { "--no-build" }, -- Optimize for faster runs
                }),
                -- require("neotest-vim-test")({
                --     ignore_file_types = { "python", "cs" },
                --     allow_file_types = { "java" },
                --     vim_test = {
                --         framework = "junit",
                --         executable = "mvn test",
                --     },
                -- }),
            },
            output = { open_on_run = true },       -- Auto-open output panel
            quickfix = { enabled = true, open = false }, -- Populate quickfix list
            status = { virutal_text = true },
            discovery = {
                enables = true,
                initialize = {
                    timeout = 5000,
                },
                position = {
                    query = [[
                        (method_declaration
                        name: (identifier) @text.name
                        (#match? @test.name "^test.*")
                        (annotation "@Test")) @test.definition
                    ]]
                },
            },
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

        --vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        --  group = vim.api.nvim_create_augroup("NeotestAutoRefresh", { clear = true }),
        --  callback = function()
        --    if neotest.summary.is_open() then
        --      neotest.summary.sync()
        --    end
        --  end,
        --})
    end,
}
