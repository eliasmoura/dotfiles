" XXX Vim doesn't mkdir the backupdir path (bug?) so let's do that ourselves
" instead.
if has('unix')
  if empty($LOCAL)
    let local=$HOME . '/local'
  else
    let local=$LOCAL
  endif
  let data = local . '/share/nvim'
  let cfg  = local . '/cfg/nvim'
else
  if has('win32')
    if empty($DATA)
      let data = $USERPROFILE . '/AppData/Local/nvim-data'
      let cfg  = $USERPROFILE . '/AppData/Local/nvim'
    endif
  endif
endif

let back = data . '/backup/'
if !isdirectory(back)
  call mkdir(back, "p")
endif
set shortmess+=cI
set cmdheight=1
"highlight Normal guibg=none
set exrc
set undofile        " keep an undo file (undo changes after closing)
set number
set showbreak=…
set cursorline
set laststatus=2
set hidden
set wildmode=longest,full
set wildoptions=pum
set wildignore=*.pyc,*\~,*.o,*.obj
set suffixesadd=.py,.pl,.js,.html,.c,.h,.cpp,.hh
set mouse=n
set termguicolors
set scrolloff=8
" hi StatusLine   ctermbg=white   ctermfg=4
" hi StatusLineNC ctermbg=red     ctermfg=blue
set vb              " visual bell
set showcmd         " display incomplete commands
set spelllang=en_us
set spellsuggest=best
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
let &backupdir = back
set shada='1000,f1,<500,h
set colorcolumn=90
set splitright
set splitbelow
set smartindent
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:\ 
set cpoptions+=$        "put a $ in the end of the change mode
set inccommand="split"
" let g:netrw_browsex_viewer= 'plumber'
au BufEnter *.log,*.txt setlocal ft=txt
augroup GOTO_LAST_LINE_WHENCLOSED
  autocmd!
  autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup END

syntax on
filetype indent plugin on

augroup VimrcSo
  " Automatically reload vimrc when it's saved "
  au!
  autocmd BufWritePost $MYVIMRC execute 'source $MYVIMRC'
augroup END

augroup RST_SOMETHING
  autocmd!
  autocmd FileType rst setlocal formatoptions+=n
augroup END
augroup GIT_HINGS
  autocmd!
  autocmd FileType gitcommit setlocal spell
augroup END

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

call plug#begin('~/local/share/nvim/plugins')
Plug 'https://github.com/lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'https://github.com/vim-pandoc/vim-pandoc'
Plug 'https://github.com/beyondmarc/glsl.vim.git',    { 'for': 'gls'}
" Makes vim/nvim slow when there are list blocks in the view
Plug 'https://github.com/chrisbra/NrrwRgn.git',       { 'for': [ 'adoc', 'asciidoc' ] }
Plug 'https://github.com/inkarkat/vim-SyntaxRange',{ 'for': [ 'adoc', 'asciidoc' , 'html', 'vim' ] }
" Plug 'https://github.com/dahu/vim-asciidoc',          { 'for': [ 'adoc', 'asciidoc' ] }
Plug 'https://github.com/tweekmonster/startuptime.vim'
" Plug 'https://github.com/vim-scripts/rfc-syntax',     { 'for': [ 'rfc' , 'txt'      ] }
Plug 'https://github.com/mhinz/vim-rfc'
"Plug 'https://github.com/mhinz/vim-startify'
" Plug 'https://github.com/tpope/vim-rhubarb' "consider this for github things
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-fugitive.git'    "Git integration
Plug 'https://github.com/junegunn/gv.vim'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tommcdo/vim-exchange.git'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/vim-utils/vim-man'
Plug 'https://github.com/hoob3rt/lualine.nvim'
nnoremap cu :UndotreeToggle<CR>
Plug 'https://github.com/junegunn/vim-easy-align',
nnoremap gl :EasyAlign<CR>
vnoremap gl :EasyAlign<CR>
Plug 'https://github.com/plasticboy/vim-markdown'
" Plug 'https://github.com/groenewege/vim-less'

"Plug 'https://github.com/hsanson/vim-android'
Plug 'https://github.com/dbgx/lldb.nvim'

Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/nvim-lua/plenary.nvim' " lua functions used by others plugins
Plug 'https://github.com/nvim-lua/popup.nvim'   " popup menu used by telescope
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/nvim-compe'
Plug 'https://github.com/nvim-lua/lsp-status.nvim'
" Plug 'https://github.com/nvim-lua/completion-nvim'
call plug#end()
" Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()
lua <<EOF
local lspconfig = require('lspconfig')
lspconfig.clangd.setup{ }
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lspconfig = require('lspconfig')

vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
vim.api.nvim_buf_set_keymap(0, 'n', '<c-]', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {  }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust" },  -- list of language that will be disabled
  },
}
EOF

lua <<EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'disable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}
vim.o.completeopt = "menuone,noselect,preview"
EOF

nnoremap <leader>gg   :Git 
nnoremap <leader>gG   :Git! 
nnoremap <leader>gs   :Gstatus<cr>
nnoremap <leader>gc   :Gcommit -m<cr>
nnoremap <leader>gm   :Gmerge<cr>
nnoremap <leader>gl   :Glog<cr>

set foldmethod=syntax

" When writing a buffer, and on normal mode changes (after 750ms).
" call neomake#configure#automake('nw', 750)
" Prevent neomake reporting its exit status and suppressing the write message.
" https://github.com/benekastah/neomake/issues/238
" let neomake_verbose = 0
" let g:neomake_open_list = 2
" let g:neomake_sh_shellcheck_args   = neomake#makers#ft#sh#shellcheck()['args'] + ['-x']

