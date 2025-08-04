return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            formatting = {
                format = require("nvim-highlight-colors").format,
            },
            mapping = cmp.mapping.preset.insert({
                ['<A-j>'] = cmp.mapping.select_next_item(), -- Alt+j: select next item
                ['<A-k>'] = cmp.mapping.select_prev_item(), -- Alt+k: select previous item
                ['<A-l>'] = cmp.mapping.confirm({ select = true }), -- Alt+l: confirm selection
                ['<C-Space>'] = cmp.mapping.complete(),     -- Ctrl+Space: trigger completion
                -- ['<Esc>'] = cmp.mapping.abort(),                   -- Escape to abort completion
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            }),
        })
    end,
}
