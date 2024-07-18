return {
	"SmiteshP/nvim-navbuddy",
	config = function()
		local navbuddy = require("nvim-navbuddy")
		vim.keymap.set("n", "<leader>nb", "<cmd>Navbuddy<CR>", {})
	end,
}
