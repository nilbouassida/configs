-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
	  "rose-pine/neovim",
	  as = "rose-pine",
	  config = function()
		  vim.cmd("colorscheme rose-pine")
	  end
  })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('nvim-lua/plenary.nvim')
  use('ThePrimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  -- File tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup()
    end
  }

-- install without yarn or npm
use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})

use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })





use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({})
    end,
})






 -- LSP Setup
  use 'neovim/nvim-lspconfig'              -- Official LSP configs
  use 'williamboman/mason.nvim'            -- LSP/DAP/linter installer
  use 'williamboman/mason-lspconfig.nvim'  -- Bridge Mason -> lspconfig

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'                   -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp'               -- LSP completions
  use 'hrsh7th/cmp-buffer'                 -- Buffer word completions
  use 'hrsh7th/cmp-path'                   -- Path completions
  use 'saadparwaiz1/cmp_luasnip'           -- Snippet completions

  -- Snippets
  use 'L3MON4D3/LuaSnip'                   -- Snippet engine
  use 'rafamadriz/friendly-snippets'       -- Pre-made snippets

  -- UI Enhancements (optional)
  use 'nvimdev/lspsaga.nvim'               -- Better LSP UI (code actions, hover, etc.)
  use 'j-hui/fidget.nvim'                  -- LSP status updates
  use 'onsails/lspkind.nvim'               -- Icons in autocomplete

  -- Formatters/Linters (optional)
  use 'jose-elias-alvarez/null-ls.nvim'    -- Non-LSP tools (e.g., eslint, prettier)









end)


