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
				pickers = {

find_files = {

hidden = true

}

},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set(
				"n",
				"<leader>sf",
				builtin.find_files,
				{}
			)
			vim.keymap.set("n", "<leader>st", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>so", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>sg", builtin.git_files, {})

			require("telescope").load_extension("ui-select")
		end,
	},
}
