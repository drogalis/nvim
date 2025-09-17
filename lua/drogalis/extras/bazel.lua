return {
  "alexander-born/bazel.vim",
  ft = { "bzl", "bazel", "starlark" },
  config = function()
    -- Enhanced Bazel file detection
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.bzl", "*.bazel", "BUILD", "BUILD.*", "WORKSPACE", "WORKSPACE.*" },
      callback = function()
        vim.bo.filetype = "bzl"
      end,
    })
  end,
}