local M = {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
    	require('Comment').setup()
    end
}
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment

return M
