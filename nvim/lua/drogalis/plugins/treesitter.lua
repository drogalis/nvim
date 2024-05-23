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
			"meson",
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
					["ac"] = "@comment.outer",
					["ic"] = "@comment.outer",
					["ao"] = "@class.outer",
					["io"] = "@class.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["nc"] = { query = "@class.outer", desc = "next class" },
					["nf"] = {
						query = "@function.outer",
						desc = "next function",
					},
					["np"] = {
						query = "@parameter.outer",
						desc = "next parameter",
					},
				},
				goto_previous_start = {
					["pc"] = { query = "@class.outer", desc = "prev class" },
					["pf"] = {
						query = "@function.outer",
						desc = "prev function",
					},
					["pp"] = {
						query = "@parameter.outer",
						desc = "prev parameter",
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
