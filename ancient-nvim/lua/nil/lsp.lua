-- lua/nil/lsp.lua  – v2-kompatibel
local lspconfig        = require("lspconfig")
local mason            = require("mason")
local mason_lspconfig  = require("mason-lspconfig")

mason.setup()

mason_lspconfig.setup({
  ensure_installed  = { "lua_ls", "pyright", "tsserver", "rust_analyzer" },
  automatic_enable  = true,              -- Mason startet LSPs selbst
})

-- globale Defaults (on_attach, capabilities …)
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config('*', {
  on_attach    = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,  opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,  opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover,       opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
  capabilities = capabilities,
})

-- serverspezifische Extras
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace   = { checkThirdParty = false },
    },
  },
})

