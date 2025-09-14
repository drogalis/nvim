return {
  "Julian/lean.nvim",
  event = { "BufReadPre *.lean", "BufNewFile *.lean" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    lsp = {
      on_attach = function(client, bufnr)
        -- Enhanced Lean-specific keymaps
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set(
          "n",
          "<leader>Li",
          "<cmd>LeanInfoviewToggle<cr>",
          vim.tbl_extend("force", opts, { desc = "Toggle Lean infoview" })
        )
        vim.keymap.set(
          "n",
          "<leader>Lr",
          "<cmd>LeanRestartServer<cr>",
          vim.tbl_extend("force", opts, { desc = "Restart Lean server" })
        )
        vim.keymap.set(
          "n",
          "<leader>Ls",
          "<cmd>LeanGoal<cr>",
          vim.tbl_extend("force", opts, { desc = "Show current goal" })
        )
        vim.keymap.set(
          "n",
          "<leader>Lt",
          "<cmd>LeanTermGoal<cr>",
          vim.tbl_extend("force", opts, { desc = "Show term goal" })
        )

        -- Quick proof tactics
        vim.keymap.set(
          "i",
          "<M-s>",
          "sorry",
          vim.tbl_extend("force", opts, { desc = "Insert sorry" })
        )
        vim.keymap.set("i", "<M-r>", "rfl", vim.tbl_extend("force", opts, { desc = "Insert rfl" }))
        vim.keymap.set(
          "i",
          "<M-e>",
          "exact ",
          vim.tbl_extend("force", opts, { desc = "Insert exact" })
        )
        vim.keymap.set(
          "i",
          "<M-a>",
          "apply ",
          vim.tbl_extend("force", opts, { desc = "Insert apply" })
        )
        vim.keymap.set(
          "i",
          "<M-i>",
          "intro ",
          vim.tbl_extend("force", opts, { desc = "Insert intro" })
        )
        vim.keymap.set(
          "i",
          "<M-c>",
          "cases ",
          vim.tbl_extend("force", opts, { desc = "Insert cases" })
        )
        vim.keymap.set(
          "i",
          "<M-h>",
          "have : ",
          vim.tbl_extend("force", opts, { desc = "Insert have" })
        )
      end,
    },
    abbreviations = {
      enabled = true,
      leader = "\\", -- Use backslash for abbreviations like LaTeX
      extra = {
        -- Mathematical symbols
        ["α"] = "alpha",
        ["β"] = "beta",
        ["γ"] = "gamma",
        ["δ"] = "delta",
        ["ε"] = "epsilon",
        ["ζ"] = "zeta",
        ["η"] = "eta",
        ["θ"] = "theta",
        ["λ"] = "lambda",
        ["μ"] = "mu",
        ["π"] = "pi",
        ["ρ"] = "rho",
        ["σ"] = "sigma",
        ["τ"] = "tau",
        ["φ"] = "phi",
        ["χ"] = "chi",
        ["ψ"] = "psi",
        ["ω"] = "omega",
        ["∀"] = "forall",
        ["∃"] = "exists",
        ["∈"] = "mem",
        ["∉"] = "nmem",
        ["⊆"] = "subseteq",
        ["∩"] = "cap",
        ["∪"] = "cup",
        ["→"] = "to",
        ["↔"] = "iff",
        ["¬"] = "not",
        ["∧"] = "and",
        ["∨"] = "or",
        ["≤"] = "le",
        ["≥"] = "ge",
        ["≠"] = "ne",
        ["≈"] = "approx",
        ["∞"] = "infty",
        ["ℕ"] = "Nat",
        ["ℤ"] = "Int",
        ["ℚ"] = "Rat",
        ["ℝ"] = "Real",
        ["ℂ"] = "Complex",
      },
    },
    stderr = {
      enable = true,
      on_lines = function(lines)
        vim.notify(table.concat(lines, "\n"), vim.log.levels.WARN)
      end,
    },
    mappings = false, -- Use our custom mappings
    infoview = {
      autoopen = true,
      width = 50,
      height = 20,
      horizontal_position = "bottom",
      separate_tab = false,
      indicators = "auto",
    },
  },
  config = function(_, opts)
    -- Enhanced semantic token handling for Lean
    local semantic_tokens_handler = function(err, result, ctx, config)
      if err then
        return
      end
      if not result or not result.data then
        return
      end

      pcall(function()
        vim.lsp.semantic_tokens.on_full(err, result, ctx, config)
      end)
    end

    vim.lsp.handlers["textDocument/semanticTokens/full"] = semantic_tokens_handler
    require("lean").setup(opts)

    -- Lean-specific autocommands
    local lean_group = vim.api.nvim_create_augroup("LeanEnhanced", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = lean_group,
      pattern = "lean",
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.textwidth = 100
        vim.opt_local.colorcolumn = "101"
        vim.opt_local.spell = false -- Lean files don't need spell check
      end,
    })

    -- Prevent Infoview from appearing in buffer lists
    vim.api.nvim_create_autocmd("FileType", {
      group = lean_group,
      pattern = "leaninfo",
      callback = function()
        vim.bo.buflisted = false
        vim.bo.bufhidden = "hide"
        vim.bo.buftype = "nofile"
        vim.bo.modifiable = false
        vim.bo.swapfile = false
      end,
    })
  end,
}