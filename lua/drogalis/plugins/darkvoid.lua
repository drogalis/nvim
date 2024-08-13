return {
	"Aliqyan-21/darkvoid.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("darkvoid").setup({
			transparent = true,
			colors = {
				line_nr = "#222222",
				string = "#b0dbff",
				visual = "#303030",
				comment = "#585858",
				func = "#b0ffc4", -- 135, 100, 78
				kw = "#8ff0ff",
				identifier = "#e6e6e6",
				type = "#00a8b8", -- 188, 100, 78
				-- search_highlight = "#1bfd9c",
				-- operator = "#1bfd9c",
				bracket = "#e6e6e6",
				-- preprocessor = "#4b8902",
				bool = "#b0dbff",
				constant = "#b0dbff", -- 207, 100, 78

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
