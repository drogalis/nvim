return {
	"stevearc/aerial.nvim",
	config = function()
		require("aerial").setup({})
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		map("n", "<F4>", "<Cmd>AerialToggle!<CR>", opts)
	end,
}
