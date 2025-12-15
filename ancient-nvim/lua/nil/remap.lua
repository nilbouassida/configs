
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- file tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile<CR>', { desc = 'Find current file in tree' })
vim.keymap.set('n', '<leader>t', ':NvimTreeFocus<CR>', { desc = 'Focus' })


-- compile duckdb
vim.keymap.set('n', '<leader>d', ':!source ~/duckdb_venv/bin/activate ; python3 ~/Documents/studium/sose25/isda/sql/main.py<CR>', { desc = 'run duckdb file' })

-- run markdown preview
vim.keymap.set('n', '<C-x>', ':MarkdownPreview<CR>', { desc = 'preview file'})
vim.cmd([[
	let g:mkdp_auto_close = 0
	]])

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true

vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR>', { silent = true })

