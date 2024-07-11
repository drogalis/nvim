return {
	"smoka7/hop.nvim",
	version = "*",
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function()
		require("hop").setup({
			vim.keymap.set({ "n", "v" }, "s", "<cmd>HopLine<CR>"),
		})
		vim.api.nvim_set_keymap("o", "s", "V<cmd>HopLine<cr>", {})
	end,
}
