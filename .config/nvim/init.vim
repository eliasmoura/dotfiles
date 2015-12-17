call plug#begin('~/.nvim/plugged')
Plug 'git://github.com/LoKaltog/vim-easymotion'
"Plug 'https://github.com/scrooloose/syntastic'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-fugitive.git'    "Git integration
Plug 'https://github.com/tpope/vim-commentary.git'

Plug 'https://github.com/gregsexton/gitv.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'http://github.com/sjl/gundo.vim.git'

Plug 'yko/mojo.vim', { 'for': 'perl' }
Plug 'https://github.com/benekastah/neomake.git'
Plug 'git://github.com/marijnh/tern_for_vim', { 'for': ['javascript', 'html', 'css'] } "javascript/meteor things
Plug 'https://github.com/mattn/emmet-vim.git', { 'for': 'html' }
"Plug 'https://github.com/xolox/vim-easytags.git'
"Plug 'https://github.com/xolox/vim-misc.git'
Plug 'https://github.com/bbchung/clighter', { 'for': ['c','cpp'] }
"Plug 'https://github.com/bbchung/Clamp'
""Plug 'https://github.com/critiqjo/lldb.nvim'

"Plug 'https://github.com/powerman/vim-plugin-viewdoc.git'
"Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'https://github.com/Rykka/riv.vim.git', { 'commit': '6aa823848b6357f12ede3fe5ce9f9ec311694165', 'on': ['RivProjectIndex', 'RivProjectList'] }

Plug 'https://github.com/mattn/calendar-vim.git'

Plug 'https://github.com/Shougo/unite.vim.git'
"Plug 'https://github.com/Shougo/vimfiler.vim.git'
"Plug 'https://github.com/Shougo/deoplete.nvim.git'
"Plug 'https://github.com/Shougo/unite-outline.git'
Plug 'https://github.com/Shougo/vimproc.vim.git', { 'do': 'make'}
Plug 'https://github.com/Shougo/neomru.vim'
"Plug 'https://github.com/thinca/vim-ref.git'
Plug 'https://github.com/daisuzu/unite-notmuch.git'

Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/jeaye/color_coded.git', { 'do': 'cmake . && make', 'for': ['c','cpp'] }
Plug 'https://github.com/nathanaelkane/vim-indent-guides'
call plug#end()

