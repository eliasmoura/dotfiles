vim.g.mapleader = " "
vim.o.timeout = true
vim.o.timeoutlen = 600
vim.g.maplocalleader = "\\"
vim.o.updatetime = 50
vim.wo.foldmethod = "syntax"
vim.g.markdown_folding = 1
vim.g.vim_markdown_folding_disabled = 1
vim.o.completeopt = "menuone,noselect" -- ,preview"
vim.o.shortmess = vim.o.shortmess .. "cI"
vim.o.cmdheight = 1
-- vim.o.highlight Normal guibg=none
vim.o.exrc = true
vim.o.undofile = true -- keep an undo file (undo changes after closing)
vim.wo.number = true
vim.wo.rnu = true
vim.o.showbreak = "…"
vim.wo.cursorline = true
vim.o.laststatus = 2
vim.o.hidden = true
vim.o.wildmode = "longest,full"
vim.o.wildoptions = "pum"
vim.o.wildignore = "*.pyc,*~,*.o,*.obj"
vim.o.suffixesadd = ".py,.pl,.js,.html,.c,.h,.cpp,.hh"
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.vb = true -- visual bell
vim.bo.spelllang = "en_us"
vim.o.spellsuggest = "best"
vim.o.softtabstop = vim.o.tabstop
vim.o.shiftwidth = vim.o.tabstop
vim.o.expandtab = true
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = vim.bo.tabstop
vim.bo.shiftwidth = vim.bo.tabstop
vim.bo.expandtab = true
vim.o.shada = [["10000,'10000,<500,:50,s100,f1,h]]
vim.wo.colorcolumn = "80"
vim.o.splitright = true
vim.o.mouse = "n"
vim.o.splitbelow = true
vim.o.smartindent = true
vim.wo.list = true
vim.o.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+,eol:$"
vim.o.cpoptions = vim.o.cpoptions .. "$" -- put a $ in the end of the change mode
vim.o.inccommand = "split"
vim.o.lazyredraw = true

vim.cmd([[
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 60})
augroup END
]])

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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tohtml = 1

-- Tell vim about the additional file extensions we can now use.
vim.cmd(
  [[autocmd BufReadCmd *.iso,*.rar,*.7z call tar#Browse(expand("<tch>"))]]
)
