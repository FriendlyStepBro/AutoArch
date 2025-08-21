-- Highlights text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Allows for autosave and open buffer search (Telescope)
vim.keymap.set('n', '<leader>qb', function()
    vim.cmd('w')         -- Save current buffer
    vim.cmd('bd')        -- Close (delete) current buffer
    vim.cmd('Telescope find_files')  -- Open Telescope buffer picker
end, { desc = "Save & close buffer, then pick new one" })

