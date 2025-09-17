return {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path", 
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            -- Use native snippet expansion in 0.11+
            if vim.fn.has("nvim-0.11") == 1 then
              vim.snippet.expand(args.body)
            end
          end,
        },

        mapping = {
			["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Tab>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
		},
  
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "nvim_lua", priority = 800 },
          { name = "path", priority = 750 },
        }, {
          { name = "buffer", keyword_length = 3, priority = 500 },
        }),
        
    formatting = {
      fields = { "abbr", "kind", "menu" },
    },
    view = {
      entries = {
        name = "custom",
        selection_order = "near_cursor",
      },
    },
        
        window = {
          completion = cmp.config.window.bordered({
            border = "single",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "single",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          }),
        },
      })
      
      -- Enhanced cmdline completion for 0.11+
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })
      
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end,
  }