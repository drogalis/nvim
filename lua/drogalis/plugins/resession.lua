local function get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.trim(vim.fn.system("git branch --show-current"))
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end

return {
	"stevearc/resession.nvim",
	config = function()
		local resession = require("resession")
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Only load the session if nvim was started with no args
				if vim.fn.argc(-1) == 0 then
					-- Save these to a different directory, so our manual sessions don't get polluted
					resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
				end
			end,
			nested = true,
		})
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				-- Always save a special session named "last"
				resession.save(get_session_name(), { dir = "dirsession", notify = false })
			end,
		})
		resession.setup({
			autosave = {
				enabled = true,
				interval = 30,
				notify = false,
			},
		})
	end,
}
