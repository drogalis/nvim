return   {
    "GCBallesteros/NotebookNavigator.nvim",
    version = "*", -- Use latest stable version
    dependencies = {
      "echasnovski/mini.comment",
      "Vigemus/iron.nvim",
      "echasnovski/mini.hipatterns", -- For cell highlighting
    },
    config = function()
      local nn = require("notebook-navigator")
      require("drogalis.plugins.jupyter.styling.autocommands").setup()
      require("drogalis.plugins.jupyter.styling.styling").setup()

      -- Basic NotebookNavigator setup
      nn.setup({
        -- No mappings here - all defined in which-key.lua
        activate_mapping = "",

        -- Cell markers define how cells are identified in different file types
        cell_markers = {
          -- Default Python marker
          python = "```python",
          -- For markdown: using the most common code block marker
          markdown = "```",
        },

        -- Use syntax highlighting with mini.hipatterns for better cell visualization
        syntax_highlight = true,

        -- Use mini.hipatterns to handle cell highlighting when available
        use_hipatterns = true,

        -- Highlight group for cell markers that integrates with our custom styling
        cell_highlight_group = "JupyterCellSeparator",

        -- Use Iron.nvim as the REPL provider
        repl_provider = "iron",

        -- No mappings here - all defined in which-key.lua
        mappings = {},
      })

      -- Load our autocommands module for FileType detection
      vim.defer_fn(function()
        local ok, autocommands = pcall(require, "neotex.plugins.text.jupyter.autocommands")
        if ok and type(autocommands) == "table" and autocommands.setup then
          autocommands.setup()
        end
      end, 50)

      -- Only load styling for open ipynb files to avoid unnecessary processing
      vim.defer_fn(function()
        -- Check if any ipynb files are open
        local any_ipynb = false
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local bufname = vim.api.nvim_buf_get_name(buf)
          if bufname:match("%.ipynb$") then
            any_ipynb = true
            break
          end
        end

        -- If we have open ipynb files, load and apply styling
        if any_ipynb then
          local ok, styling = pcall(require, "neotex.plugins.text.jupyter.styling")
          if ok and type(styling) == "table" and styling.setup then
            styling.setup()
          end
        end
      end, 100)
    end,
  }