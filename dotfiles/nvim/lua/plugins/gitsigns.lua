return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      numhl = true,
      linehl = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Previous Hunk")
        map("n", "<leader>gsh", gs.stage_hunk, "Stage Hunk")
        map("n", "<leader>grh", gs.reset_hunk, "Reset Hunk")
        map("n", "<leader>gsb", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gsu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>grb", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gph", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "Blame Line")
        -- Additional keybindings:
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gct", gs.toggle_current_line_blame, "Toggle Current Line Blame")
      end,
    })
  end,
}
