return {
	"https://git.sr.ht/~nedia/auto-save.nvim",
	event = { "BufReadPre" },
	opts = {
		events = { "InsertLeave", "BufLeave" },
		exclude_ft = { "nvim-tree" },
	},
}
