return {
  "quarto-dev/quarto-nvim",
  dependencies = {
    "jmbuhr/otter.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "quarto", "markdown" },
  config = function()
    require("quarto").setup({
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly", -- 'curly' or 'all'
        languages = { "r", "python", "julia", "bash", "html" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten", -- or "slime"
        ft_runners = {
          python = "molten",
        },
        never_run = { "yaml" },
      },
      keymap = {
        hover = "K",
        definition = "gd",
        rename = "<leader>qr",
        references = "gr",
        format = "<leader>qf",
      },
    })

    -- Enhanced keymaps for Quarto
    local quarto = require("quarto")

    -- vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, { desc = "Preview Quarto document" })
    -- vim.keymap.set("n", "<leader>qq", quarto.quartoClosePreview, { desc = "Close Quarto preview" })
    -- vim.keymap.set("n", "<leader>qh", ":QuartoHelp ", { desc = "Quarto help" })
    -- vim.keymap.set(
    --   "n",
    --   "<leader>qe",
    --   ":lua require'otter'.export()<cr>",
    --   { desc = "Export with Otter" }
    -- )
    -- vim.keymap.set("n", "<leader>qa", ":QuartoActivate<cr>", { desc = "Activate Quarto" })
    --
    -- -- Code execution
    -- vim.keymap.set("n", "<leader>qrc", ":QuartoSendAbove<cr>", { desc = "Run code chunk" })
    -- vim.keymap.set("n", "<leader>qra", ":QuartoSendAll<cr>", { desc = "Run all chunks" })
    -- vim.keymap.set("v", "<leader>qr", ":QuartoSendRange<cr>", { desc = "Run visual selection" })
    --
    -- -- Navigation
    -- vim.keymap.set(
    --   "n",
    --   "]q",
    --   ":lua require'quarto.runner'.run_cell()<cr>",
    --   { desc = "Run cell and move to next" }
    -- )
    -- vim.keymap.set(
    --   "n",
    --   "[q",
    --   ":lua require'quarto.runner'.run_above()<cr>",
    --   { desc = "Run cell above" }
    -- )
  end,
}