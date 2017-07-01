" XXX Vim doesn't mkdir the backupdir path (bug?) so let's do that ourselves
" instead.
if !isdirectory($LOCAL . "/share/nvim/backup")
    call mkdir($LOCAL . "/share/nvim/backup", "p")
endif
set undofile        " keep an undo file (undo changes after closing)
set ruler           " show the cursor position all the time
set number
set showbreak=…
set cursorline
set laststatus=2
set statusline=%1* "I couldn't remove the highlighting or change the color, so I'm using this shit to remove it
set statusline+=%h%w%f%m%r\ 
set statusline+=%=[%n:%{&ff}/%Y]
set statusline+=%=[0x%04.4B][%03b][%p%%\ line\ %l\ of\ %L]
set hidden
autocmd FileType c setlocal path+=/usr/avr/include
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
set wildmode=list:full
set wildignore=*.pyc,*\~,*.o,*.obj
set suffixesadd=.py,.pl,.js,.html,.c,.h,.cpp,.hh
set mouse=n
set termguicolors
let base16colorspace=256
colorscheme base16-atelier-seaside
hi StatusLine   ctermbg=white   ctermfg=4
hi StatusLineNC ctermbg=red     ctermfg=blue
set vb              " visual bell
set showcmd         " display incomplete commands
set spelllang=en_us
set spellsuggest=best
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backupdir=~/local/share/nvim/backup//
set shada='1000,f1,<500,h
set colorcolumn=90
set splitright
set splitbelow
set smartcase
set smartindent
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:\ 
set cpoptions+=$        "put a $ in the end of the change mode
set inccommand=""
let vimple_init_vn = 0
au BufEnter *.log,*.txt setlocal ft=txt

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
if !exists(":W")
  " Use W to call sudo to write a read-only file with elevated privaliges
  command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
endif

autocmd FileType rst setlocal formatoptions+=n
autocmd FileType gitcommit setlocal spell

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

call plug#begin('~/local/share/nvim/plugins')
  Plug 'benekastah/neomake'
  "Look the changes on the file based on the last commit on the git project
  Plug 'https://github.com/airblade/vim-gitgutter'
  
  " Plug 'https://github.com/fmoralesc/nvimfs'
  " Plug 'https://github.com/vim-scripts/TxtBrowser',     { 'for': 'txt'}
  Plug 'https://github.com/vim-pandoc/vim-pandoc'
  Plug 'https://github.com/beyondmarc/glsl.vim.git',    { 'for': 'gls'}
  Plug 'https://github.com/vim-scripts/taglist.vim',
  " Makes vim/nvim slow when there are list blocks in the view
  " Plug 'https://github.com/chrisbra/NrrwRgn.git',       { 'for': [ 'adoc', 'asciidoc' ] }
  " Plug 'https://github.com/vim-scripts/SyntaxRange.git',{ 'for': [ 'adoc', 'asciidoc' ] }
  " Plug 'https://github.com/dahu/vim-asciidoc',          { 'for': [ 'adoc', 'asciidoc' ] }
  Plug 'https://github.com/dahu/vimple' ",                { 'for': [ 'adoc', 'asciidoc' ] }
  " Plug 'https://github.com/vim-scripts/rfc-syntax',     { 'for': [ 'rfc' , 'txt'      ] }
  Plug 'https://github.com/tpope/vim-surround'
  Plug 'https://github.com/tpope/vim-repeat.git'
  Plug 'https://github.com/tpope/vim-fugitive.git'    "Git integration
  Plug 'https://github.com/tpope/vim-commentary.git'
  Plug 'https://github.com/tommcdo/vim-exchange.git'
  Plug 'http://github.com/sjl/gundo.vim.git'
  nnoremap cu :GundoToggle<CR>
  "This plugin isn't worth. Too sloww when there are a lot of changes.
  "Plug 'https://github.com/arakashic/chromatica.nvim'
  Plug 'https://github.com/junegunn/vim-easy-align',
  nnoremap gl :EasyAlign<CR>
  vnoremap gl :EasyAlign<CR>
  Plug 'https://github.com/plasticboy/vim-markdown'
  Plug 'https://github.com/jceb/vim-orgmode',
  Plug 'https://github.com/tpope/vim-speeddating'
  Plug 'git://github.com/marijnh/tern_for_vim', {
        \ 'do': 'npm install; cd node_modules/tern/plugin; curl -O https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js',
        \ 'for': ['javascript', 'html', 'css']
        \ } "javascript/meteor things
  Plug 'https://github.com/groenewege/vim-less'
  " Plug 'https://github.com/mattn/emmet-vim.git', { 'for': [ 'html', 'css' ] }
  Plug 'https://github.com/sirver/UltiSnips'
  " let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  let g:UltiSnipsSnippetDirectories=['/home/kotto/local/cfg/nvim/UltiSnips/']
  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"

  Plug 'https://github.com/dbgx/lldb.nvim'
