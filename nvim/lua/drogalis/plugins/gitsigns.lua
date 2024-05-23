local M = {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- VeryLazy hides splash screen
	event = "BufReadPost",
	version = "*", -- use stable branch
}

function M.config()
	require("gitsigns").setup({
		signs = {
			add = { text = "▍" },
			change = { text = "▍" },
			changedelete = { text = "█" },
			delete = { text = "▁" },
			topdelete = { text = "▔" },
		},

		watch_gitdir = { interval = 1000 },
		preview_config = { border = "rounded" },
		diff_opts = { internal = true },

		current_line_blame_formatter = "<author_time:%Y>, <author> - <summary>",

		sign_priority = 4, -- Lower priorirty means diag signs supercede

		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function keymap(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			keymap("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "next hunk" })

			keymap("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, {
				buffer = true,
				expr = true,
				desc = "previous hunk",
			})

			-- Actions
			keymap({ "n", "v" }, "<leader>is", '<cmd>lua require("gitsigns").stage_hunk()<CR>', { desc = "stage hunk" })
			keymap(
				{ "n", "v" },
				"<leader>ir",
				'<cmd>lua require("gitsigns").reset_hunk()<CR>',
				{ desc = "reset hunk (git)" }
			)
			keymap(
				"n",
				"<leader>iS",
				'<cmd>lua require("gitsigns").stage_buffer()<CR>',
				{ desc = "stage buffer (git)" }
			)
			keymap(
				"n",
				"<leader>iu",
				'<cmd>lua require("gitsigns").undo_stage_hunk()<CR>',
				{ desc = "unstage hunk (git)" }
			)
			keymap("n", "<leader>iR", '<cmd>lua require("gitsigns").reset_buffer()<CR>', { desc = "reset hunk (git)" })
			keymap(
				"n",
				"<leader>ip",
				'<cmd>lua require("gitsigns").preview_hunk()<CR>',
				{ desc = "preview hunk (git)" }
			)
			keymap(
				"n",
				"<leader>ib",
				'<cmd>lua require("gitsigns").blame_line({full=true})<CR>',
				{ desc = "blame/annotate (git)" }
			)
			keymap(
				"n",
				"<leader>iB",
				'<cmd>lua require("gitsigns").toggle_current_line_blame()<CR>',
				{ desc = "toogle line blame (git)" }
			)
			keymap(
				"n",
				"<leader>id",
				'<cmd>lua require("gitsigns").diffthis()<CR>',
				{ desc = "diff against last commit (git)" }
			)
			keymap(
				"n",
				"<leader>iD",
				'<cmd>lua require("gitsigns").diffthis("~1")<CR>',
				{ desc = "diff against last commit (git)" }
			)
			keymap(
				"n",
				"<leader>itd",
				'<cmd>lua require("gitsigns").toggle_word_diff()<CR>',
				{ desc = "toggle word diff (git)" }
			)
			keymap(
				"n",
				"<leader>ix",
				'<cmd>lua require("gitsigns").toggle_deleted()<CR>',
				{ desc = "toggle deleted (git)" }
			)

			-- Text object
			keymap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select hunk (git)" })
		end,
	})
end

return M
