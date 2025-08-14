return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			keymaps = {
				["<C-h>"] = false,
				["<M-h>"] = "actions.select_split",
			},
			view_options = {
				show_hidden = true,
			},
			watch_for_changes = true,
			skip_confirm_for_simple_edits = true,
		})
		vim.keymap.set("n", "r", "<CMD>Oil<CR>")
	end,
}
