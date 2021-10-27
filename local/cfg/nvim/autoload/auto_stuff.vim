au BufEnter *.log setlocal ft=txt
augroup go_last_pos
  autocmd!
  autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup END


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
