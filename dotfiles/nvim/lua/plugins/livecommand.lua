return {
    "smjonas/live-command.nvim",
    config = function()
        require("live-command").setup{
            enable_highlighting = true,
            inline_highlighting = true,
            hl_groups = {
                insertion = "DiffAdd",
                deletion = "DiffDelete",
                change = "DiffChange",
            },
        }
    end,
}
