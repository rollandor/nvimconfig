return {
  {
    "mfussenegger/nvim-lint",
    ft = { "go" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = { go = { "golangcilint" } }
      -- Always lint the package, including when nvim was opened outside its module.
      local linter = lint.linters.golangcilint
      linter.args[#linter.args] = function()
        return vim.fs.dirname(vim.api.nvim_buf_get_name(0))
      end
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("GoLintOnSave", { clear = true }),
        pattern = "*.go",
        callback = function(event)
          if vim.bo[event.buf].buftype ~= "" or vim.bo[event.buf].filetype ~= "go" then
            return
          end
          if vim.fn.executable "golangci-lint" == 0 then
            vim.notify_once("golangci-lint is not on PATH", vim.log.levels.WARN)
            return
          end
          vim.api.nvim_buf_call(event.buf, function()
            local root = vim.fs.root(event.buf, "go.mod")
              or vim.fs.dirname(vim.api.nvim_buf_get_name(event.buf))
            lint.try_lint("golangcilint", { cwd = root })
          end)
        end,
      })
    end,
  },
}
