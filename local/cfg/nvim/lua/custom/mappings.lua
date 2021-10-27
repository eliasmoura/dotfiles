local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap
local vnoremap = vim.keymap.vnoremap
local tnoremap = vim.keymap.tnoremap
local map = vim.keymap.map
local M = {}
-- local xnoremap = vim.keymap.xnoremap

vim.g.mapleader = " "
vim.g.maplocalleader = ","

nnoremap({ "<space>", "<nop>" })
nnoremap({ "<cr>", "<nop>" })
map({ "Q", "gq" })
nnoremap({ "<leader>rt", [[<cmd>%s/\s\+$//g<cr>let @/=''<cr>]] })
nnoremap({ "<cr>", vim.custom.nohl })
nnoremap({ "<leader>/", "<cmd>nohlsearch<CR><cmd>echo<cr>" }) -- teh second cmd is to remove the search from the echo area
nnoremap({ "<leader><Tab>", "<cmd>retab!<CR>" })

-- Git
local neogit = {}
function neogit.commit()
  require("neogit").open({ "commit" })
end
function neogit.merge()
  require("neogit").open({ "merge" })
end
function neogit.log()
  require("neogit").open({ "log" })
end
function neogit.status()
  require("neogit").open({ kind = "split" })
end
nnoremap({ "<leader>gg", "<cmd>Neogit<cr>" })
-- nnoremap({ "<leader>gg", neogit.status })
-- nnoremap({ "<leader>gG", ":Git! " })
-- nnoremap({ "<leader>gs", require("neogit").cr>" })
nnoremap({ "<leader>gc", neogit.commit })
nnoremap({ "<leader>gm", neogit.merge })
nnoremap({ "<leader>gl", neogit.log })

-- Lsp
-- For the Lsp mappings see lua/custom/lsp.lua
nnoremap({ "<c-n>", vim.diagnostic.goto_next })
nnoremap({ "<c-p>", vim.diagnostic.goto_prev })

-- NOTE(elias): It seems like diagnostic.show_line_diagnostics is buggy now
-- vim.diagnostic.show_line_diagnostics = function()
--   local namespaces = vim.api.nvim_get_namespaces()
--   -- P(namespaces)
--   local l_num = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1]
--   local diagnostics = vim.diagnostic.get(0, { lnum = l_num })

--   vim.diagnostic.show(namespaces["vim.lsp.client-1"], 0, diagnostics, nil)
-- end
-- nnoremap({ "<c-s>", vim.diagnostic.show_line_diagnostics })

nnoremap({ "<m-m>", "<cmd>make clean all<CR>" })
nnoremap({ "<m-s-m>", ":make " })
tnoremap({ "<Esc>", "<C-\\><C-n>" })
nnoremap({ "<Esc>", "<C-\\><C-n>" })
nnoremap({ "<C-S-a>", "<C-^>" })

nnoremap({ "<M-c>", "<cmd>lclose<cr>" })
nnoremap({ "<M-o>", "<cmd>lopen<cr>" })
nnoremap({ "<m-n>", "<cmd>lnext<cr>" })
nnoremap({ "<m-p>", "<cmd>lprev<cr>" })
nnoremap({ "<m-s-c>", "<cmd>cclose<cr>" })
nnoremap({ "<m-s-o>", "<cmd>copen<cr>" })
nnoremap({ "<m-s-n>", "<cmd>cnext<cr>" })
nnoremap({ "<m-s-p>", "<cmd>cprev<cr>" })

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

nnoremap({ "<leader>db", require("dap").toggle_breakpoint })
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
nnoremap({ "<leader>td", require("dap-go").debug_test })
nnoremap({ "<leader>dj", "<cmd>call v:lua.dap_prompt_expr()<cr>" })

nnoremap({ "<leader>tB", vim.custom.toggleBackground })
nnoremap({ "cu", ":UndotreeToggle<CR>" })
nnoremap({ "gl", ":EasyAlign<CR>" })
vnoremap({ "gl", ":EasyAlign<CR>" })

nnoremap({ "<leader>ng", require("neogen").generate })

return M
