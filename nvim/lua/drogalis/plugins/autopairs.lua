local M = {
	"windwp/nvim-autopairs",
	dependencies = "nvim-treesitter",
	event = { "BufReadPost", "InsertEnter" },
}

function M.config()
	local npairs = require("nvim-autopairs")
	local nrule = require("nvim-autopairs.rule")
	local ncond = require("nvim-autopairs.conds")

	npairs.setup({
		check_ts = true,
	})
end

return M
