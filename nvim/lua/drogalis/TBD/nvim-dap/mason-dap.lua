return {
  "jay-babu/mason-nvim-dap.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dap = require("dap")

    -- setup mason and ensure cpptools is installed
    require("mason").setup()
    require("mason-nvim-dap").setup({
      ensure_installed = { "cpptools" },
    })

    -- setup cpptools adapter
    dap.adapters.cpptools = {
      type = "executable",
      name = "cpptools",
      command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
      args = {},
      attach = {
        pidProperty = "processId",
        pidSelect = "ask",
      },
    }

    dap.adapters.cppdbg = {
      type = "executable",
      name = "cppdbg",
      command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
      args = {},
      attach = {
        pidProperty = "processId",
        pidSelect = "ask",
      },
    }
    -- this configuration should start cpptools and the debug the executable main in the current directory when executing :DapContinue
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "cpptools",
        request = "launch",
        program = "${workspaceFolder}/main",
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
        runInTerminal = false,
      },
    }
  end,
}
