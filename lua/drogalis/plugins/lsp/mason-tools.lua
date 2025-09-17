return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Formatters
        "black", -- Python
        "clang-format", -- C/C++
        "stylua", -- Lua
        "shfmt", -- Shell scripts
        "prettier", -- JSON, YAML, Markdown, etc.
        "latexindent", -- LaTeX
        "cmake-format", -- CMake
        "taplo", -- TOML

        -- Language servers (additional to mason-lspconfig)
        "pyright",
        "clangd",
       -- "neocmakelsp"
       -- "buildifier"
       -- "starlark-rust"
       -- "bash-language-server",
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      debounce_hours = 5, -- at least 5 hours between attempts
    })

    -- Auto-install missing tools when opening relevant files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "c", "cpp", "lua", "bash", "sh", "cmake" },
      callback = function()
        vim.defer_fn(function()
          vim.cmd("MasonToolsInstall")
        end, 1000)
      end,
    })
  end,
}