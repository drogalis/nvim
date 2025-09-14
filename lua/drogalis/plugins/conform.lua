return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- C/C++ formatting with Google style
        c = { "clang_format" },
        cpp = { "clang_format" },

        -- Python formatting with black and isort
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format", "ruff_organize_imports" }
          else
            return { "isort", "black" }
          end
        end,

        -- Lua formatting
        lua = { "stylua" },

        -- Shell script formatting
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },

        -- CMake formatting
        cmake = { "cmake_format" },

        -- LaTeX formatting
        tex = { "latexindent" },

        -- Web technologies (useful for docs)
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },

        -- Configuration files
        toml = { "taplo" },
      },

      formatters = {
        clang_format = {
          prepend_args = {
            "--style=Google",
            "--fallback-style=Google",
          },
        },
        black = {
          prepend_args = {
            "--line-length",
            "88",
            "--target-version",
            "py38",
          },
        },
        isort = {
          prepend_args = {
            "--profile",
            "black",
            "--multi-line",
            "3",
            "--line-length",
            "88",
          },
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        stylua = {
          prepend_args = {
            "--column-width",
            "100",
            "--line-endings",
            "Unix",
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
          },
        },
        cmake_format = {
          prepend_args = {
            "--line-width",
            "100",
            "--tab-size",
            "2",
          },
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })
  end,
}