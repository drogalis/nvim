return {
  "lervag/vimtex",
  ft = { "tex", "plaintex", "bib" },
  init = function()
    -- Viewer settings
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_view_sioyek_options = "--new-window"
    vim.g.vimtex_context_pdf_viewer = "okular"

    -- Compiler settings
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "build",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      hooks = {},
      options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-shell-escape", -- For minted, tikz externalization, etc.
      },
    }

    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_log_ignore = {
      "Underfull",
      "Overfull",
      "specifier changed to",
      "Token not allowed in a PDF string",
      "Marginpar on page",
      "Font shape",
    }

    -- Formatting and indentation
    vim.g.vimtex_format_enabled = 1
    vim.g.vimtex_indent_enabled = 1
    vim.g.vimtex_indent_conditionals = {}

    -- Enhanced syntax and concealment
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      spacing = 0,
      greek = 1,
      math_bounds = 1,
      math_delimiters = 1,
      math_fracs = 1,
      math_super_sub = 1,
      math_symbols = 1,
      sections = 0,
      styles = 1,
    }

    -- Disable default mappings - we'll create our own
    vim.g.vimtex_mappings_enabled = 0
    vim.g.tex_flavor = "latex"

    -- Enhanced completion
    vim.g.vimtex_complete_enabled = 1
    vim.g.vimtex_complete_close_braces = 1
    vim.g.vimtex_complete_ignore_case = 1
    vim.g.vimtex_complete_smart_case = 1
  end,
  config = function()
    -- Custom VimTeX keymaps
    local function set_tex_keymap(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = true, desc = desc })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        -- Compilation
        set_tex_keymap("<leader>ll", "<cmd>VimtexCompile<cr>", "Start/stop compilation")
        set_tex_keymap("<leader>lc", "<cmd>VimtexClean<cr>", "Clean auxiliary files")
        set_tex_keymap("<leader>lC", "<cmd>VimtexClean!<cr>", "Clean all files")

        -- Viewing
        set_tex_keymap("<leader>lv", "<cmd>VimtexView<cr>", "View PDF")
        set_tex_keymap("<leader>lr", "<cmd>VimtexReload<cr>", "Reload VimTeX")

        -- Navigation
        set_tex_keymap("<leader>lt", "<cmd>VimtexTocToggle<cr>", "Toggle TOC")
        set_tex_keymap("<leader>lT", "<cmd>VimtexTocOpen<cr>", "Open TOC")

        -- Errors and logs
        set_tex_keymap("<leader>le", "<cmd>VimtexErrors<cr>", "Show errors")
        set_tex_keymap("<leader>lo", "<cmd>VimtexCompileOutput<cr>", "Show output")
        set_tex_keymap("<leader>lg", "<cmd>VimtexStatus<cr>", "Show status")

        -- Text objects and motions (these work in all modes)
        vim.keymap.set({ "n", "x", "o" }, "tsE", "<plug>(vimtex-env)", { buffer = true })
        vim.keymap.set({ "n", "x", "o" }, "tse", "<plug>(vimtex-env)", { buffer = true })
        vim.keymap.set({ "n", "x", "o" }, "ts$", "<plug>(vimtex-math)", { buffer = true })
        vim.keymap.set({ "n", "x", "o" }, "tsd", "<plug>(vimtex-delim)", { buffer = true })

        -- Quick math mode insertion
        vim.keymap.set("i", "$$", "$$<left>", { buffer = true, desc = "Insert inline math" })
        vim.keymap.set(
          "i",
          "<M-m>",
          "\\[\\]<left><left><cr><cr><up>",
          { buffer = true, desc = "Insert display math" }
        )

        -- Buffer-specific settings
        vim.opt_local.conceallevel = 2
        vim.opt_local.textwidth = 80
        vim.opt_local.colorcolumn = "81"
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
      end,
    })
  end,
}