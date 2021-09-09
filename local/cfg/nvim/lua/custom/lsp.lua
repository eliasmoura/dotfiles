local lspconfig = require('lspconfig')

lspconfig.clangd.setup({
  on_attach = vim.custom.mappings.lsp_on_attach,
  cmd = {
    'clangd',
    '--background-index',
    '--suggest-missing-includes',
    '--clang-tidy',
    '--header-insertion=iwyu',
  },
  init_options = {
    clangdFileStatus = true
  },
  handlers = require'lsp-status'.extensions.clangd.setup(),
})
vim.lsp.set_log_level("error")

lspconfig.sumneko_lua.setup({
  on_attach = vim.custom.lsp_on_attach,
  cmd = {'/usr/bin/lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'},
  -- cmd = {'/home/kotto/local/cfg/pacman/makepkg/recipes/sumneko-git/wrapper.sh'},
  -- An example of settings for an LSP server.
  --    For more options, see nvim-lspconfig
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'use'},
        disable = { 'lowercase-global'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
        preloadFileSize = 1024
      },
    }
  },
})

-- require('lspconfig').pyls.setup{ on_attach=lsp_on_attach }
require('lspconfig').gopls.setup{ on_attach=vim.custom.lsp_on_attach }
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- vim.cmd([[autocmd CursorHold  <buffer> ++nested lua vim.lsp.buf.document_highlight()]])
vim.cmd([[autocmd CursorHoldI <buffer> ++nested lua vim.lsp.buf.document_highlight()]])
vim.cmd([[autocmd CursorMoved <buffer> ++nested lua vim.lsp.buf.clear_references()]])
vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])

return lspconfig
