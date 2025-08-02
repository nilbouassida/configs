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

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua', },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/junegunn/goyo.vim'},
	{ src = 'https://github.com/jreybert/vimagit'},
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

-- vim.keymap.set('n', '<leader>g', ':Goyo<CR>')
vim.keymap.set('n', '<leader>g', ':Magit<CR>')
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'tree'})
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>t', ":Oil<CR>")
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.lsp.enable({ "lua_ls", "biome", "tinymist", "emmetls" })

require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")



-- ─── Autocomplete setup ────────────────────────────────────────────────────
-- 1. Make the built-in LSP completion autotrigger.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.server_capabilities.completionProvider then
      -- For Neovim ≥0.10 use vim.lsp.completion.enable();
      -- for 0.9.x keep using completion.enable() as below:
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      -- If you’re on 0.10 nightly, switch to:
      -- vim.lsp.completion.enable(true, { autotrigger = true })
    end
  end,
})

-- Recommended UI tweaks
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- nicer popup
vim.opt.shortmess:append('c')                           -- no "match x of y" echoes

-- 2. Tab / Shift-Tab navigation inside the popup menu.
local function t(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end, { expr = true, silent = true })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end, { expr = true, silent = true })



