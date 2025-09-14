local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Import plugin configurations
    { import = "drogalis.plugins" },
    { import = "drogalis.plugins.lsp" },
   -- { import = "drogalis.plugins.jupyter" },
  },

  defaults = {
    lazy = false,
    version = false,
    cond = nil,
  },

  install = {
    missing = true,
  },

  diff = {
    cmd = "git",
  },

  checker = {
    enabled = true, -- Automatically check for plugin updates
    notify = false, -- Get notification when updates are found
  },

  change_detection = {
    enabled = true,
    notify = false, -- Don't notify about config changes
  },

  performance = {
    cache = {
      enabled = true,
    },
  },
  -- Debugging options
  debug = false,
})



