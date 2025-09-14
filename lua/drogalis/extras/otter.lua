return {
  "jmbuhr/otter.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "quarto", "markdown" },
  config = function()
    require("otter").setup({
      lsp = {
        hover = {
          border = "rounded",
        },
      },
      buffers = {
        set_filetype = true,
        write_to_disk = false,
      },
      strip_wrapping_quote_characters = { "'", '"', "`" },
    })
  end,
}