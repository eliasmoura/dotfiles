call plug#begin('~/local/share/nvim/plugins')
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
Plug 'https://github.com/bbchung/Clamp.git'
let g:clamp_libclang_file = '/usr/lib/libclang.so'
Plug 'http://github.com/sjl/gundo.vim.git'
Plug 'git://github.com/marijnh/tern_for_vim', {
      \ 'do': 'npm install; cd node_modules/tern/plugin; curl -O https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js',
      \ 'for': ['javascript', 'html', 'css']
      \ } "javascript/meteor things
Plug 'https://github.com/mattn/emmet-vim.git', { 'for': 'html' }
Plug 'https://github.com/Shougo/deoplete.nvim.git'
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.cpp = ['buffer', 'tag', 'clang']
Plug 'https://github.com/SirVer/ultisnips.git'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
Plug 'https://github.com/benekastah/neomake.git'
call plug#end()

autocmd! BufWritePost * Neomake
let g:neomake_javascript_jshint_maker = {
      \ 'args': ['--verbose'],
      \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
      \ }
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_c_lint_maker = {
      \ 'args': ['--options', '-std=c99']
      \ }
let g:neomake_clang_maker = {
      \ 'exe': 'make',
      \ 'args': ['--build'],
      \ 'errorformat': '%f:%l:%c: %m',
      \ }
let g:neomake_javascript_jshint_maker = {
      \ 'args': ['--verbose'],
      \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
      \ }
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_c_clang_args = neomake#makers#ft#c#clang()['args'] + ['-std=c99']
let g:neomake_cpp_clang_args = neomake#makers#ft#cpp#clang()['args'] + ['-std=c++11']

let vimple_init_vn = 0
set undofile        " keep an undo file (undo changes after closing)
set ruler           " show the cursor position all the time
set cursorline
set wildmode=list:full
set path=**
set wildignore=*.class,*.pyc,*~
set suffixesadd=.java,.py,.pl,.js,.html
set clipboard=unnamed " Use the Xorg's primary buffer as default register.
set mouse=n
syntax on
filetype indent plugin on
let base16colorspace=256
colorscheme base16-apathy
set background=dark
set vb              " visual bell
set showcmd         " display incomplete commands
set display+=lastline
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
set colorcolumn=110
set splitbelow
set splitright
set smartcase
set smartindent
set list
set tags+=~/local/share/nvim/systags
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
nnoremap ; :
nnoremap : ;            " change the command key on normal mode to :
let mapleader = ","
nnoremap <leader>rt :%s/\s\+$//<cr>:let @/=''<CR>        "remove trailings
nnoremap <leader>m :make<CR>
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
