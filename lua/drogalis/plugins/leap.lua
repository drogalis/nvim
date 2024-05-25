return {
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
		config = function()
			local leap = require("leap")
			leap.add_default_mappings(true)
			leap.opts.case_sensitive = true
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
	{
		"ggandor/flit.nvim",
		config = function()
			require("flit").setup({})
		end,
	},
}
