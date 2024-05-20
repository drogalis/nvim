local M = {
    'folke/trouble.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    event = 'LspAttach',
    version = '*', -- use stable branch
}

function M.config()
    local keymap = vim.keymap.set

    require('trouble').setup()

    keymap(
        'n',
        '<leader>xx',
        '<cmd>TroubleToggle document_diagnostics<cr>',
        { silent = true, desc = 'diagnostics for current buffer' }
    )
    keymap(
        'n',
        '<leader>xp',
        '<cmd>TroubleToggle<cr>',
        { silent = true, desc = 'diagnostics for complete project' }
    )
    keymap(
        'n',
        '<leader>xw',
        '<cmd>TroubleToggle workspace_diagnostics<cr>',
        { silent = true, desc = 'diagnostics for workspace' }
    )
    keymap(
        'n',
        '<leader>xl',
        '<cmd>TroubleToggle loclist<cr>',
        { silent = true, desc = 'diagnostics for location list' }
    )
    keymap(
        'n',
        '<leader>xq',
        '<cmd>TroubleToggle quickfix<cr>',
        { silent = true, desc = 'diagnostics for quickfix list' }
    )
    keymap(
        'n',
        'gR',
        '<cmd>TroubleToggle lsp_references<cr>',
        { silent = true, desc = 'show lsp references' }
    )
end

return M
