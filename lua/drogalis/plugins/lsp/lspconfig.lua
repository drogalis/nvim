return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		{ "p00f/clangd_extensions.nvim" },
	},
	opts = {
		servers = {
			clangd = {
				server = {
					root_dir = function(...)
						-- using a root .clang-format or .clang-tidy file messes up projects, so remove them
						return require("lspconfig.util").root_pattern(
							".clangd",
							".clang-tidy",
							".clang-format",
							"compile_commands.json",
							"compile_flags.txt",
							"configure.ac",
							".git"
						)(...)
					end,
					capabilities = {
						-- offsetEncoding = { "utf-16" },
					},
					cmd = {
						"/usr/bin/clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						compilationDatabasePath = "./build",
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
				extensions = {
					inlay_hints = {
						inline = false,
					},
					ast = {
						--These require codicons (https://github.com/microsoft/vscode-codicons)
						role_icons = {
							type = "",
							declaration = "",
							expression = "",
							specifier = "",
							statement = "",
							["template argument"] = "",
						},
						kind_icons = {
							Compound = "",
							Recovery = "",
							TranslationUnit = "",
							PackExpansion = "",
							TemplateTypeParm = "",
							TemplateTemplateParm = "",
							TemplateParamObject = "",
						},
					},
				},
			},
		},
		setup = {
			clangd = function(_, opts)
				require("clangd_extensions").setup({
					server = opts.server,
					extensions = opts.extensions,
				})
				return true
			end,
		},
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		local util = require("lspconfig.util")

		-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
		local function switch_source_header()
			local bufnr = 0
			bufnr = util.validate_bufnr(bufnr)
			local clangd_client = util.get_active_client_by_name(bufnr, "clangd")
			local params = { uri = vim.uri_from_bufnr(bufnr) }
			if clangd_client then
				clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
					if err then
						error(tostring(err))
					end
					if not result then
						print("Corresponding file cannot be determined")
						return
					end
					vim.api.nvim_command("edit " .. vim.uri_to_fname(result))
				end, bufnr)
			else
				print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
			end
		end

		lspconfig.bashls.setup({})
		lspconfig.cmake.setup({
			cmd = { "neocmakelsp" },
			filetypes = { "cmake", "CMakeLists.txt" },
			init_options = { buildDirectory = "build" },
			single_file_support = true,
		})
		lspconfig.pyright.setup({})

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Switch to Header"
				keymap.set("n", "<leader>ls", switch_source_header, opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "<leader>ldt", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>ldD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>ldd", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "<leader>lpd", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "<leader>lnd", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>lrs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
