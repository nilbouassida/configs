---@diagnostic disable: undefined-global
local startup_dir = vim.fn.getcwd()

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.swapfile = false
vim.g.mapleader = ' '
vim.o.winborder = 'rounded'

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>k', ':quit!<CR>')

vim.keymap.set('n', '<Ctr>k', ':quit!<CR>')
vim.keymap.set('n', '<leader>k', ':quit!<CR>')

vim.keymap.set('n', '<Esc><Esc>', ':noh<CR>')
vim.keymap.set('v', 'K', '"+y')

-- comment out selected text
vim.keymap.set('x', '<leader>/', function()
    local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'x', false)
    local cs = vim.bo.commentstring:gsub('%%s', '')
    vim.cmd("'<,'>normal! I" .. cs)
end)


vim.pack.add({
    { src = 'https://github.com/vague2k/vague.nvim' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/echasnovski/mini.completion' },
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end,
})
vim.cmd('set completeopt+=noselect')

vim.lsp.enable({ 'lua_ls', 'svelte-language-server', 'tinymist', 'clangd' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)




require 'mini.pick'.setup()
require 'oil'.setup()

vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files show_hidden=true<CR>')
-- vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>h', function()
    -- Change to startup directory temporarily
    local current_dir = vim.fn.getcwd()
    vim.cmd('cd ' .. startup_dir)

    -- Get all files recursively, ignoring git
    local files = vim.split(vim.fn.glob('**/*'), '\n')
    files = vim.tbl_filter(function(file)
        return vim.fn.isdirectory(file) == 0 and not file:match('%.git/')
    end, files)

    require('mini.pick').start({
        source = { items = files, name = 'Files' }
    })

    -- Restore original directory
    vim.cmd('cd ' .. current_dir)
end)


vim.cmd('colorscheme vague')
vim.cmd(':hi statusline guibg=NONE')
