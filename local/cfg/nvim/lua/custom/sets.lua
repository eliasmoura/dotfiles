local gopt = vim.g
local opt = vim.o
local wopt = vim.wo
local bopt = vim.bo

vim.g.mapleader = " "
vim.o.timeout = true
vim.o.timeoutlen = 600
vim.g.maplocalleader = "\\"
opt.updatetime = 50
wopt.foldmethod = "syntax"
opt.completeopt = "menuone,noselect" -- ,preview"
opt.shortmess = opt.shortmess .. "cI"
opt.cmdheight = 1
-- opt.highlight Normal guibg=none
opt.exrc = true
opt.undofile = true -- keep an undo file (undo changes after closing)
wopt.number = true
opt.showbreak = "…"
wopt.cursorline = true
opt.laststatus = 2
opt.hidden = true
opt.wildmode = "longest,full"
opt.wildoptions = "pum"
opt.wildignore = "*.pyc,*~,*.o,*.obj"
opt.suffixesadd = ".py,.pl,.js,.html,.c,.h,.cpp,.hh"
opt.termguicolors = true
opt.scrolloff = 8
opt.vb = true -- visual bell
bopt.spelllang = "en_us"
opt.spellsuggest = "best"
opt.tabstop = 2
opt.softtabstop = opt.tabstop
opt.shiftwidth = opt.tabstop
opt.expandtab = true
bopt.tabstop = 2
bopt.softtabstop = bopt.tabstop
bopt.shiftwidth = bopt.tabstop
bopt.expandtab = true
opt.shada = [["10000,'10000,<500,:50,s100,f1,h]]
wopt.colorcolumn = "80"
opt.splitright = true
opt.mouse = "n"
opt.splitbelow = true
opt.smartindent = true
wopt.list = true
opt.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+,eol:$"
opt.cpoptions = opt.cpoptions .. "$" -- put a $ in the end of the change mode
opt.inccommand = "split"
gopt.netrw_browsex_viewer = "plumber"

-- Disable bultin plugins I don't use.
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

-- vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

vim.g.tar_cmd = "bsdtar"
vim.g.tar_secure = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin =1
vim.g.loaded_tohtml = 1

-- Tell vim about the additional file extensions we can now use.
vim.cmd(
  [[autocmd BufReadCmd *.iso,*.rar,*.7z call tar#Browse(expand("<tch>"))]]
)
