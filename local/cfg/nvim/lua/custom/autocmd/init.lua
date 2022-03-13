local augroup = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd
local setlocal = vim.opt_local
aucmd("BufReadPost", {
  pattern = "*.log",
  callback = function()
    vim.notify_once("Yo, setting this to `txt`!!")
    vim.bo.ft = "txt"
  end,
})

local go_last_pos = augroup("go_last_pos", {})
aucmd("BufReadPost", {
  group = go_last_pos,
  callback = function()
    local line = vim.fn.line([['"]])
    if line >= 1 and line <= vim.fn.line("$") then
      vim.cmd([[normal! g'"]])
    end
  end,
})

local zig = augroup("zig_stuff", {})
aucmd("FileType", {
  pattern = "zig",
  group = zig,
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

local norg = augroup("norg_stuf", {})
aucmd("FileType", {
  pattern = "norg",
  group = norg,
  callback = function()
    vim.opt_local.breakindentopt = "list:-1"
    vim.opt_local.formatlistpat = [[^\s*[-~\*]\+\s\+]]
  end,
})

local rst = augroup("rst_something", {})
aucmd("FileType", {
  group = rst,
  pattern = "rst",
  callback = function()
    setlocal.formatoptions = setlocal.formatoptions + "n"
  end,
})

local git = augroup("git_hings", {})
aucmd("FileType", {
  group = git,
  pattern = "gitcommit",
  callback = function()
    setlocal.spell = true
  end,
})

-- TODO: Maybe port these as well?
-- augroup ASCIIDOC_THINGS
--   autocmd!
-- " autocmd FileType asciidoc,adoc  call AsciidocEnableSyntaxRanges()
--   autocmd FileType asciidoc,adoc  setlocal formatoptions+=n1 textwidth=70 spell comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
-- augroup END
--
-- " Statusline
-- function! LspStatus() abort
--   if luaeval('#vim.lsp.buf_get_clients() > 0')
--     return luaeval("require('lsp-status').status()")
--   endif
--   return ''
-- endfunction
-- augroup VimrcSo
--   " Automatically reload vimrc when it's saved "
--   au!
--   autocmd BufWritePost $MYVIMRC execute 'source $MYVIMRC'
-- augroup END
--
-- function! AsciidocEnableSyntaxRanges()
--   " source block syntax highlighting
--   if exists('g:loaded_SyntaxRange')
--     for lang in ['c', 'python', 'vim', 'javascript', 'cucumber', 'xml', 'typescript', 'sh', 'java', 'cpp', 'sh']
--       call SyntaxRange#Include( '\c\[source\s*,\s*' . lang . '.*\]\s*\n[=-]\{4,\}\n'
--             , '\]\@<!\n[=-]\{4,\}\n'
--             , lang, 'NonText')
--     endfor
--
--     call SyntaxRange#Include( '\c\[source\s*,\s*gherkin.*\]\s*\n[=-]\{4,\}\n'
--           , '\]\@<!\n[=-]\{4,\}\n'
--           , 'cucumber', 'NonText')
--   endif
-- endfunction
