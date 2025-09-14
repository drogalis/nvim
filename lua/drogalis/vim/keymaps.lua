vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<Enter>", function()
	local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
	local line = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, line, line, true, repeated)
end)
keymap.set("n", "|", function()
	local repeated = vim.fn["repeat"]({ "" }, vim.v.count1)
	local line = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, line - 1, line - 1, true, repeated)
end)

-- Add Helper Keys
keymap.set("n", ";", ":")
keymap.set("n", ".", ":w<CR>")

-- keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader><left>", "<C-w>h")
keymap.set("n", "<leader><right>", "<C-w>l")
keymap.set("n", "<leader><up>", "<C-w>k")
keymap.set("n", "<leader><down>", "<C-w>j")

keymap.set("n", "<leader>q", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>s<left>", [[<cmd>vertical resize +10<cr>]]) -- make the window biger vertically
keymap.set("n", "<leader>s<right>", [[<cmd>vertical resize -10<cr>]]) -- make the window smaller vertically
keymap.set("n", "<leader>s<up>", [[<cmd>horizontal resize +5<cr>]]) -- make the window bigger horizontally by pressing shift and =
keymap.set("n", "<leader>s<down>", [[<cmd>horizontal resize -5<cr>]]) -- make the window smaller horizontally by pressing shift and -

keymap.set({ "n", "v" }, "lv", function()
	vim.diagnostic.config({ virtual_text = true })
end)
keymap.set({ "n", "v" }, "lV", function()
	vim.diagnostic.config({ virtual_text = false })
end)
