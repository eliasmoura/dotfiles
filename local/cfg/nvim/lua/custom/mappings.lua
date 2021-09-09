local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap
-- local xnoremap = vim.keymap.xnoremap
local vnoremap = vim.keymap.vnoremap
local tnoremap = vim.keymap.tnoremap
-- local nmap = vim.keymap.nmap
-- local imap = vim.keymap.imap
-- local xmap = vim.keymap.xmap
-- local vmap = vim.keymap.vmap
-- local tmap = vim.keymap.tmap
-- local noremap = vim.keymap.noremap
local map = vim.keymap.map

vim.api.nvim_set_keymap('', ' ', '', {})
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

map{'Q', 'gq'}
nnoremap{'<leader>rt', [[:%s/\s\+$//g<cr>:let @/=''<cr>]]}
nnoremap{'<leader>/', ':silent :nohlsearch<CR>:<CR>'}
nnoremap{'<leader><Tab>', ':silent :retab!<CR>'}

-- Git
nnoremap{'<leader>gg', ':Git '}
nnoremap{'<leader>gG', ':Git! '}
nnoremap{'<leader>gs', '<cmd>Git<cr>'}
nnoremap{'<leader>gc', '<cmd>Git commit<cr>'}
nnoremap{'<leader>gm', '<cmd>Git merge<cr>'}
nnoremap{'<leader>gl', '<cmd>Git log<cr>'}

nnoremap{'<m-m>', ':make clean all<CR>'}
nnoremap{'<m-s-m>', ':make '}
tnoremap{'<Esc>', '<C-\\><C-n>'}
nnoremap{'<Esc>', '<C-\\><C-n>'}
nnoremap{'<C-S-a>', '<C-^>'}

-- "Completision
inoremap{'<c-]>', '<c-x><c-]>'}
inoremap{'<c-f>', '<c-x><c-f>'}
inoremap{'<c-d>', '<c-x><c-d>'}
inoremap{'<c-l>', '<c-x><c-l>'}

-- LSP
M.lsp_on_attach = function()
  nnoremap{'<leader>la', vim.lsp.buf.code_action}
  nnoremap{'<leader>lf', vim.lsp.buf.formatting}
  nnoremap{'<leader>ls', vim.lsp.buf.document_symbol}
  nnoremap{'<leader>lh', vim.lsp.buf.hover}
  nnoremap{'<leader>lr', vim.lsp.buf.references}
  nnoremap{'<leader>lR', vim.lsp.buf.rename}
  nnoremap{'<leader>ldg', vim.lsp.diagnostic.get_all}
  nnoremap{'<leader>lda', vim.lsp.diagnostic.goto_prev}
  nnoremap{'<M-n>', vim.lsp.diagnostic.goto_next}
  nnoremap{'<M-p>', vim.lsp.diagnostic.goto_prev}
  nnoremap{'<M-o>', vim.lsp.diagnostic.show_line_diagnostics}
  nnoremap{'<M-Q>', vim.lsp.util.set_qflist}
  nnoremap{'<M-q>', vim.lsp.util.set_loclist}
  nnoremap{'<c-]>', vim.lsp.buf.definition}
end

nnoremap{'<M-c>',   ':lclose<cr>'}
nnoremap{'<C-n>',   ':lnext<cr>'}
nnoremap{'<c-p>',   ':lprev<cr>'}
nnoremap{'<m-s-c>', ':cclose<cr>'}
nnoremap{'<m-s-n>', ':cnext<cr>'}
nnoremap{'<m-s-p>', ':cprev<cr>'}

--Telescope
local tl = require("custom.telescope")
nnoremap{'<leader>tt',      tl.builtin}
nnoremap{'<leader>ti',      tl.edit_nvim}
nnoremap{'<leader>tcf',     tl.edit_cfg}
nnoremap{'<leader>tg',      tl.live_grep}
nnoremap{'<leader>tb',      tl.buffers}
nnoremap{'<leader>tf',      tl.navigate}
nnoremap{'<leader>tm',      tl.man_pages}
nnoremap{'<leader>tcs',     tl.colorscheme}
nnoremap{'<leader>tq',      tl.quickfix}
nnoremap{'<leader>tl',      tl.loclist}
nnoremap{'<leader>tss',     tl.spell_suggest}
nnoremap{'<leader>th',      tl.help_tags}
nnoremap{'<leader><space>', tl.find_files}
nnoremap{'<leader>rr',      tl.reloader}

-- vim.cmd [[runtime plugin/vimspector.vim]]
-- Vimspector
-- nnoremap{'<F9>', vim.fn['vimspector#ToggleBreakpoint']}
-- nnoremap{'<F5>', vim.fn['vimspector#Continue']}--	When debugging, continue. Otherwise start debugging.
-- nnoremap{'<leader>vl', vim.fn['vimspector#Launch']}--	When debugging, continue. Otherwise start debugging.
-- nnoremap{'<F3>', vim.fn['vimspector#Stop']}--	Stop debugging.
-- nnoremap{'<F4>', vim.fn['vimspector#Restart']}--	Restart debugging with the same configuration.
-- nnoremap{'<F6>', vim.fn['vimspector#Pause']}--	Pause debuggee.
-- nnoremap{'<F9>', vim.fn['vimspector#ToggleBreakpoint']}--	Toggle line breakpoint on the current line.
-- nnoremap{'<leader><F9>', vim.fn['vimspector#ToggleConditionalBreakpoint']}--	Toggle conditional line breakpoint on the current line.
-- nnoremap{'<F8>', vim.fn['vimspector#AddFunctionBreakpoint']}--	Add a function breakpoint for the expression under cursor
-- nnoremap{'<leader><F8>', vim.fn['vimspector#RunToCursor']}--	Run to Cursor
-- nnoremap{'<F10>', vim.fn['vimspector#StepOver']}--	Step Over
-- nnoremap{'<F11>', vim.fn['vimspector#StepInto']}--	Step Into
-- nnoremap{'<F12>', vim.fn['vimspector#StepOut']}--	Step out of current function scope
-- nnoremap{'<F1>', vim.fn['vimspector#Reset']}--	Step out of current function scope
nnoremap{'<leader>db', require('dap').toggle_breakpoint}
-- nnoremap{'<leader>dB', require('dap').set_breackpoint}
nnoremap{'<leader>dC', require('dap').continue}--	when debugging, continue. otherwise start debugging.
nnoremap{'<leader>dc', require('dap').run_to_cursor}--	when debugging, continue. otherwise start debugging.
-- nnoremap{'<leader>dL', require('dap').launch}--	when debugging, continue. otherwise start debugging.
nnoremap{'<leader>d<space>', require('dap').stop}--	stop debugging.
nnoremap{'<leader>dr', require('dap').run}--	restart debugging with the same configuration.
nnoremap{'<leader>dR', require('dap').restart}--	restart debugging with the same configuration.
nnoremap{'<leader>dP', require('dap').pause}--	pause debuggee.
nnoremap{'<leader>d<space>', require('dap').run_to_cursor}--	run to cursor
nnoremap{'<leader>dS', require('dap').step_over}--	step over
nnoremap{'<leader>ds', require('dap').step_into}--	step into
nnoremap{'<F5>',       require('dap').step_into}--	step into
nnoremap{'<leader>do', require('dap').step_out}--	step out of current function scope
nnoremap{'<leader>du', require('dap').up}--	step out of current function scope
nnoremap{'<leader>dd', require('dap').down}--	step out of current function scope

nnoremap{'<leader>tB', vim.custom.toggleBackground}
nnoremap{'cu', ':UndotreeToggle<CR>'}
nnoremap{'gl', ':EasyAlign<CR>'}
vnoremap{'gl', ':EasyAlign<CR>'}

nnoremap{'<leader>ng', require('neogen').generate}

wk.register_keymap('leader', leader_map)

return M
