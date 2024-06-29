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

	keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, desc = "diagnostics for current buffer" })
	keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, desc = "show lsp references" })
end

return M
