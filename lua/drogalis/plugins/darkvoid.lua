return {
	"Aliqyan-21/darkvoid.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("darkvoid").setup({
			transparent = true,
			colors = {
				line_nr = "#222222",
				string = "#7dabd1",
				visual = "#303030",
				comment = "#6b6b6b",
				func = "#84d999", -- 135, 100, 78
				kw = "#bfe8f2",
				identifier = "#e6e6e6",
				type = "#689ded", -- 188, 100, 78
				search_highlight = "#00bd6d",
				operator = "#00bd6b",
				bracket = "#e6e6e6",
				-- preprocessor = "#4b8902",
				bool = "#7dabd1",
				constant = "#7dabd1", -- 207, 100, 78

				-- gitsigns colors
				added = "#baffc9",
				changed = "#ffffba",
				removed = "#ffb3ba",

				error = "#dea6a0",
				warning = "#D0B8A8",
				hint = "#BEDC74",
				info = "#7FA1C3",
			},
		})
		vim.cmd("syntax enable")
		vim.cmd.colorscheme("darkvoid")
	end,
}