" au BufRead,bufNewFile /home/kotto/dev/python/* let g:neomake_python_enabled_makers = [ 'flake8',  'python' ]
" let g:neomake_python_flake8_args = neomake#makers#ft#python#flake8()['args'] +  [ '--ignore=E302,E201,E501,E202' ]

" Use clang when checking C/C++ syntax.
" let g:neomake_c_avr_maker = { 'exe': 'avr-gcc', 'args': [ '-o >/dev/null', '-mmcu=atmega328p' ], 'errorformat': '%f:%l:%c: %m' }
" au BufRead,bufNewFile /home/kotto/dev/arduino/* let g:neomake_c_enabled_makers = [ 'avr' ]
" au BufRead,bufNewFile /home/kotto/dev/arduino/* let g:neomake_CPP_enabled_makers = [ 'avr' ]
" let g:neomake_c_clang_args = neomake#makers#ft#c#clang()['args'] + [ '-I/usr/include/ClearSilver/', '-std=c11', '-Werror', 
"            '-Wconversion', '-Wpedantic', '-Wformat-security', '-Wno-missing-field-initializers', 
"            '-Wno-unused-parameter' ]
" let g:neomake_c_clang_maker = { 
"            'exe' : 'clang', 
"            'args': [ 
"            '-fsyntax-only', 
"            '-std=c11', 
"            '-Wall', 
"            '-Wextra', 
"            '-Wconversion', 
"            '-Wformat-security', 
"            '-Wno-missing-field-initializers', 
"            '-Wno-unused-parameter', 
"            '-I/usr/include/ClearSilver/', 
"            '-I./', ], 
"            'errorformat': '%-G%f:%s:,%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%I%f:%l:%c: note: %m,%f:%l:%c: %m,%f:%l: %trror: %m,%f:%l: %tarning: %m,%I%f:%l: note: %m,%f:%l: %m' }
" let g:neomake_c_gcc_args   = neomake#makers#ft#c#gcc()['args'] + ['-std=c11', '-Werror', '-Wconversion', 
"            '-Wpedantic', '-Wformat-security', '-I/usr/include/ClearSilver' ]
" " let g:neomake_c_enabled_makers = [ 'clang' ]
" let g:neomake_c_arm_maker = { 'exe': 
"        'arm-none-eabi-gcc', 'args': 
"        [   '-o > /dev/null', 
"        '-DUSE_STDPERIPH_DRIVER', 
"        '-I.', 
"        '-I../stm32/lib/inc/', 
"        '-I../stm32/core', 
"        '-I../stm32/device/'], 
"        'errorformat': '%f:%l:%c: %m' }
" au BufRead,bufNewFile /home/kotto/dev/arm/stm/f1/* let g:neomake_c_gcc_args = neomake#makers#ft#c#gcc()['args'] + [ '-DSTM32F10X_MD_VL' ]
" au BufRead,bufNewFile /home/kotto/dev/arm/stm/* let g:neomake_c_enabled_makers = [ 'arm' ]

map Q gq
inoremap <C-U> <C-G>u<C-U>
let mapleader = ' '
nnoremap <leader>rt    :%s/\s\+$//g<cr>:let @/=''<CR> "remove trailings
nnoremap <M-m>         :make<CR>
nnoremap <leader>ct    :silent !ctags -R .<CR>:redraw!<CR>
nnoremap <leader>/     :silent :nohlsearch<CR>:<CR>
nnoremap <leader><Tab> :silent :retab!<CR>
nnoremap <leader>i     :exec 'edit ' . cfg . '/init.vim'<CR>
nnoremap <leader>t     :TlistToggle<CR>
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-S-a>        <C-^>

"Completision
inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L

" Use bsdtar for all the additional formats it supports over GNU tar.
let g:tar_cmd = 'bsdtar'
let g:tar_secure = 1

" Tell vim about the additional file extensions we can now use.
autocmd BufReadCmd *.iso,*.rar,*.7z call tar#Browse(expand("<tch>"))

" nnoremap <leader>b :call ToggleBackground()<CR>
function! ToggleBackground()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction

function! AsciidocEnableSyntaxRanges()
  " source block syntax highlighting
  if exists('g:loaded_SyntaxRange')
    for lang in ['c', 'python', 'vim', 'javascript', 'cucumber', 'xml', 'typescript', 'sh', 'java', 'cpp', 'sh']
      call SyntaxRange#Include( '\c\[source\s*,\s*' . lang . '.*\]\s*\n[=-]\{4,\}\n'
            , '\]\@<!\n[=-]\{4,\}\n'
            , lang, 'NonText')
    endfor

    call SyntaxRange#Include( '\c\[source\s*,\s*gherkin.*\]\s*\n[=-]\{4,\}\n'
          , '\]\@<!\n[=-]\{4,\}\n'
          , 'cucumber', 'NonText')
  endif
endfunction

augroup ASCIIDOC_THINGS
  autocmd!
" autocmd FileType asciidoc,adoc  call AsciidocEnableSyntaxRanges()
  autocmd FileType asciidoc,adoc  setlocal formatoptions+=n1 textwidth=70 spell comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
augroup END

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

colorscheme gruvbox " base16-atelier-seaside
lua << EOF
require'lualine'.setup({
options = {theme = 'gruvbox'}
}
)
EOF
