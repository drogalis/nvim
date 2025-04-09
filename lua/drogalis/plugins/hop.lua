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
		vim.api.nvim_set_hl(0, "HopUnmatched", {bg="none", fg="none"})
		vim.api.nvim_set_hl(0, "FlashBackdrop", {bg="none", fg="none"})
	end,
}
