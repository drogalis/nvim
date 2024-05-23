local M = {
	"andythigpen/nvim-coverage",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "BufReadPost",
}

function M.config()
	local keymap = vim.keymap.set

	require("coverage").setup({
		commands = true,
		autoreload = true,
	})

	keymap("n", "<leader>vl", function()
		require("coverage").load(true)
	end, { desc = "code coverage load/display" })
	keymap("n", "<leader>vs", function()
		require("coverage").summary()
	end, { desc = "code coverage summary" })
	keymap("n", "<leader>vt", function()
		require("coverage").toggle()
	end, { desc = "code coverage toggle" })
end

return M
