return {
    "stevearc/conform.nvim",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- C/C++ formatting with Google style
                c = {"clang_format"},
                cpp = {"clang_format"},
                python = {"black"},

                -- Lua formatting
                lua = {"stylua"},

                -- Shell script formatting
                sh = {"shfmt"},
                bash = {"shfmt"},
                zsh = {"shfmt"},

                -- CMake formatting
                cmake = {"cmake_format"},

                -- LaTeX formatting
                tex = {"latexindent"},

                -- Web technologies (useful for docs)
                javascript = {"prettier"},
                typescript = {"prettier"},
                json = {"prettier"},
                jsonc = {"prettier"},
                yaml = {"prettier"},
                markdown = {"prettier"},
                html = {"prettier"},
                css = {"prettier"},
                scss = {"prettier"},
                bzl = {"buildifier"},
                bazel = {"buildifier"},
                starlark = {"buildifier"},

                -- Configuration files
                toml = {"taplo"}
            },

            formatters = {
                black = {
                    prepend_args = {"--line-length", "88", "--target-version", "py38"}
                },
                shfmt = {
                    prepend_args = {"-i", "2", "-ci"}
                },
                stylua = {
                    prepend_args = {"--column-width", "100", "--line-endings", "Unix", "--indent-type", "Spaces",
                                    "--indent-width", "2"}
                }
            },
            buildifier = {
                command = "buildifier",
                args = {"--mode=fix", "--lint=fix", -- Enable linting and auto-fix
                "--type=auto", -- Auto-detect file type
                "--tabsize=4", -- Use 4-space indentation (adjust as needed)
                "--warnings=all", -- Enable all warnings
                "$FILENAME"},
                stdin = false, -- buildifier works with files, not stdin
                cwd = require("conform.util").root_file({"WORKSPACE", "WORKSPACE.bazel", "MODULE.bazel", ".git"}),
                exit_codes = {0},
                -- Environment variables
                env = {}
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000
            }
        })
    end
}
