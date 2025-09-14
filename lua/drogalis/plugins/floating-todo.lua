return {
  "drogalis/floatingtodo.nvim",
  config = function()
    require("floatingtodo").setup({
      target_file = "~/todo.md",
      border = "rounded",
      height = 0.5,
      position = "center", -- topleft, topright, bottomleft, bottomright
    })
    vim.keymap.set("n", "q", ":Td<CR>", { silent = true })
  end,
}