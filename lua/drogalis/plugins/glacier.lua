return {
    "drogalis/glacier.nvim",
    lazy = false,
          priority = 1000,
    config = function()
      require("glacialdrift").setup({
        transparent = false,
        colors = {
          fg = "#c0c0c0",
          bg = "#1c1c1c",
          line_nr = "#222222",
          string = "#7dabd1",
          visual = "#303030",
          comment = "#757575",
          func = "#81d6a2", -- 135, 100, 78
          kw = "#bfe8f2",
          identifier = "#e6e6e6",
          type = "#81d6a2", -- 188, 100, 78
          search_highlight = "#00bd6d",
          operator = "#00bd6b",
          bracket = "#e6e6e6",
          -- preprocessor = "#4b8902",
          bool = "#7dabd1",
          constant = "#7dabd1", -- 207, 100, 78

          bufferline_selection = "#1bfd9c",

          -- gitsigns colors
          added = "#baffc9",
          changed = "#ffffba",
          removed = "#ffb3ba",

          error = "#dea6a0",
          warning = "#D0B8A8",
          hint = "#BEDC74",
          info = "#7FA1C3",
        },
      })
      vim.cmd("syntax enable")
      vim.cmd.colorscheme("glacialdrift")
    end,
}