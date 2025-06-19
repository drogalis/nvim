return {
	"https://git.sr.ht/~nedia/auto-save.nvim",
    -- enabled = false,
	event = { "BufReadPre" },
	opts = {
		events = { "InsertLeave", "TextChanged", "BufLeave" },
		exclude_ft = { "nvim-tree" },
	},
}
