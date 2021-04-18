-- " XXX Vim doesn't mkdir the backupdir path (bug?) so let's do that ourselves
-- " instead.
-- if has('unix')
--   if empty($LOCAL)
--     let local=$HOME . '/local'
--   else
--     let local=$LOCAL
--   endif
--   let data = local . '/share/nvim'
--   let cfg  = local . '/cfg/nvim'
-- else
--   if has('win32')
--     if empty($DATA)
--       let data = $USERPROFILE . '/AppData/Local/nvim-data'
--       let cfg  = $USERPROFILE . '/AppData/Local/nvim'
--     endif
--   endif
-- endif
local cfg = '~/local/cfg/nvim'
local opt  = vim.o
local map  = vim.api.nvim_set_keymap
local cmd  = vim.cmd
local call = vim.call
local fn   = vim.fn
local gopt = vim.g
local wopt = vim.wo
local bopt = vim.bo

gopt.mapleader = ' '
-- let back = data . '/backup/'
-- if !isdirectory(back)
--   call mkdir(back, "p")
-- endif
wopt.foldmethod = 'syntax'
opt.completeopt   = "menuone,noselect,preview" 
opt.shortmess = opt.shortmess..'cI'
opt.cmdheight=1
-- opt.highlight Normal guibg=none
opt.exrc = true
opt.undofile = true -- keep an undo file (undo changes after closing)
wopt.number = true
opt.showbreak = '…'
wopt.cursorline = true
opt.laststatus = 2
opt.hidden = true
opt.wildmode = 'longest,full' 
opt.wildoptions = 'pum'
opt.wildignore = '*.pyc,*~,*.o,*.obj' 
opt.suffixesadd = '.py,.pl,.js,.html,.c,.h,.cpp,.hh'
opt.termguicolors = true
opt.scrolloff = 8
opt.vb = true -- visual bell
bopt.spelllang = 'en_us'
opt.spellsuggest = 'best'
bopt.tabstop = 2
bopt.softtabstop = 2
bopt.shiftwidth = 2
bopt.expandtab = true
opt.shada = "'10000,f1,<500,h"
wopt.colorcolumn = '80'
opt.splitright = true
opt.splitbelow = true
opt.smartindent = true
wopt.list = true
wopt.listchars = 'tab:> ,trail:-,extends:>,precedes:<,nbsp:+,eol:$'
opt.cpoptions = opt.cpoptions..'$'        -- put a $ in the end of the change mode
opt.inccommand = "split"
gopt.netrw_browsex_viewer = 'plumber'
-- if !exists(":DiffOrig")
--   command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
-- endif
require'packer'.startup(function()
  use 'https://github.com/wbthomason/packer.nvim'
  use { 'https://github.com/lambdalisue/suda.vim',
    config = 'gopt.suda_smart_edit = 1' }

  use 'https://github.com/vim-pandoc/vim-pandoc'
  use { 'https://github.com/beyondmarc/glsl.vim.git',    ft = 'gls'} 
  -- " Makes vim/nvim slow when there are list blocks in the view
  use { 'https://github.com/chrisbra/NrrwRgn.git', ft = { 'adoc', 'asciidoc' }} 
  use { 'https://github.com/inkarkat/vim-SyntaxRange', ft = { 'adoc', 'asciidoc' , 'html', 'vim' }} 
  -- " Plug 'https://github.com/dahu/vim-asciidoc',          'ft': [ 'adoc', 'asciidoc' ]
  use 'https://github.com/tweekmonster/startuptime.vim'
  -- " Plug 'https://github.com/vim-scripts/rfc-syntax',     'ft': [ 'rfc' , 'txt'      ]
  use 'https://github.com/mhinz/vim-rfc'
  -- "Plug 'https://github.com/mhinz/vim-startify'
  -- " Plug 'https://github.com/tpope/vim-rhubarb' "consider this ft github things
  use 'https://github.com/tpope/vim-surround'
  use 'https://github.com/tpope/vim-repeat.git'
  use 'https://github.com/tpope/vim-fugitive.git' --    "Git integration
  use 'https://github.com/junegunn/gv.vim'
  use 'https://github.com/tpope/vim-commentary.git'
  use 'https://github.com/tommcdo/vim-exchange.git'
  use 'https://github.com/vim-utils/vim-man'
  use 'https://github.com/hoob3rt/lualine.nvim'
  use 'https://github.com/mbbill/undotree'
  map('n', 'cu', [[:UndotreeToggle<CR>]], { noremap = true })
  use 'https://github.com/junegunn/vim-easy-align'
  map('n', 'gl', [[:EasyAlign<CR>]],   { noremap = true })
  map('v', 'gl', [[:EasyAlign<CR>')]], { noremap = true })
  use 'https://github.com/plasticboy/vim-markdown'
  -- " Plug 'https://github.com/groenewege/vim-less'

  -- "Plug 'https://github.com/hsanson/vim-android'

  use 'https://github.com/morhetz/gruvbox'
  use { 'https://github.com/nvim-treesitter/nvim-treesitter', run = 'vim.cmd("TSUpdate")'} 
  use 'https://github.com/nvim-lua/plenary.nvim' -- " lua functions used by others plugins
  use 'https://github.com/nvim-lua/popup.nvim' --   " popup menu used by telescope
  use 'https://github.com/nvim-telescope/telescope.nvim'
  use 'https://github.com/neovim/nvim-lspconfig'
  -- use 'https://github.com/hrsh7th/nvim-compe'
  use 'https://github.com/nvim-lua/lsp-status.nvim'
  use 'https://github.com/nvim-lua/completion-nvim'
end)
-- Trying to decide whether to use nvim-compe or completion-nvim
-- " Use completion-nvim in every buffer
cmd([[autocmd BufEnter * lua require'completion'.on_attach()]])
local lspconfig = require('lspconfig')
lspconfig.clangd.setup{ }
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lspconfig = require('lspconfig')

map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>',         { noremap = true})
map('n', '<c-]', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true})
vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {  }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust" },  -- list of language that will be disabled
  },
}

