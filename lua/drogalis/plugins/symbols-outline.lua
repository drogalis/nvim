return {
	"simrat39/symbols-outline.nvim",
	config = function()
		require("symbols-outline").setup({})
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		map("n", "<F4>", "<Cmd>SymbolsOutline<CR>", opts)
	end,
}