let mapleader = ","
set backup          " keep a backup file (restore to previous version)
set writebackup
set undofile        " keep an undo file (undo changes after closing)
set ruler           " show the cursor position all the time
set cursorline
set wildmode=list:full
set clipboard=unnamed " Use the Xorg's primary buffer as default register.
set mouse=n
syntax on
filetype indent plugin on
let base16colorspace=256
colorscheme base16-atelierlakeside
set background=dark
set vb              " visual bell
set showcmd         " display incomplete commands
set number          "display the line number
set display+=lastline
set spelllang=en_us
set spellsuggest=best
set dictionary+=en.utf-8.add,en.utf-8.spl
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set undodir=~/.cache/nvim/undo//
set directory=~/.cache/nvim/swap//
set backupdir=~/.cache/nvim/backup//
"set shada+=n$HOME/.cache/nvim/nvim.shada
set shada='1000,f1,<500,h
set showmode
set colorcolumn=110
set splitbelow
set splitright
set smartcase
set smartindent
set hidden
set list
set tags+=~/.config/nvim/systags
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:\ 
set cpoptions+=$        "put a $ in the end of the change mode
augroup VimrcSo
  " Automatically reload vimrc when it's saved "{{{
  au!
  autocmd BufWritePost $MYVIMRC so $MYVIMRC
augroup END
set statusline=%n\ %F\ %M%=%y%w%r%h\ %{&fenc}\ %B\ %l,%c\ %p%%\ %L
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \ if &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif
autocmd FileType rst set formatoptions+=an

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif


let g:viewdoc_open='topleft new'
let g:viewdoc_only=1
nnoremap <leader>M :call ExecuteInShell("clear; make")<CR>
nnoremap <leader>ct :silent !ctags -R .<CR>:redraw!<CR>
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>b :call ToggleBackground()<CR>
nnoremap <leader><Tab> :silent :retab!<CR>

"Completision
inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L

autocmd! BufWritePost * Neomake
let g:neomake_javascript_jshint_maker = {
      \ 'args': ['--verbose'],
      \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
      \ }
let g:neomake_javascript_enabled_makers = ['jshint']

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_perl_checker = 1
"let g:syntastic_debug = 0
"let g:syntastic_warning_symbol = '⚠'
""let g:syntastic_shell = '/usr/bin/zsh'
"
"let g:syntastic_perl_perl_exec = '/usr/bin/perl'
"let g:syntastic_perl_interpreter = '/usr/bin/perl'
"
"" Use clang when checking C/C++ syntax.
"let g:syntastic_c_compiler = 'clang'
"let g:syntastic_c_compiler_options = '-std=c99'
"let g:syntastic_c_remove_include_errors = 0
"
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = '-std=c++14'
"let g:syntastic_cpp_remove_include_errors = 0

nnoremap    [unite]     <Nop>
nmap        s           [unite]
"let unite = unite#get_current_unite()
"if index(unite.source_names, 'notmuch') > -1
"        nmap <buffer><expr> r unite#do_action('read')
"endif
call unite#custom#profile('default', 'context', 
      \ {
      \   'start_insert':1,
      \   'no_split':1,
      \   'hide': 1,
      \   'direction': 'topright',
      \   'prompt_direction': 'below',
      \   'prompt_visible': 1,
      \   'prompt': '>>>',
      \ })

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec', 'matchers', 'matcher_project_files')
"call unite#custom#source('file', 'ignore_pattern', 
"            \ ['./.git',
"            \  '\./\.meteor',
"            \  './packages',
"            \  '.cache',
"            \ ])

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
      \ '-i --vimgrep --hidden --ignore ' .
      \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_file=$HOME.'/.cache/nvim/yank'
let g:tern_show_signature_in_pum = 1
"let g:tern_show_argument_hints = 'on_move'

nnoremap [unite]p  :<C-u>Unite buffer file_rec/git<CR>
nnoremap [unite]f   :<C-u>Unite buffer file<CR>
nnoremap [unite]y   :<C-u>Unite history/yank<CR>
nnoremap [unite]s   :<C-u>Unite grep:.<CR>
nnoremap [unite]b   :<C-u>Unite buffer bookmark<CR>
nnoremap <silent> [unite]m  :<C-u>Unite notmuch -create -buffer-name=notmuch -no-start-insert -no-quit -keep-focus<CR>
"nnoremap [unite]m   :<C-u>Unite -input=
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.cpp = ['buffer', 'tag', 'clang']
"let g:clighter_libclang_file = '/usr/lib/libclang.so'
map Q gq
inoremap <C-U> <C-G>u<C-U>
nnoremap ; :
nnoremap : ;            " change the command key on normal mode to :
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>        "remove trailings

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:EasyMotion_do_mapping = 1

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

"Riv stuff
let g:riv_highlight_code = "lua,python,c,cpp,javascript,vim,sh"
let notes = { 'Name': 'Personal Notes', 'path': '~/writings/notes', }
let blog = { 'Name': 'Personal Blog', 'path': '~/writings/blog', }
let mixedlang = { 'Mixedlang': 'Mixedlang', 'path': '~/writings/projects/mixedlang', }
let g:riv_projects = [notes, blog, mixedlang]
"let project1.scratch_path = 'diary'
let g:riv_todo_datestamp = 2
"Calendar styff
let g:calendar_diary=$HOME.'/writings/diary'

let g:vimwiki_list = [{'path': '~/writings/vimwiki/base/', 'path_html': '~/writings/vimwiki/base/html/'},]


function! ToggleBackground()
  if &background == "light"
    set background=dark
  else
    set background=light
  endif
endfunction
