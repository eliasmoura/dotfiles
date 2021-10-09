local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap
local vnoremap = vim.keymap.vnoremap
local tnoremap = vim.keymap.tnoremap
local map = vim.keymap.map
local M = {}
-- local xnoremap = vim.keymap.xnoremap

vim.g.mapleader = " "
vim.g.maplocalleader = ","

map({ "Q", "gq" })
nnoremap({ "<leader>rt", [[:%s/\s\+$//g<cr>:let @/=''<cr>]] })
nnoremap({ "<leader>/", ":silent :nohlsearch<CR>:<CR>" })
nnoremap({ "<leader><Tab>", ":silent :retab!<CR>" })

-- Git
nnoremap({ "<leader>gg", ":Git " })
nnoremap({ "<leader>gG", ":Git! " })
nnoremap({ "<leader>gs", "<cmd>Git<cr>" })
nnoremap({ "<leader>gc", "<cmd>Git commit<cr>" })
nnoremap({ "<leader>gm", "<cmd>Git merge<cr>" })
nnoremap({ "<leader>gl", "<cmd>Git log<cr>" })

-- Lsp
-- For the Lsp mappings see lua/custom/lsp.lua

nnoremap({ "<m-m>", ":make clean all<CR>" })
nnoremap({ "<m-s-m>", ":make " })
tnoremap({ "<Esc>", "<C-\\><C-n>" })
nnoremap({ "<Esc>", "<C-\\><C-n>" })
nnoremap({ "<C-S-a>", "<C-^>" })

-- "Completision

nnoremap({ "<M-c>", ":lclose<cr>" })
nnoremap({ "<C-n>", ":lnext<cr>" })
nnoremap({ "<c-p>", ":lprev<cr>" })
nnoremap({ "<m-s-c>", ":cclose<cr>" })
nnoremap({ "<m-s-n>", ":cnext<cr>" })
nnoremap({ "<m-s-p>", ":cprev<cr>" })

--Telescope
local tl = require("custom.telescope")
nnoremap({ "<leader>tt", tl.builtin })
nnoremap({ "<leader>ti", tl.edit_nvim })
nnoremap({ "<leader>tcf", tl.edit_cfg })
nnoremap({ "<leader>tg", tl.live_grep })
nnoremap({ "<leader>tb", tl.buffers })
nnoremap({ "<leader>tf", tl.navigate })
nnoremap({ "<leader>tm", tl.man_pages })
nnoremap({ "<leader>tcs", tl.colorscheme })
nnoremap({ "<leader>tq", tl.quickfix })
nnoremap({ "<leader>tl", tl.loclist })
nnoremap({ "<leader>tss", tl.spell_suggest })
nnoremap({ "<leader>th", tl.help_tags })
nnoremap({ "<leader><space>", tl.find_files })
nnoremap({ "<leader>rr", tl.reloader })

nnoremap({ "<M-n>", vim.diagnostic.goto_next })
nnoremap({ "<M-p>", vim.diagnostic.goto_prev })
nnoremap({ "<M-o>", vim.diagnostic.show_line_diagnostics })

nnoremap({ "<leader>db", require("dap").toggle_breakpoint })
nnoremap({ "<leader>dC", require("dap").continue }) --	when debugging, continue. otherwise start debugging.
nnoremap({ "<leader>dc", require("dap").run_to_cursor }) --	when debugging, continue. otherwise start debugging.
nnoremap({ "<leader>d<space>", require("dap").stop }) --	stop debugging.
nnoremap({ "<leader>dr", require("dap").run }) --	restart debugging with the same configuration.
nnoremap({ "<leader>dR", require("dap").restart }) --	restart debugging with the same configuration.
nnoremap({ "<leader>dP", require("dap").pause }) --	pause debuggee.
nnoremap({ "<leader>d<space>", require("dap").run_to_cursor }) --	run to cursor
nnoremap({ "<leader>ds", require("dap").step_over }) --	step over
nnoremap({ "<leader>dS", require("dap").step_into }) --	step into
nnoremap({ "<F5>", require("dap").step_into }) --	step into
nnoremap({ "<leader>do", require("dap").step_out }) --	step out of current function scope
nnoremap({ "<leader>du", require("dap").up }) --	step out of current function scope
nnoremap({ "<leader>dd", require("dap").down }) --	step out of current function scope

nnoremap({ "<leader>tB", vim.custom.toggleBackground })
nnoremap({ "cu", ":UndotreeToggle<CR>" })
nnoremap({ "gl", ":EasyAlign<CR>" })
vnoremap({ "gl", ":EasyAlign<CR>" })

nnoremap({ "<leader>ng", require("neogen").generate })

return M
