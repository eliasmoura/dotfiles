vim.g.mapleader = " "
vim.opt.timeout = false
vim.opt.timeoutlen = 600
vim.g.maplocalleader = "\\"
vim.opt.updatetime = 50
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.markdown_folding = 1
vim.g.vim_markdown_folding_disabled = 1
vim.opt.completeopt = "menuone,noselect" -- ,preview"
-- vim.opt.shortmess = vim.opt.shortmess .. "cI"
vim.opt.cmdheight = 0
-- vim.opt.highlight Normal guibg=none
vim.opt.exrc = true
vim.opt.undofile = true -- keep an undo file (undo changes after closing)
vim.opt.number = true
vim.opt.rnu = true
vim.opt.showbreak = "…"
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.winbar = "%f%m"
vim.opt.hidden = true
vim.opt.wildmode = "longest,full"
vim.opt.wildoptions = "pum"
vim.opt.wildignore = "*.pyc,*~,*.o,*.obj"
vim.opt.suffixesadd = ".py,.pl,.js,.html,.c,.h,.cpp,.hh"
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.vb = true -- visual bell
vim.opt.spelllang = "en_us"
vim.opt.spellsuggest = "best"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shada = [["10000,'10000,<500,:50,s100,f1,h]]
vim.opt.colorcolumn = "80"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.smartindent = true
vim.o.smartcase = true
vim.opt.list = true
vim.opt.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+,eol:$"
-- vim.opt.cpoptions = vim.opt.cpoptions .. "$" -- put a $ in the end of the change mode
vim.opt.inccommand = "split"
vim.opt.lazyredraw = false -- Noice complains that this should be off
vim.opt.conceallevel = 1

-- Change icons for Lsp Diagnostic
-- local signs = { ERROR = "", WARN = "", INFO = "כֿ", HINT = "" }
-- for sign, icon in pairs(signs) do
--   vim.fn.sign_define("DiagnosticSign" .. sign, {
--     text = icon,
--     texthl = "Diagnostic" .. sign,
--     linehl = false,
--     numhl = "Diagnostic" .. sign,
--   })
-- end

-- Make hover borders rounded
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = "rounded",
-- })

-- Disable bultin plugins I don't use.
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tohtml = 1

-- TODO: check those win separate stuff
vim.opt.fillchars = {
  eob = " ",
  vert = "║",
  horiz = "═",
  horizup = "╩",
  horizdown = "╦",
  vertleft = "╣",
  vertright = "╠",
  verthoriz = "╬",
}
