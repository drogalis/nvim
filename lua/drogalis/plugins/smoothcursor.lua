return {
	"gen740/SmoothCursor.nvim",
	enabled = false,
	event = { "BufReadPre" },
	config = function()
		require("smoothcursor").setup({ fancy = { enable = true } })
	end,
}
