return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<F6>",
        function()
          require("dap").continue()
        end,
        desc = "Debug start / continue",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug breakpoint",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug step into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug step out",
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
        end,
        desc = "Debug stop",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        mode = { "n", "v" },
        desc = "Debug evaluate",
      },
      {
        "<leader>dt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug nearest Go test",
      },
    },
    config = function()
      local dap, ui = require "dap", require "dapui"
      local dlv = vim.fn.exepath "dlv"
      if dlv == "" then
        dlv = vim.fn.expand "~/go/bin/dlv"
      end
      require("dap-go").setup { delve = { path = dlv } }
      ui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        ui.open()
      end
      -- Keep the UI open after termination so output remains available.
    end,
  },
}
