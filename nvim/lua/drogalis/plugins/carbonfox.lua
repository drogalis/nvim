return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("syntax enable")
		vim.cmd.colorscheme("carbonfox")
	end,
}
