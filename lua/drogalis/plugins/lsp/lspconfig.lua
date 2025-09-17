return {
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"hrsh7th/cmp-nvim-lsp", {
        "antosha417/nvim-lsp-file-operations",
        config = true
    }, {
        "folke/neodev.nvim",
        opts = {}
    }, {"p00f/clangd_extensions.nvim"}},
    opts = {
        servers = {
            clangd = {
                server = {
                    root_dir = function(...)
                        -- using a root .clang-format or .clang-tidy file messes up projects, so remove them
                        return require("lspconfig.util").root_pattern(".clangd", ".clang-tidy", ".clang-format",
                            "compile_commands.json", "compile_flags.txt", "configure.ac", ".git")(...)
                    end,
                    capabilities = {
                        offsetEncoding = {"utf-16"}
                    },
                    cmd = {"clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu",
                           "--completion-style=detailed", "--function-arg-placeholders", "--fallback-style=google",
                           "--enable-config", "--limit-results=50"},
                    init_options = {
                        compilationDatabasePath = "./build",
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true
                    }
                },
                extensions = {
                    inlay_hints = {
                        inline = false
                    },
                    ast = {
                        role_icons = {
                            type = "",
                            declaration = "",
                            expression = "",
                            specifier = "",
                            statement = "",
                            ["template argument"] = ""
                        },
                        kind_icons = {
                            Compound = "",
                            Recovery = "",
                            TranslationUnit = "",
                            PackExpansion = "",
                            TemplateTypeParm = "",
                            TemplateTemplateParm = "",
                            TemplateParamObject = ""
                        }
                    }
                }
            },
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "strict",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            autoImportCompletions = true
                        }
                    }
                }
            },
            bashls = {},
            cmake = {
                cmd = {"neocmakelsp", "--stdio"},
                filetypes = {"cmake"},
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern("CMakePresets.json", "CTestConfig.cmake", ".git",
                        "build", "cmake")(fname)
                end,
                single_file_support = true,
                init_options = {
                    format = {
                        enable = true
                    },
                    lint = {
                        enable = true
                    },
                    scan_cmake_in_package = true,
                    semantic_token = true
                },
                settings = {
                    cmake = {
                        buildDirectory = "build"
                    }
                }
            },
            starlark_rust = {
                cmd = {"starlark_lsp"},
                filetypes = {"starlark", "bzl", "bazel"},
                root_dir = function(fname)
                    return
                        require("lspconfig.util").root_pattern("WORKSPACE", "WORKSPACE.bazel", "MODULE.bazel", ".git")(
                            fname)
                end,
                single_file_support = true,
                settings = {
                    starlark = {
                        -- Enable all diagnostics
                        diagnostics = {
                            enable = true,
                            unused_variable = "warning",
                            unused_load = "warning",
                            undefined_variable = "error",
                            redefined_builtin = "warning"
                        },
                        hover = {
                            enable = true,
                            show_documentation = true
                        },
                        completion = {
                            enable = true,
                            enable_snippets = true,
                            auto_import = true
                        },
                        workspace = {
                            scan_bzl_files = true,
                            max_files = 1000
                        },
                        bazel = {
                            enable_bazel_builtins = true,
                            enable_build_file_support = true
                        }
                    }
                }
            },
            setup = {
                clangd = function(_, opts)
                    require("clangd_extensions").setup({
                        server = opts.server,
                        extensions = opts.extensions
                    })
                    return true
                end
            }
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- Enhanced capabilities with better snippets support
            local capabilities = cmp_nvim_lsp.default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Setup servers
            for server, config in pairs(opts.servers) do
                if opts.setup[server] then
                    if opts.setup[server](server, config) then
                        goto continue
                    end
                end

                -- Merge capabilities
                config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

                lspconfig[server].setup(config.server or config)
                ::continue::
            end

            -- Additional servers with simple setup
            lspconfig.texlab.setup({
                capabilities = capabilities
            })

            -- Switch between source and header files for C/C++
            local function switch_source_header()
                local current_file = vim.api.nvim_buf_get_name(0)
                local extensions = {
                    [".cpp"] = {".hpp", ".h"},
                    [".cc"] = {".hpp", ".h"},
                    [".c"] = {".h"},
                    [".h"] = {".cpp", ".cc", ".c"},
                    [".hpp"] = {".cpp", ".cc"}
                }

                local current_ext = current_file:match("%.%w+$")
                if not current_ext or not extensions[current_ext] then
                    vim.notify("Not a C/C++ source file", vim.log.levels.WARN)
                    return
                end

                local base_name = current_file:gsub("%.%w+$", "")
                for _, ext in ipairs(extensions[current_ext]) do
                    local target_file = base_name .. ext
                    if vim.fn.filereadable(target_file) == 1 then
                        vim.cmd("edit " .. target_file)
                        return
                    end
                end

                vim.notify("No corresponding header/source file found", vim.log.levels.WARN)
            end

            -- Enhanced LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = {
                        buffer = ev.buf,
                        silent = true
                    }
                    local keymap = vim.keymap

                    -- Navigation
                    keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, {
                        desc = "Show LSP references"
                    }))
                    keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, {
                        desc = "Show LSP definitions"
                    }))
                    keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>",
                        vim.tbl_extend("force", opts, {
                            desc = "Show LSP implementations"
                        }))
                    keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>",
                        vim.tbl_extend("force", opts, {
                            desc = "Show LSP type definitions"
                        }))
                    keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, {
                        desc = "Go to declaration"
                    }))

                    -- Actions
                    keymap.set({"n", "v"}, "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
                        desc = "See available code actions"
                    }))

                    -- Diagnostics
                    keymap.set("n", "<leader>lw", "<cmd>Telescope diagnostics<CR>", vim.tbl_extend("force", opts, {
                        desc = "Show workspace diagnostics"
                    }))
                    keymap.set("n", "<leader>lb", "<cmd>Telescope diagnostics bufnr=0<CR>",
                        vim.tbl_extend("force", opts, {
                            desc = "Show buffer diagnostics"
                        }))
                    keymap.set("n", "<leader>le", vim.diagnostic.open_float, vim.tbl_extend("force", opts, {
                        desc = "Show line diagnostics"
                    }))
                    keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, {
                        desc = "Go to previous diagnostic"
                    }))
                    keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, {
                        desc = "Go to next diagnostic"
                    }))

                    -- Documentation
                    keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
                        desc = "Show documentation"
                    }))
                    keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, {
                        desc = "Show signature help"
                    }))

                    -- Utilities
                    keymap.set("n", "<leader>ls", switch_source_header, vim.tbl_extend("force", opts, {
                        desc = "Switch source/header"
                    }))
                    keymap.set("n", "<leader>lrs", ":LspRestart<CR>", vim.tbl_extend("force", opts, {
                        desc = "Restart LSP"
                    }))

                    -- Clangd specific mappings
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.name == "clangd" then
                        keymap.set("n", "<leader>lh", function()
                            require("clangd_extensions.inlay_hints").set_inlay_hints()
                        end, vim.tbl_extend("force", opts, {
                            desc = "Enable inlay hints"
                        }))

                        keymap.set("n", "<leader>lH", function()
                            require("clangd_extensions.inlay_hints").disable_inlay_hints()
                        end, vim.tbl_extend("force", opts, {
                            desc = "Disable inlay hints"
                        }))

                        keymap.set("n", "<leader>lc", function()
                            require("clangd_extensions.ast").dump_ast()
                        end, vim.tbl_extend("force", opts, {
                            desc = "Dump AST"
                        }))
                    end
                end
            })

            -- Enhanced diagnostic configuration
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                    source = "if_many"
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = ""
                }
            })

            -- Change the Diagnostic symbols in the sign column (gutter)
            -- (not in youtube nvim video)
            local signs = {
                Error = " ",
                Warn = " ",
                Hint = "󰠠 ",
                Info = " "
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, {
                    text = icon,
                    texthl = hl,
                    numhl = ""
                })
            end
        end
    }
}
