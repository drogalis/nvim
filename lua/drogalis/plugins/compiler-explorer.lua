return {
	"krady21/compiler-explorer.nvim",
	opts = {},
	config = function()
		vim.keymap.set({"n", "v"}, "<leader>cc", "<cmd>CECompile<CR>")
		vim.keymap.set("n", "<leader>cd", "<cmd>CEAddLibrary<CR>")
	end,
}
-- :CECompile	Compile the source code in the current buffer and dump assembly output to a new window. Also accepts a visual selection.	source code buffer
-- :CECompileLive	Same as :CECompile, but it will also try to recompile the source code every time the buffer is saved.	source code buffer
-- :CEAddLibrary	Add a library to be used by future calls of :CECompile.	source code buffer
-- :CELoadExample	Load an existing code example to a new tab.	any buffer
-- :CEOpenWebsite	Open the website using the source code and compilers from previous :CECompile calls.	any buffer
-- :CEDeleteCache	Clear the json cache where the compilers and languages are stored.	any buffer
-- :CEShowTooltip	Show information about a specific instruction under cursor.	assembly buffer
-- :CEGotoLabel	Jump to the label definition under cursor.	assembly buffer
