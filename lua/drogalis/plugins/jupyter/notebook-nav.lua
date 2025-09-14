return {
  "GCBallesteros/NotebookNavigator.nvim",
  version = "*", -- Use latest stable version
  dependencies = {
    "echasnovski/mini.comment",
    "Vigemus/iron.nvim",
    "echasnovski/mini.hipatterns", -- For cell highlighting
  },
  ft = { "python", "ipynb", "markdown" },
  config = function()
    local nn = require("notebook-navigator")
    nn.setup({
      activate_hydra = false,
      repl_provider = "iron",
      cell_markers = {
        python = "# %%",
        markdown = "```python",
      },
      show_hydra_hint = false,
      syntax_highlight = true,
      cell_highlight_group = "Visual",
    })

    -- Enhanced cell navigation keymaps
    vim.keymap.set("n", "<leader>jr", function()
      nn.run_cell()
    end, { desc = "Run cell" })

    vim.keymap.set("n", "<leader>jR", function()
      nn.run_and_move()
    end, { desc = "Run cell and move to next" })

    vim.keymap.set("n", "]j", function()
      nn.move_cell("d")
    end, { desc = "Next cell" })

    vim.keymap.set("n", "[j", function()
      nn.move_cell("u")
    end, { desc = "Previous cell" })

    vim.keymap.set("n", "<leader>jc", function()
      nn.comment_cell()
    end, { desc = "Comment cell" })

    vim.keymap.set("n", "<leader>ja", function()
      nn.run_all_cells()
    end, { desc = "Run all cells" })
  end,
}