-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'disable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = true;
--   source = {
--     path = true;
--     buffer = true;
--     calc = true;
--     nvim_lsp = true;
--     nvim_lua = true;
--     vsnip = true;
--   };
-- }

map('n', '<leader>gg', [[:Git ]],           { noremap = true })
map('n', '<leader>gG', [[:Git! ]],          { noremap = true })
map('n', '<leader>gs', [[<cmd>Git<cr>]],        { noremap = true })
map('n', '<leader>gc', [[<cmd>Git commit<cr>]], { noremap = true })
map('n', '<leader>gm', [[<cmd>Git merge<cr>]],  { noremap = true })
map('n', '<leader>gl', [[<cmd>Git log<cr>]],    { noremap = true })

map('', 'Q', [[gq]], {})
map('i', '<C-U>', [[:C-G>u<C-U>]], { noremap = true })
map('n', '<leader>rt', [[:%s/\s\+$//g<cr>:let @/=''<CR>]], {noremap=true}) -- remove trailings
map('n', '<M-m>', [[:make<CR>]],                                 { noremap = true })
map('n', '<leader>ct', [[:silent !ctags -R .<CR>:redraw!<CR>]],  { noremap = true })
map('n', '<leader>/', [[:silent :nohlsearch<CR>:<CR>]],          { noremap = true })
map('n', '<leader><Tab>', [[:silent :retab!<CR>]],               { noremap = true })
map('n', '<leader>i', [[:exec 'edit ' . cfg . '/init.vim'<CR>]], { noremap = true })
map('n', '<leader>t', [[:TlistToggle<CR>]],                      { noremap = true })
-- " Find files using Telescope command-line sugar.
map('n', '<leader>f', [[:Telescope find_files<cr>]],             { noremap = true })
map('n', '<leader>g', [[:Telescope live_grep<cr>]],              { noremap = true })
map('n', '<leader>b', [[:Telescope buffers<cr>]],                { noremap = true })
map('n', '<leader>h', [[:Telescope help_tags<cr>]],              { noremap = true })
map('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})
map('n', '<C-S-a>', [[:C-^>]], { noremap = true })

-- "Completision
map('i', '^]', 'X^%]', { noremap = true })
map('i', '^F', [[X^F]], { noremap = true })
map('i', '^D', [[X^D]], { noremap = true })
map('i', '^L', [[X^L]], { noremap = true })

-- " Use bsdtar for all the additional formats it supports over GNU tar.
gopt.tar_cmd = 'bsdtar'
gopt.tar_secure = 1

-- " Tell vim about the additional file extensions we can now use.
cmd([[autocmd BufReadCmd *.iso,*.rar,*.7z call tar#Browse(expand("<tch>"))]])

toggleBackground = function() 
  if opt.background == "light" then
    opt.background = 'dark'
  else
    opt.background = 'light'
  end
end
map('n', '<leader>b', [[:lua toggleBackground()<CR>]], {noremap = true})


cmd([[colorscheme gruvbox]])
require'lualine'.setup({
  options = {theme = 'gruvbox'}
})
cmd([[source ~/local/cfg/nvim/auto_stuff.vim]])
