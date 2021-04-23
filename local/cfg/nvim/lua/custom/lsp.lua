local lspconfig = require('lspconfig')
local on_attach = require('completion').on_attach
lspconfig.clangd.setup{
  on_attach = on_attach,
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
}
vim.lsp.set_log_level("debug")
lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
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

require'lspconfig'.pyls.setup{ on_attach=on_attach }
require'lspconfig'.gopls.setup{ on_attach=on_attach }
local lsp_status = require('lsp-status')
lsp_status.register_progress()

vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {  }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

require('custom.mappings')

vim.api.nvim_command 'autocmd CursorHold   <buffer> ++nested lua vim.lsp.buf.document_highlight()'
vim.api.nvim_command 'autocmd CursorHoldI <buffer> ++nested lua vim.lsp.buf.document_highlight()'
vim.api.nvim_command 'autocmd CursorMoved  <buffer> ++nested lua vim.lsp.buf.clear_references()'
-- vim.api.nvim_command 'autocmd CursorHold  <buffer> ++nested lua vim.lsp.buf.hover()'
