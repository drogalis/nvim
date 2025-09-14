return {
  "Vigemus/iron.nvim",
  version = "*",
  ft = { "python", "julia", "r", "lua" },
  config = function()
    local iron = require("iron.core")

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { "ipython", "--no-autoindent" },
            format = require("iron.fts.common").bracketed_paste_python,
            block_dividers = { "# %%", "#%%" },
          },
          lua = {
            command = { "lua" },
          },
        },
        repl_open_cmd = "vertical botright split",
        close_on_exit = true,
        highlight_last = false,
      },
      highlight = false,
    })

    -- Additional REPL keymaps
    vim.keymap.set("n", "<leader>io", function()
      iron.repl_for(vim.bo.filetype)
    end, { desc = "Open REPL" })

    vim.keymap.set("n", "<leader>ir", function()
      iron.send(vim.bo.filetype, "")
    end, { desc = "Restart REPL" })

    vim.keymap.set("n", "<leader>il", function()
      local line = vim.api.nvim_get_current_line()
      require("iron.core").send(vim.bo.filetype, line) -- Direct send, no marks
    end, { desc = "Send line to REPL" })

    vim.keymap.set("v", "<leader>is", function()
      require("iron.core").visual_send()
    end, { desc = "Send visual selection to REPL" })

    vim.keymap.set("n", "<leader>if", function()
      require("iron.core").send_file()
    end, { desc = "Send file to REPL" })

    vim.keymap.set("n", "<leader>iu", function()
      require("iron.core").send_until_cursor()
    end, { desc = "Send until cursor to REPL" })

    vim.keymap.set("n", "<leader>iq", function()
      require("iron.core").close_repl()
    end, { desc = "Close REPL" })

    vim.keymap.set("n", "<leader>icl", function()
      require("iron.core").send(vim.bo.filetype, "clear")
    end, { desc = "Clear REPL" })

    -- Interrupt REPL
    vim.keymap.set("n", "<leader>ii", function()
      require("iron.core").send(
        vim.bo.filetype,
        vim.api.nvim_replace_termcodes("<C-c>", true, false, true)
      )
    end, { desc = "Interrupt REPL" })
  end,
}