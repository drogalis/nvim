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
		autoreload = true,
		lang = {
			c = {
				coverage_file = "coverage/project-coverage.info",
			},
			cpp = {
				coverage_file = "coverage/project-coverage.info",
			},
		},
		highlights = {
			-- customize highlight groups created by the plugin
			covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
			uncovered = { fg = "#F07178" },
		},
		signs = {
			-- use your own highlight groups or text markers
			covered = { hl = "CoverageCovered", text = "▎" },
			uncovered = { hl = "CoverageUncovered", text = "▎" },
		},
	})

	keymap("n", "<leader>vl", function()
		require("coverage").load(true)
	end, { desc = "code coverage load/display" })
	keymap("n", "<leader>vs", function()
		require("coverage").summary()
	end, { desc = "code coverage summary" })
	keymap("n", "<leader>vt", function()
		require("coverage").toggle()
	end, { desc = "code coverage toggle signs" })
end

return M
