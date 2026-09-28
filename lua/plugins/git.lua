return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff: all changed files" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git history: current file" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Git history: repository" },
      { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Git close diff" },
    },
    opts = {
      view = {
        default = { layout = "diff2_horizontal", winbar_info = true },
      },
      file_panel = {
        listing_style = "list",
        win_config = { position = "left", width = 35 },
      },
      default_args = { DiffviewOpen = { "--untracked-files=all" } },
      keymaps = {
        view = { { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff" } } },
        file_panel = { { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff" } } },
        file_history_panel = { { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close history" } } },
      },
    },
  },
}
