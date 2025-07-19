return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			auto_save_enabled = true,
			auto_restore_enabled = true,
			cwd_change_handling = {
				restore_upcoming_session = true, -- Disabled by default, set to true to enable
			},
		})
		vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
			noremap = true,
		})
	end,
}
