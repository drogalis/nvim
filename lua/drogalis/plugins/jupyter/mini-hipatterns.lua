return   {
    "echasnovski/mini.hipatterns",
    version = "*",
    ft = { "python", "ipynb", "markdown" },
    config = function()
      local hipatterns = require("mini.hipatterns")

      hipatterns.setup({
        highlighters = {
          -- Jupyter cell markers
          jupyter_cell = {
            pattern = "^# %%%%[^\r\n]*",
            group = "Delimiter",
          },
          jupyter_markdown = {
            pattern = "^```python[^\r\n]*",
            group = "Title",
          },
        },
      })
  end
}