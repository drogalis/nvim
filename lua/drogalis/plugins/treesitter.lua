local treesitter_setup = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"comment",
			"cpp",
			"css",
			"diff",
			"dockerfile",
			"doxygen",
			"git_config",
			"git_rebase",
			"gitcommit",
			"gitignore",
			"go",
			"gomod",
			"gosum",
			"html",
			"ini",
			"jq",
			"javascript",
			"json",
			"json5",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"norg",
			"objdump",
			"pem",
			"php",
			"python",
			"qmljs",
			"query",
			"regex",
			"rust",
			"rst",
			"scss",
			"sql",
			"ssh_config",
			"strace",
			"toml",
			"vim",
			"vimdoc",
			"yaml",
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
		},
		indent = {
			-- This will set 'indentexpr' and overwrite smartindent/cindent
			enable = true,
		},
		textobjects = {
			enable = true,
			select = {
				enable = true,
				keymaps = {
					["ai"] = "@conditional.outer",
					["ii"] = "@conditional.outer",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["<leader>nc"] = { query = "@class.outer", desc = "next class" },
					["<leader>nf"] = {
						query = "@function.outer",
						desc = "next function",
					},
					["<leader>ni"] = {
						query = "@conditional.outer",
						desc = "next conditional",
					},
					["<leader>nl"] = {
						query = "@loop.outer",
						desc = "next loop",
					},
				},
				goto_previous_start = {
					["<leader>pc"] = { query = "@class.outer", desc = "prev class" },
					["<leader>pf"] = {
						query = "@function.outer",
						desc = "prev function",
					},
					["<leader>pi"] = {
						query = "@conditional.outer",
						desc = "prev loop",
					},
					["<leader>pl"] = {
						query = "@loop.outer",
						desc = "prev loop",
					},
				},
			},
		},
		endwise = {
			enable = true,
		},
	})
end

local M = {
	-- Use :InspectTree with neovim >= 0.9
	-- {
	--     'nvim-treesitter/playground',
	--     cmd = 'TSPlaygroundToggle',
	--     cond = require('utils').have_compiler,
	-- },
	{
		"nvim-treesitter/nvim-treesitter",
		cond = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-endwise",
		},
		event = "FileType",
		build = function()
			vim.cmd("TSUpdate")
		end,
		config = treesitter_setup,
	},
}

return M
