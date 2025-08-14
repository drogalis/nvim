local M = {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
	version = "*", -- use stable branch
}

function M.config()
	local keymap = vim.keymap.set

	require("trouble").setup()

	keymap("n", "<leader>x", "<cmd>Trouble<cr>", { silent = true, desc = "diagnostics for current buffer" })
end

return M
