local M = {
    'danymat/neogen',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    event = 'FileType',
    version = '*',
}

function M.config()
    require('neogen').setup({
        enabled = true,
        input_after_comment = true,
    })

    vim.keymap.set('n', '<leader>com', function()
        require('neogen').generate()
    end, { silent = true, desc = 'document function' })
end

return M
