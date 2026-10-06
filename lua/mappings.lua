require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Build the selected main package in the current Go module.
map("n", "<F5>", function() require("configs.go_build").build() end, { desc = "Go build binary" })
vim.api.nvim_create_user_command("GoBuild", function() require("configs.go_build").build() end, {})

-- Option + Shift + F (terminal must send Option as Alt/Meta).
map({ "n", "i", "x" }, "<M-F>", function()
  require("conform").format { async = true }
end, { desc = "Format buffer without saving" })
