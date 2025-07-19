return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		require("bufferline").setup{}
		vim.keymap.set("n", "<leader>b", ":BufferLinePick<CR>")
	end,
}
