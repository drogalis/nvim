local M = {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
    	require('Comment').setup()
    end
}

return M
