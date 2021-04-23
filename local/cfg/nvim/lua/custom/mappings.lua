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

-- LSP)
nnoremap{'<leader>dh', vim.lsp.buf.hover}
nnoremap{'<leader>ds', vim.lsp.buf.hover}
nnoremap{'<leader>tr', vim.lsp.buf.rename}
nnoremap{'<leader>da', vim.lsp.diagnostic.goto_prev}
nnoremap{'<M-n>', vim.lsp.diagnostic.goto_next}
nnoremap{'<M-p>', vim.lsp.diagnostic.goto_prev}
nnoremap{'<M-o>', vim.lsp.diagnostic.show_line_diagnostics}
nnoremap{'<M-Q>', vim.lsp.util.set_qflist}
nnoremap{'<M-q>', vim.lsp.util.set_loclist}
-- nnoremap{'<c-]>', vim.lsp.buf.definition}
--
nnoremap{'<M-c>', vim.fn['lclose']}
nnoremap{'<C-n>', vim.fn['lnext']}
nnoremap{'<C-p>', vim.fn['lprev']}
nnoremap{'<C-S-c>', vim.fn['cclose']}
nnoremap{'<C-S-n>', vim.fn['cnext']}
nnoremap{'<C-S-p>', vim.fn['cprev']}

--Telescope
local tl = require("custom.telescope")
nnoremap{'<leader>tt',      tl.builtin}
nnoremap{'<leader>ti',      tl.edit_nvim}
nnoremap{'<leader>tc',      tl.edit_cfg}
nnoremap{'<leader>tg',      tl.live_grep}
nnoremap{'<leader>b',       tl.buffers}
nnoremap{'<leader>f',       tl.navigate}
nnoremap{'<leader>m',       tl.man_pages}
nnoremap{'<leader>cc',      tl.colorscheme}
nnoremap{'<leader><c-c>',   tl.quickfix}
nnoremap{'<leader><c-l>',   tl.loclist}
nnoremap{'<leader>ss',      tl.spell_suggest}
nnoremap{'<leader>th',      tl.help_tags}
nnoremap{'<leader><space>', tl.find_files}
nnoremap{'<leader>rr',      tl.reloader}

-- Vimspector
nnoremap{'<F9>', vim.fn['vimspector#ToggleBreakpoint']}
nnoremap{'<F5>', vim.fn['vimspector#Continue']}--	When debugging, continue. Otherwise start debugging.
nnoremap{'<leader><F5>', vim.fn['vimspector#Launch']}--	When debugging, continue. Otherwise start debugging.
nnoremap{'<F3>', vim.fn['vimspector#Stop']}--	Stop debugging.
nnoremap{'<F4>', vim.fn['vimspector#Restart']}--	Restart debugging with the same configuration.
nnoremap{'<F6>', vim.fn['vimspector#Pause']}--	Pause debuggee.
nnoremap{'<F9>', vim.fn['vimspector#ToggleBreakpoint']}--	Toggle line breakpoint on the current line.
nnoremap{'<leader><F9>', vim.fn['vimspector#ToggleConditionalBreakpoint']}--	Toggle conditional line breakpoint on the current line.
nnoremap{'<F8>', vim.fn['vimspector#AddFunctionBreakpoint']}--	Add a function breakpoint for the expression under cursor
nnoremap{'<leader><F8>', vim.fn['vimspector#RunToCursor']}--	Run to Cursor
nnoremap{'<F10>', vim.fn['vimspector#StepOver']}--	Step Over
nnoremap{'<F11>', vim.fn['vimspector#StepInto']}--	Step Into
nnoremap{'<F12>', vim.fn['vimspector#StepOut']}--	Step out of current function scope
nnoremap{'<F1>', vim.fn['vimspector#REset']}--	Step out of current function scope

nnoremap{'<leader>tb', '<cmd>lua toggleBackground()<CR>'}
nnoremap{'cu', ':UndotreeToggle<CR>'}
nnoremap{'gl', ':EasyAlign<CR>'}
vnoremap{'gl', ':EasyAlign<CR>'}