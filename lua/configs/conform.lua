local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "go" then
      return { timeout_ms = 2000, lsp_format = "never" }
    end
  end,
}

return options
