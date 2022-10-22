local lspconfig = require("lspconfig")

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local autocmd = vim.api.nvim_create_autocmd

-- NOTE: Not need because it is already set to autoload.
-- autocmd("BufEnter", {
--   pattern = "*",
--   command = ":LspStart",
-- })

local on_attach = function(client)
  require("lsp-status").on_attach(client)
  local opts = {}
  opts.buffer = true
  vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set(
    "n",
    "<leader>la",
    require("lspsaga.codeaction").code_action or vim.lsp.buf.code_action,
    opts
  )
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol)
  vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references)
  vim.keymap.set(
    "n",
    "<leader>lR",
    require("lspsaga.rename").rename or vim.lsp.buf.rename
  )
  vim.keymap.set("n", "<leader>ldg", vim.diagnostic.get)
  vim.keymap.set("n", "<c-s>", vim.diagnostic.show)
  vim.keymap.set("n", "<M-Q>", vim.diagnostic.setqflist)
  vim.keymap.set("n", "<M-q>", vim.diagnostic.setloclist)
  vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, opts)

  if client.server_capabilities.document_formatting then
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting)
    autocmd("BufWritePre", {
      group = "lsp_formatting",
      buffer = 0,
      callback = vim.lsp.buf.formatting_sync,
    })
  end

  if client.server_capabilities.code_lens then
    vim.notify("LSP has codelens")
    autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = 0,
      callback = vim.lsp.codelens.refresh,
    })
  end

  if client.server_capabilities.document_highlight then
    autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    autocmd({ "CursorMoved" }, {
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--     -- on_attach = my_custom_on_attach,
--     capabilities = capabilities,
--   }
-- end

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  init_options = {
    clangdFileStatus = true,
  },
  handlers = require("lsp-status").extensions.clangd.setup(),
})
vim.lsp.set_log_level("error")

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  cmd = {
    "/usr/bin/lua-language-server",
  },
  -- cmd = {'/home/kotto/local/cfg/pacman/makepkg/recipes/sumneko-git/wrapper.sh'},
  -- An example of settings for an LSP server.
  --    For more options, see nvim-lspconfig
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      completion = {
        keywordSnippet = "Disable",
        showWord = "Disable",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "use" },
        disable = { "lowercase-global" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        preloadFileSize = 1024,
      },
    },
  },
})

-- require('lspconfig').pyls.setup{ on_attach=lsp_on_attach }
require("lspconfig").gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {},
})

local lspstatus = require("lsp-status")
lspstatus.register_progress()

-- Zig Language Server (zig)
lspconfig.zls.setup({
  on_attach = on_attach,
  cmd = { "zls" },
  capabilities = capabilities,
  settings = {
    warn_style = true,
  },
})

return lspconfig
