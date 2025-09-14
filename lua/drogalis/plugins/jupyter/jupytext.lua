return {
  "drogalis/jupytext.nvim",
  version = "*", -- Use latest stable version
  dependencies = {
    -- "GCBallesteros/NotebookNavigator.nvim",
    -- "echasnovski/mini.comment",
  },
  config = function()
    require("drogalis.plugins.jupyter.styling.styling").setup()
    require("jupytext").setup({
      style = "markdown", -- or "python"
      output_extension = "md", -- or "py"
      force_ft = "markdown", -- Force filetype after conversion
      custom_language_formatting = {
        python = {
          extension = "py",
          style = "percent",
          force_ft = "python",
        },
        r = {
          extension = "r",
          style = "percent",
          force_ft = "r",
        },
      },
    })

    -- Custom highlight groups for better visibility
    vim.api.nvim_set_hl(0, "MiniHipatternsFixme", { bg = "#ff6b6b", fg = "#ffffff", bold = true })
    vim.api.nvim_set_hl(0, "MiniHipatternsHack", { bg = "#ffa500", fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "MiniHipatternsTodo", { bg = "#4ecdc4", fg = "#000000", bold = true })
    vim.api.nvim_set_hl(0, "MiniHipatternsNote", { bg = "#45b7d1", fg = "#ffffff", bold = true })
  end,
}