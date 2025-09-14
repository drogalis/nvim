return {
  "benlubas/molten-nvim",
  version = "^1.0.0",
  dependencies = { "3rd/image.nvim" },
  build = ":UpdateRemotePlugins",
  init = function()
    vim.g.molten_image_provider = "image.nvim"
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = false
    vim.g.molten_wrap_output = true
    vim.g.molten_virt_text_output = true
    vim.g.molten_virt_lines_off_by_1 = true
  end,
  ft = { "quarto", "markdown", "python" },
 -- config = function()
    -- Molten keymaps
   -- vim.keymap.set("n", "<leader>mi", ":MoltenInit<cr>", { desc = "Initialize Molten" })
   -- vim.keymap.set("n", "<leader>me", ":MoltenEvaluateOperator<cr>", { desc = "Evaluate operator" })
   -- vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<cr>", { desc = "Evaluate line" })
  --  vim.keymap.set(
  --    "v",
  --    "<leader>mr",
   --   ":<C-u>MoltenEvaluateVisual<cr>gv",
   --   { desc = "Evaluate visual selection" }
 --   )
 --   vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<cr>", { desc = "Re-evaluate cell" })
 --   vim.keymap.set("n", "<leader>md", ":MoltenDelete<cr>", { desc = "Delete Molten cell" })
 --   vim.keymap.set("n", "<leader>mo", ":MoltenShowOutput<cr>", { desc = "Show output" })
--    vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<cr>", { desc = "Hide output" })
--  end,
}