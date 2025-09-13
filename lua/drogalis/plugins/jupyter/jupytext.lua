return   {
    "GCBallesteros/jupytext.nvim",
    version = "*", -- Use latest stable version
    dependencies = {
     -- "GCBallesteros/NotebookNavigator.nvim",
     -- "echasnovski/mini.comment",
    },
    config = function()
      require("jupytext").setup({
        style = "markdown",      -- or "python"
        output_extension = "md", -- or "py"
        -- Command to use for converting (defaults to jupytext in PATH)
        command = "jupytext",
      })
    end,
  }