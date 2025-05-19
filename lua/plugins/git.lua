local map = vim.keymap.set

map("n", "<leader>gl", ":Flog<CR>", { desc = "Git Log" })
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "Git File History" })
map("n", "<leader>gc", ":DiffviewOpen HEAD~1<CR>", { desc = "Git Last Commit" })
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", { desc = "Git File History" })

-- next hunk
map("n", "<leader>gn", ":Gitsigns next_hunk<CR>", { desc = "Jump to the next hunk"})
-- prev hunk
map("n", "<leader>gp", ":Gitsigns prev_hunk<CR>", { desc = "Jump to the previous hunk"})

return {
  { "tpope/vim-fugitive" },
  { "rbong/vim-flog", dependencies = {
    "tpope/vim-fugitive",
  }, lazy = false },
  { "sindrets/diffview.nvim", lazy = false },
}
