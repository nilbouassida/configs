---@diagnostic disable: undefined-global
-- basic settings
vim.o.number             = true
vim.o.relativenumber     = true
vim.o.signcolumn         = 'yes'
vim.o.wrap               = false
vim.o.tabstop            = 4
vim.o.expandtab          = true
vim.o.shiftwidth         = 4
vim.opt.softtabstop      = 4
vim.o.swapfile           = false
vim.g.mapleader          = ' '
vim.o.winborder          = 'rounded'
vim.opt.ignorecase       = true
vim.opt.incsearch        = true
vim.opt.hlsearch         = true
vim.opt.smartcase        = true
vim.opt.wildmode         = 'longest:list,full'

-- for nvim-tree
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors    = true

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':wq<CR>')
vim.keymap.set('n', '<leader>k', ':quit!<CR>')

vim.keymap.set('n', '<Esc><Esc>', ':noh<CR>')
vim.keymap.set('v', 'K', '"+y<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.api.nvim_set_keymap('n', '<leader>a', 'ggVG', { noremap = true, silent = true, desc = 'Select entire document' })

vim.pack.add({

    -- file stuff
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },

    { src = 'https://github.com/jreybert/vimagit' },
    { src = 'https://github.com/echasnovski/mini.nvim' },

    { src = 'https://github.com/neovim/nvim-lspconfig' },

    -- snippets / lsp
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-path' },

    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/vague2k/vague.nvim' },
    { src = 'https://github.com/junegunn/goyo.vim' },
})


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "nvim-treesitter.configs".setup({
    ensure_installed = {
        "bash",
        "c", "cpp",
        "css", "html",
        "javascript", "typescript",
        "lua",
        "markdown", "markdown_inline",
        "python",
        "rust",
        "svelte"
    },
    highlight = { enable = true }
})
require "oil".setup()
require 'nvim-tree'.setup()




-- =========================================================================
-- custom snippet stuff
-- =========================================================================
local ls  = require('luasnip')
local cmp = require('cmp')

require('luasnip.loaders.from_lua').lazy_load({
    paths = vim.fn.stdpath('config') .. '/lua/snippets',
})

ls.config.set_config({
    history      = true,
    updateevents = 'TextChanged,TextChangedI',
})

cmp.setup({

    autocomplete = {
        cmp.TriggerEvent.TextChanged, -- every keystroke in Insert mode
        cmp.TriggerEvent.InsertEnter, -- when entering Insert mode
    },

    snippet = { -- tell cmp how to expand a snippet returned from its sources
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then               -- menu open → next item
                cmp.select_next_item()
            elseif ls.expand_or_jumpable() then -- in snippet → jump / expand
                ls.expand_or_jump()
            else
                fallback() -- plain Tab
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then       -- menu open → prev item
                cmp.select_prev_item()
            elseif ls.jumpable(-1) then -- in snippet backward
                ls.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'path' },
    }),
})

-- =========================================================================
--  LSP stuff
-- =========================================================================
local lsp          = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local servers      = {
    'clangd', 'ts_ls', 'pyright', 'asm_lsp',
    'lua_ls', 'biome', 'emmet_ls',
}
for _, name in ipairs(servers) do
    lsp[name].setup({ capabilities = capabilities })
end


-- Completion menu settings
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append('c')

local function t(keys) return vim.api.nvim_replace_termcodes(keys, true, true, true) end
vim.keymap.set('i', '<C-n>', function() return vim.fn.pumvisible() == 1 and t '<C-n>' or '' end, { expr = true })
vim.keymap.set('i', '<C-p>', function() return vim.fn.pumvisible() == 1 and t '<C-p>' or '' end, { expr = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')


-- mappings for plugins
vim.keymap.set('n', '<leader>G', ':Goyo | set linebreak<CR> :hi statusline guibg=NONE<CR>')
vim.keymap.set('n', '<leader>g', ':Magit<CR>')
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = 'tree' })
vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = 'tree' })
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
-- vim.keymap.set('n', '<leader>t', ":Oil<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.lsp.enable({ "lua_ls", "biome", "tinymist", "emmetls", "clangd", "tsserver", "pyright", "asm_lsp" })

require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")



local function create_autoclose_mappings()
    local bracket_pairs = {
        ['('] = ')',
        ['['] = ']',
        ['{'] = '}',
        ["'"] = "'",
        ['"'] = '"',
        ['`'] = '`',
    }

    for open, close in pairs(bracket_pairs) do
        vim.keymap.set('i', open, function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local next_char = line:sub(col + 1, col + 1)

            -- Check if we're at end of line or next character is closing pair
            if col >= #line or next_char:match('%s') or next_char == close then
                return open .. close .. '<Left>'
            else
                return open
            end
        end, { expr = true, noremap = true })
    end

    -- Special handling for Enter key in brackets
    vim.keymap.set('i', '<CR>', function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local prev_char = line:sub(col, col)
        local next_char = line:sub(col + 1, col + 1)

        if (prev_char == '(' and next_char == ')') or
            (prev_char == '[' and next_char == ']') or
            (prev_char == '{' and next_char == '}') then
            return '<CR><Esc>O'
        else
            return '<CR>'
        end
    end, { expr = true, noremap = true })
end

create_autoclose_mappings()

-- better switch between vim splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
