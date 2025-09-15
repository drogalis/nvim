-- Enhanced treesitter configuration with additional languages and features

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
    },
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Core languages
          "bash",
          "c",
          "cmake", 
          "cpp",
          "lua",
          "python",
          
          -- Documentation and markup
          "comment",
          "markdown",
          "markdown_inline",
          "rst",
          "latex",
          "bibtex",
          "doxygen",
          
          -- Configuration and data
          "json",
          "json5",
          "jsonc",
          "yaml",
          "toml",
          "ini",
          "xml",
          
          -- Web technologies (useful for documentation)
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          
          -- Development tools
          "dockerfile",
          "git_config",
          "git_rebase", 
          "gitcommit",
          "gitignore",
          "make",
          "ninja",
          
          -- Query and regex
          "query",
          "regex",
          "jq",
          
          -- Other useful languages
          "go",
          "rust",
          "sql",
          "vim",
          "vimdoc",
          
          -- Protocols and formats
          "ssh_config",
          "pem",
        },
        
        sync_install = false,
        auto_install = true,
        
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "latex", "markdown" },
          disable = function(lang, buf)
            -- Disable for large files
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
          },
        },
        
        indent = {
          enable = true,
          disable = { "python", "yaml" }, -- These can be problematic
        },
        
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- Functions
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              
              -- Classes
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              
              -- Conditionals
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              
              -- Loops
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              
              -- Parameters
              ["ap"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
              
              -- Comments
              ["aC"] = "@comment.outer",
              ["iC"] = "@comment.inner",
              
              -- Blocks
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
          },
          
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]i"] = "@conditional.outer",
              ["]l"] = "@loop.outer",
              ["]p"] = "@parameter.inner",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]I"] = "@conditional.outer", 
              ["]L"] = "@loop.outer",
              ["]P"] = "@parameter.inner",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[i"] = "@conditional.outer",
              ["[l"] = "@loop.outer",
              ["[p"] = "@parameter.inner",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[I"] = "@conditional.outer",
              ["[L"] = "@loop.outer",
              ["[P"] = "@parameter.inner",
            },
          },
          
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sp"] = "@parameter.inner",
              ["<leader>sf"] = "@function.outer",
            },
            swap_previous = {
              ["<leader>sP"] = "@parameter.inner",
              ["<leader>sF"] = "@function.outer",
            },
          },
          
          lsp_interop = {
            enable = true,
            border = "rounded",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dc"] = "@class.outer",
            },
          },
        },
        
        endwise = {
          enable = true,
        },
        
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
        },
      })
      
      -- Configure treesitter context
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0, -- No limit
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor", -- Line used to calculate context
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
      
      -- Key mappings for treesitter context
      vim.keymap.set("n", "[t", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true, desc = "Go to context" })
    end,
  },
}