---@diagnostic disable: undefined-global
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.g.mapleader = ' '
vim.o.winborder = 'rounded'

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.keymap.set('n', '<Esc><Esc>', ':noh<CR>')
vim.keymap.set('v', 'K', '"+y')

vim.pack.add({
	{ src = 'https://github.com/vague2k/vague.nvim' },
	{ src = 'https://github.com/chomosuke/typst-preview.nvim' },
	{ src = 'https://github.com/echasnovski/mini.pick' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd('set completeopt+=noselect')


require 'mini.pick'.setup()
require 'oil'.setup()

vim.keymap.set('n', '<leader>f', ':Pick files show_hidden=true<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')


vim.lsp.enable({ 'lua_ls', 'svelte-language-server', 'tinymist' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd('colorscheme vague')
vim.cmd(':hi statusline guibg=NONE')