call plug#end()

nnoremap <M-b>  <Plug>LLBreakSwitch
nnoremap <M-c>  :LL continue<cr>
nnoremap <M-n>  :LL next<cr>
nnoremap sk     :LL process interrupt<cr>
nnoremap <M-p>  :LL print <C-R>=expand('<cword>')<cr>
nnoremap <C-p>  :LL print <C-R>=lldb#util#get_selection()<cr><cr>

nnoremap <leader>G    :Git
nnoremap <leader>gG   :Git!
nnoremap <leader>gs   :Gstatus<cr>
nnoremap <leader>gc   :Gcommit -m<cr>
nnoremap <leader>gm   :Gmerge<cr>
nnoremap <leader>gl   :Glog<cr>

set foldmethod=syntax

autocmd! BufWritePost * Neomake
" Prevent neomake reporting its exit status and suppressing the write message.
" https://github.com/benekastah/neomake/issues/238
let neomake_verbose = 0
let g:neomake_open_list = 2
let g:neomake_sh_shellcheck_args   = neomake#makers#ft#sh#shellcheck()['args'] + ['-x']

au BufRead,bufNewFile /home/kotto/dev/python/* let g:neomake_python_enabled_makers = [ 'flake8',  'python' ]
let g:neomake_python_flake8_args = neomake#makers#ft#python#flake8()['args'] +  [ '--ignore=E302,E201,E501,E202' ]

" Use clang when checking C/C++ syntax.
let g:neomake_c_avr_maker = { 'exe': 'avr-gcc', 'args': [ '-o >/dev/null', '-mmcu=atmega328p' ], 'errorformat': '%f:%l:%c: %m' }
au BufRead,bufNewFile /home/kotto/dev/arduino/* let g:neomake_c_enabled_makers = [ 'avr' ]
au BufRead,bufNewFile /home/kotto/dev/arduino/* let g:neomake_CPP_enabled_makers = [ 'avr' ]
let g:neomake_c_clang_args = neomake#makers#ft#c#clang()['args'] + ['-std=c11', '-Werror', '-Wconversion', '-Wpedantic', '-Wformat-security', '-Wno-missing-field-initializers' ]
let g:neomake_c_gcc_args   = neomake#makers#ft#c#gcc()['args'] + ['-std=c11', '-Werror', '-Wconversion', '-Wpedantic', '-Wformat-security']
" let g:neomake_c_enabled_makers = [ 'clang' ]
let g:neomake_c_arm_maker = { 'exe':
              \ 'arm-none-eabi-gcc', 'args':
              \ [   '-o > /dev/null',
                  \ '-DUSE_STDPERIPH_DRIVER',
                  \ '-I.',
                  \ '-I../stm32/lib/inc/',
                  \ '-I../stm32/core',
                  \ '-I../stm32/device/'],
              \ 'errorformat': '%f:%l:%c: %m' }
au BufRead,bufNewFile /home/kotto/dev/arm/stm/f1/* let g:neomake_c_gcc_args = neomake#makers#ft#c#gcc()['args'] + [ '-DSTM32F10X_MD_VL' ]
au BufRead,bufNewFile /home/kotto/dev/arm/stm/* let g:neomake_c_enabled_makers = [ 'arm' ]
" au BufRead,bufNewFile /home/kotto/dev/arm/stm/* set makeprg =make\ main.o
" au BufRead,bufNewFile /home/kotto/dev/arm/stm/*  let g:neomake_c_arm_maker = { 'exe': 'arm-none-eabi-gcc', 'args': [ '-o >/dev/null',  '-ISTM32F4xx_StdPeriph_Driver/inc/', '-Ilib' ], 'errorformat': '%f:%l:%c: %m' }

map Q gq

inoremap <C-U> <C-G>u<C-U>
"change the command key on normal mode to :
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
let mapleader = ' '
nnoremap <leader>rt    :%s/\s\+$//g<cr>:let @/=''<CR> "remove trailings
nnoremap <M-m>         :make<CR>
nnoremap <leader>ct    :silent !ctags -R .<CR>:redraw!<CR>
nnoremap <leader>/     :silent :nohlsearch<CR>:<CR>
nnoremap <leader><Tab> :silent :retab!<CR>
nnoremap <leader>i     :edit ~/local/cfg/nvim/init.vim<CR>
nnoremap <leader>t     :TlistToggle<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-S-a>        <C-^>

"Completision
inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L

nnoremap <leader>b :call ToggleBackground()<CR>
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
" autocmd FileType asciidoc,adoc  call AsciidocEnableSyntaxRanges()
autocmd FileType asciidoc,adoc  setlocal formatoptions+=n1 textwidth=70 spell
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
" let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
