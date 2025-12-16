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
vim.opt.winborder        = 'rounded'
vim.opt.ignorecase       = true
vim.opt.incsearch        = true
vim.opt.hlsearch         = true
vim.opt.smartcase        = true
vim.opt.wildmode         = 'longest:list,full'
vim.opt.list             = true

-- for nvim-tree
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors    = true

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>u', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
vim.keymap.set('n', '<leader>r', ':!make -C build<CR>')

vim.keymap.set('n', '<Esc><Esc>', ':noh<CR>')
vim.keymap.set('v', 'K', '"+y<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.api.nvim_set_keymap('n', '<leader>a', 'ggVG', { noremap = true, silent = true, desc = 'Select entire document' })

vim.pack.add({

    -- file stuff
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    -- { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },

    -- autoclose bracket
    { src = 'https://github.com/m4xshen/autoclose.nvim' },

    { src = 'https://github.com/jreybert/vimagit' },
    { src = 'https://github.com/echasnovski/mini.nvim' },


    -- snippets / lsp
    { src = 'https://github.com/neovim/nvim-lspconfig' },

    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
    { src = 'https://github.com/saecki/crates.nvim' },

    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/vague2k/vague.nvim' },
    { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
    { src = 'https://github.com/junegunn/goyo.vim' },

    -- tabs
    -- { src = 'https://github.com/romgrk/barbar.nvim' },
})




-----------------------
--- tabs
-----------------------
-- vim.g.barbar_auto_setup = false
-- require('barbar').setup({
--   animation = true,
--   auto_hide = false,
--   tabpages = true,
--   clickable = true,
-- })
--
-- vim.keymap.set('n', '<A-,>', ':BufferPrevious<CR>')
-- vim.keymap.set('n', '<A-.>', ':BufferNext<CR>')
--
-- vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
-- vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
--
-- vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')
--
-- vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>')
--
-- vim.keymap.set('n', '<A-x>', '<Cmd>BufferCloseAllButCurrent<CR>')
-- for i = 1, 9 do
--   vim.keymap.set('n', '<A-'..i..'>', '<Cmd>BufferGoto '..i..'<CR>')
-- end

-----------------------
--- LSP
-----------------------
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd("set completeopt+=noselect")

require("autoclose").setup()

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
-- require "oil".setup()
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require('crates').setup({
    lsp = {
        enabled = true,    -- use the in-process LSP
        actions = true,    -- code actions in Cargo.toml
        completion = true, -- completion via LSP (works with your existing nvim-cmp + nvim_lsp source)
        hover = true,      -- K to show crate info (or your hover key)
    },
})



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
    'lua_ls', 'biome', 'emmet_ls', 'rust_analyzer',
}
for _, name in ipairs(servers) do
    lsp[name].setup({ capabilities = capabilities })
end

lsp.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = true,
            check = { command = 'clippy' },
            diagnostics = { experimental = { enable = true } },
        },
    },
})

-- Inlay hints when rust-analyzer attaches (works on 0.10+ and nightlies)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('RustInlayHints', { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= 'rust_analyzer' then return end

        local ih = vim.lsp.inlay_hint
        if not ih then return end

        if type(ih) == 'function' then
            -- Neovim 0.10 style
            pcall(ih, args.buf, true)
        elseif type(ih) == 'table' and ih.enable then
            -- Newer nightlies
            -- Try both known call shapes without crashing
            if not pcall(ih.enable, args.buf, true) then
                pcall(ih.enable, true, { bufnr = args.buf })
            end
        end
    end,
})

-- Format Rust buffers on save (rustfmt via LSP)
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.rs',
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- Completion menu settings
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append('c')

local function t(keys) return vim.api.nvim_replace_termcodes(keys, true, true, true) end
vim.keymap.set('i', '<C-n>', function() return vim.fn.pumvisible() == 1 and t '<C-n>' or '' end, { expr = true })
vim.keymap.set('i', '<C-p>', function() return vim.fn.pumvisible() == 1 and t '<C-p>' or '' end, { expr = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<CR>', { desc = 'Only this tab' })
vim.keymap.set('n', '<leader>]', '<cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>[', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })

-- mappings for plugins
vim.keymap.set('n', '<leader>G', ':Goyo | set linebreak<CR> :hi statusline guibg=NONE<CR>')
vim.keymap.set('n', '<leader>g', ':Magit<CR>')
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = 'tree' })
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', { desc = 'tree' })
vim.keymap.set('n', '<leader>=', ':NvimTreeFindFile<CR>', { desc = 'tree' })
-- vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
-- vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
-- vim.keymap.set('n', '<leader>t', ":Oil<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.lsp.enable({ "lua_ls", "biome", "tinymist", "emmet_ls", "clangd", "ts_ls", "pyright", "asm_lsp", "rust_analyzer" })

vim.g.python3_host_prog = "/usr/bin/python3"

-- require "vague".setup({ transparent = true })
require "gruvbox".setup({
    palette_overrides = {
        -- bright_green = "#990000",
    },
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "soft", -- can be "hard", "soft" or empty string
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")
vim.cmd(":hi statusline guibg=NONE")



-- local function create_autoclose_mappings()
--     local bracket_pairs = {
--         ['('] = ')',
--         ['['] = ']',
--         ['{'] = '}',
--         ["'"] = "'",
--         ['"'] = '"',
--         ['`'] = '`',
--     }
--
--     for open, close in pairs(bracket_pairs) do
--         vim.keymap.set('i', open, function()
--             local line = vim.api.nvim_get_current_line()
--             local col = vim.api.nvim_win_get_cursor(0)[2]
--             local next_char = line:sub(col + 1, col + 1)
--
--             -- Check if we're at end of line or next character is closing pair
--             if col >= #line or next_char:match('%s') or next_char == close then
--                 return open .. close .. '<Left>'
--             else
--                 return open
--             end
--         end, { expr = true, noremap = true })
--     end
--
--     -- Special handling for Enter key in brackets
--     vim.keymap.set('i', '<CR>', function()
--         local line = vim.api.nvim_get_current_line()
--         local col = vim.api.nvim_win_get_cursor(0)[2]
--         local prev_char = line:sub(col, col)
--         local next_char = line:sub(col + 1, col + 1)
--
--         if (prev_char == '(' and next_char == ')') or
--             (prev_char == '[' and next_char == ']') or
--             (prev_char == '{' and next_char == '}') then
--             return '<CR><Esc>O'
--         else
--             return '<CR>'
--         end
--     end, { expr = true, noremap = true })
-- end
--
-- create_autoclose_mappings()

-- better switch between vim splits and resize
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', '<Tab>', ':tabnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>')
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { desc = 'New tab' })
-- vim.keymap.set('n', '<C-t>', ':tabnew | NvimTreeFindFile<CR>', { desc = 'New tab' })

vim.keymap.set('n', '<A-Tab>', '<C-w>w')
vim.keymap.set('n', '<A-S-Tab>', '<C-w>W')

vim.keymap.set('n', '<C-S>h', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<C-S>l', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<C-S>j', '<cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-S>k', '<cmd>vertical resize +2<CR>')
