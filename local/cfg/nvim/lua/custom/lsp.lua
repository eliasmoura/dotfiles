local lspconfig = require('lspconfig')
vim.cmd [[runtime plugin/astronauta.vim]]
local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap
local on_attach =  function(client)
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  require('lsp-status').on_attach(client)
  inoremap{'<c-s>', vim.lsp.buf.signature_help}
  nnoremap{'<leader>la', vim.lsp.buf.code_action}
  nnoremap{'<leader>lf', vim.lsp.buf.formatting}
  nnoremap{'<leader>ls', vim.lsp.buf.document_symbol}
  nnoremap{'<leader>lh', vim.lsp.buf.hover}
  nnoremap{'<leader>lr', vim.lsp.buf.references}
  nnoremap{'<leader>lR', vim.lsp.buf.rename}
  nnoremap{'<leader>ldg', vim.lsp.diagnostic.get_all}
  nnoremap{'<leader>lda', vim.lsp.diagnostic.goto_prev}
  nnoremap{'<M-n>', vim.lsp.diagnostic.goto_next}
  nnoremap{'<M-p>', vim.lsp.diagnostic.goto_prev}
  nnoremap{'<M-o>', vim.lsp.diagnostic.show_line_diagnostics}
  nnoremap{'<M-Q>', vim.lsp.util.set_qflist}
  nnoremap{'<M-q>', vim.lsp.util.set_loclist}
  nnoremap{'<c-]>', vim.lsp.buf.definition}

  if filetype ~= 'lua' then
    nnoremap{'K', vim.lsp.buf.hover}
  end
end

lspconfig.clangd.setup({
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
})
vim.lsp.set_log_level("error")

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

-- require('lspconfig').pyls.setup{ on_attach=lsp_on_attach }
require('lspconfig').gopls.setup{ on_attach=on_attach }
local lsp_status = require('lsp-status')
lsp_status.register_progress()

vim.cmd([[autocmd CursorHold  <buffer> ++nested lua vim.lsp.buf.document_highlight()]])
vim.cmd([[autocmd CursorHoldI <buffer> ++nested lua vim.lsp.buf.document_highlight()]])
vim.cmd([[autocmd CursorMoved <buffer> ++nested lua vim.lsp.buf.clear_references()]])
vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])

return lspconfig
