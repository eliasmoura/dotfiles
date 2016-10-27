call plug#begin('~/local/share/nvim/plugins')
Plug 'benekastah/neomake'
autocmd! BufWritePost * Neomake
" Plug 'https://github.com/fmoralesc/nvimfs'
Plug 'https://github.com/vim-scripts/TxtBrowser'
Plug 'https://github.com/beyondmarc/glsl.vim.git'
Plug 'https://github.com/chrisbra/NrrwRgn.git'
Plug 'https://github.com/vim-scripts/SyntaxRange.git'
Plug 'https://github.com/dahu/vim-asciidoc'
Plug 'https://github.com/dahu/vimple'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-fugitive.git'    "Git integration
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tommcdo/vim-exchange.git'
Plug 'https://github.com/gregsexton/gitv.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'http://github.com/sjl/gundo.vim.git'
Plug 'git://github.com/marijnh/tern_for_vim', {
      \ 'do': 'npm install; cd node_modules/tern/plugin; curl -O https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js',
      \ 'for': ['javascript', 'html', 'css']
      \ } "javascript/meteor things
Plug 'https://github.com/mattn/emmet-vim.git', { 'for': 'html' }
Plug 'https://github.com/sirver/UltiSnips'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
call plug#end()
au BufEnter *.log,*.txt setlocal ft=txt
nnoremap <leader>t :TlistToggle<CR>

tnoremap <Esc> <C-\><C-n>

let vimple_init_vn = 0
set undofile        " keep an undo file (undo changes after closing)
set ruler           " show the cursor position all the time
set number
set cursorline
set hidden
autocmd FileType c setlocal path+=/usr/avr/include
set wildmode=list:full
set wildignore=,*.pyc,*~
set suffixesadd=.py,.pl,.js,.html,.c,.h,.cpp,.hh
set mouse=n
syntax on
filetype indent plugin on
set termguicolors
let base16colorspace=256
colorscheme base16-atelier-seaside
set background=dark
set vb              " visual bell
set showcmd         " display incomplete commands
set spelllang=en_us
set spellsuggest=best
set dictionary+=en.utf-8.add,en.utf-8.spl
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set undodir=~/local/share/nvim/undo//
set directory=~/local/share/nvim/swap//
set backupdir=~/local/share/nvim/backup//
"set shada+=n$HOME/.cache/nvim/nvim.shada
set shada='1000,f1,<500,h
set showmode
set colorcolumn=90
set splitbelow
set splitright
set smartcase
set smartindent
set list
set tags=./tags,tags,~/local/share/nvim/systags,~/local/share/nvim/avr_systags
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:\ 
set cpoptions+=$        "put a $ in the end of the change mode

augroup VimrcSo
  " Automatically reload vimrc when it's saved "{{{
  au!
  autocmd BufWritePost $MYVIMRC so $MYVIMRC
augroup END

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \ if &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif
autocmd FileType rst setlocal formatoptions+=n
autocmd FileType gitcommit setlocal spell

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

map Q gq
inoremap <C-U> <C-G>u<C-U>
"change the command key on normal mode to :
nnoremap ; :
nnoremap : ;
nnoremap <leader>rt :%s/\s\+$//<cr>:let @/=''<CR>        "remove trailings
nnoremap <C-M> :make<CR>
nnoremap <leader>ct :silent !ctags -R .<CR>:redraw!<CR>
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>b :call ToggleBackground()<CR>
nnoremap <leader><Tab> :silent :retab!<CR>

"Completision
inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L

function! ToggleBackground()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction
"
" XXX Vim doesn't mkdir the backupdir path (bug?) so let's do that ourselves
" instead.
if !isdirectory($LOCAL . "/share/nvim/backup")
    call mkdir($Local . "/share/nvim/backup", "p")
endif

" Prevent neomake reporting its exit status and suppressing the write message.
" https://github.com/benekastah/neomake/issues/238
let neomake_verbose = 0

" Use clang when checking C/C++ syntax.
let g:neomake_cpp_clang_args = neomake#makers#ft#c#clang()['args'] + ['-std=c99']
let g:neomake_cpp_clang_args = neomake#makers#ft#cpp#clang()['args'] + ['-std=c++11']

function! AsciidocEnableSyntaxRanges()
  " source block syntax highlighting
  if exists('g:loaded_SyntaxRange')
    for lang in ['c', 'python', 'vim', 'javascript', 'cucumber', 'xml', 'typescript', 'sh', 'java', 'cpp', 'sh']
      call SyntaxRange#Include(
            \  '\c\[source\s*,\s*' . lang . '.*\]\s*\n[=-]\{4,\}\n'
            \, '\]\@<!\n[=-]\{4,\}\n'
            \, lang, 'NonText')
    endfor

    call SyntaxRange#Include(
          \  '\c\[source\s*,\s*gherkin.*\]\s*\n[=-]\{4,\}\n'
          \, '\]\@<!\n[=-]\{4,\}\n'
          \, 'cucumber', 'NonText')
  endif
endfunction
autocmd  FileType asciidoc,adoc call AsciidocEnableSyntaxRanges()

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]\%{Scope()}%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]
