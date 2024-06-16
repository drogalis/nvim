return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			{ transparent = true },
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "#000000",
						},
					},
				},
			},
		})
		vim.cmd("syntax enable")
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
