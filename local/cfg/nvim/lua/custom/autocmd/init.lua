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
      vim.api.nvim_command([[normal! g'"]])
    end
  end,
})

local golang_stuff = augroup("golang_stuff", {})
aucmd("FileType", {
  pattern = "go",
  group = golang_stuff,
  callback = function()
    vim.opt.expandtab = false
    vim.opt.listchars = [[tab:  ,trail:-,extends:>,precedes:<,nbsp:+,eol:$]]
  end,
})
local zig_stuff = augroup("zig_stuff", {})
aucmd("FileType", {
  pattern = "zig",
  group = zig_stuff,
  callback = function()
    setlocal.tabstop = 4
    setlocal.shiftwidth = 4
    setlocal.softtabstop = 4
  end,
})

local ok, Job = pcall(require, "plenary.job")
if ok then
local Job = require("plenary.job")
-- local zig_ns = vim.api.nvim_create_namespace("Zig linter?")
-- local zig_lint = augroup("zig_lint", {})
-- aucmd("BufWritePost", {
--   pattern = "*.zig",
--   group = zig_lint,
--   callback = function(data)
--     bufnr = data.buf or vim.api.nvim_get_current_buf()
--
--     local command = {
--       "zig",
--       "ast-check",
--       data.file,
--     }
--     writer = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--
--     vim.fn.jobstart(command, {
--       on_stdout = function(_, outdata)
--         -- Schedule this so that it doesn't do dumb stuff like printing two things.
--         if #outdata > 1 then
--           P(data)
--         end
--       end,
--       on_stderr = function(_, errdata)
--         -- Schedule this so that it doesn't do dumb stuff like printing two things.
--         local errlist = {}
--         local index = 0
--         -- vim.diagnostic.reset(zig_ns, bufnr)
--         for _, l in ipairs(errdata) do
--           -- local  = l:match("(.*):(%d+):(%d+): error:(.*)")
--           if string.len(l) > 0 then
--             P(errdata)
--             print("size: ", string.len(l), l)
--             print("[zig ast-check] Failed to process due to errors")
--
--             file, line, col, err =
--               string.match(l, "(.*):(%d+):(%d+): error: (.*)")
--             line = tonumber(line, 10)
--             col = tonumber(col, 10)
--             if file ~= nil and line ~= nil and col ~= nil and err ~= nil then
--               print(
--                 string.format("%s:%d:%d: ERROR: [%s]", file, line, col, err)
--               )
--
--               table.insert(errlist, {
--                 bufnr = bufnr,
--                 lnum = line - 1,
--                 end_lnum = line - 1,
--                 col = col,
--                 end_col = col,
--                 severity = vim.diagnostic.severity.ERROR,
--                 message = err,
--                 user_data = {},
--               })
--               index = index + 1
--             else
--               table.insert(errlist[index].user_data, l)
--             end
--           end
--         end
--         if #errlist > 0 then
--           print("things: ", zig_ns, bufnr)
--           P(errlist)
--           vim.diagnostic.set(zig_ns, bufnr, errlist, {})
--           vim.diagnostic.show(zig_ns, nil, nil, nil)
--         end
--       end,
--       --vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
--       -- vim.api.nvim_buf_clear_namespace(bufnr, Luasnip_ns_id, 0, -1)
--
--       -- Handle some weird snippet problems. Not everyone will necessarily have this problem.
--       -- Luasnip_current_nodes = Luasnip_current_nodes or {}
--       -- Luasnip_current_nodes[bufnr] = nil
--     })
--   end,
-- })
local zig = {}
zig.format = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local j = Job:new({
    "zig",
    "fmt",
    "--stdin",
    writer = vim.api.nvim_buf_get_lines(0, 0, -1, false),
  })

  local output = j:sync()

  if j.code ~= 0 then
    -- Schedule this so that it doesn't do dumb stuff like printing two things.
    -- vim.schedule(function()
    --   print("[zig fmt] Failed to process due to errors")
    --   print(vim.inspect(j))
    --   print(vim.inspect(j.stderr_result()))
    -- end)

    return
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
  -- vim.api.nvim_buf_clear_namespace(bufnr, Luasnip_ns_id, 0, -1)

  -- Handle some weird snippet problems. Not everyone will necessarily have this problem.
  Luasnip_current_nodes = Luasnip_current_nodes or {}
  Luasnip_current_nodes[bufnr] = nil
end
-- local zig_format = augroup("zig_format", {})
-- aucmd("BufWritePre", {
--   pattern = "*.zig",
--   group = zig_format,
--   callback = function(data)
--     zig.format(data.buf)
--   end,
-- })
vim.custom.zig = zig
end

local norg = augroup("norg_stuf", {})
aucmd("FileType", {
  pattern = "norg",
  group = norg,
  callback = function()
    vim.opt_local.breakindentopt = "list:-1"
    vim.opt_local.formatlistpat = [[^\s*[-~\*]\+\s\+]]
    vim.opt_local.foldmethod = "syntax"
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

local packer_user_config = augroup("packer_user_config", {})
aucmd("BufWritePost", {
  group = packer_user_config,
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

aucmd(
  { "InsertLeave", "WinEnter", "CmdlineLeave" },
  { pattern = "*", command = "set cursorline" }
)
aucmd(
  { "InsertEnter", "WinLeave", "CmdlineEnter" },
  { pattern = "*", command = "set nocursorline" }
)

local highlight_yank = augroup("highlight_yank", {})
aucmd("TextYankPost", {
  pattern = "*",
  group = highlight_yank,
  --silent!
  callback = function()
    vim.highlight.on_yank({ timeout = 50 })
  end,
})

augroup("lsp_formatting", { clear = false })
augroup("lsp_codelens", { clear = false })

-- TODO: Maybe port these as well?
-- augroup ASCIIDOC_THINGS
--   autocmd!
-- " autocmd FileType asciidoc,adoc  call AsciidocEnableSyntaxRanges()
--   autocmd FileType asciidoc,adoc  setlocal formatoptions+=n1 textwidth=70 spell comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>
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
