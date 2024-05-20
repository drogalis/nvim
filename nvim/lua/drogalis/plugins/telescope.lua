return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>tsf", builtin.find_files, {})
      vim.keymap.set("n", "<leader>tsg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>tso", builtin.oldfiles, {})
      vim.keymap.set('n', '<leader>tst', builtin.git_files, {})
        
      require("telescope").load_extension("ui-select")
    end,
  },
}
