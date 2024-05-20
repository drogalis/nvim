local M = {
    'andythigpen/nvim-coverage',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    event = 'BufReadPost',
}

function M.config()
    local keymap = vim.keymap.set

    require('coverage').setup({
        commands = false,
        autoreload = true,
    })

    keymap('n', '<leader>cl', function()
        require('coverage').load(true)
    end, { desc = 'code coverage load/display' })
    keymap('n', '<leader>cs', function()
        require('coverage').summary()
    end, { desc = 'code coverage summary' })
    keymap('n', '<leader>ct', function()
        require('coverage').toggle()
    end, { desc = 'code coverage toggle' })
end

return M
