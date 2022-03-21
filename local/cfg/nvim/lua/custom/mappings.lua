local M = {}
-- local xnoremap = vim.keymap.xnoremap
vim.custom = vim.custom or {}

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<cr>", "<nop>")
vim.keymap.set("n", "<c-n>", "<nop>")
vim.keymap.set("n", "<c-p>", "<nop>")
vim.keymap.set("n", "Q", "gq")
vim.keymap.set("n", "<leader>rt", [[<cmd>%s/\s\+$//g<cr>let @/=''<cr>]])
vim.keymap.set("n", "<cr>", vim.custom.nohl)
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<cr><cmd>echo<cr>") -- teh second cmd is to remove the search from the echo area
vim.keymap.set("n", "<leader><tab>", "<cmd>retab!<cr>")

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
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")
-- vim.keymap.set('n', "<leader>gg", neogit.status )
-- vim.keymap.set('n', "<leader>gG", ":Git! " )
-- vim.keymap.set('n', "<leader>gs", require("neogit").cr>" )
vim.keymap.set("n", "<leader>gc", neogit.commit)
vim.keymap.set("n", "<leader>gm", neogit.merge)
vim.keymap.set("n", "<leader>gl", neogit.log)

-- Lsp
-- For the Lsp mappings see lua/custom/lsp.lua
vim.keymap.set("n", "<c-n>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<c-p>", vim.diagnostic.goto_prev)

-- NOTE(elias): It seems like diagnostic.show_line_diagnostics is buggy now
-- vim.keymap.set('n', "<c-s>", vim.diagnostic.show_line_diagnostics )

vim.keymap.set("n", "<m-m>", "<cmd>make<cr>")
vim.keymap.set("n", "<m-s-m>", ":make ")
vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<c-s-a>", "<c-^>")

vim.keymap.set("n", "<M-c>", "<cmd>lclose<cr>")
vim.keymap.set("n", "<M-o>", "<cmd>lopen<cr>")
vim.keymap.set("n", "<m-n>", "<cmd>lnext<cr>")
vim.keymap.set("n", "<m-p>", "<cmd>lprev<cr>")
vim.keymap.set("n", "<m-s-c>", "<cmd>cclose<cr>")
vim.keymap.set("n", "<m-s-o>", "<cmd>copen<cr>")
vim.keymap.set("n", "<m-s-n>", "<cmd>cnext<cr>")
vim.keymap.set("n", "<m-s-p>", "<cmd>cprev<cr>")

--Telescope
local tl = require("custom.telescope")
vim.keymap.set("n", "<leader>tt", tl.builtin)
vim.keymap.set("n", "<leader>ti", tl.edit_nvim)
vim.keymap.set("n", "<leader>tcf", tl.edit_cfg)
vim.keymap.set("n", "<leader>tg", tl.live_grep)
vim.keymap.set("n", "<leader>tb", tl.buffers)
vim.keymap.set("n", "<leader>tf", tl.navigate)
vim.keymap.set("n", "<leader>tm", tl.man_pages)
vim.keymap.set("n", "<leader>tcs", tl.colorscheme)
vim.keymap.set("n", "<leader>tq", tl.quickfix)
vim.keymap.set("n", "<leader>tl", tl.loclist)
vim.keymap.set("n", "<leader>tss", tl.spell_suggest)
vim.keymap.set("n", "<leader>th", tl.help_tags)
vim.keymap.set("n", "<leader><space>", tl.find_files)
vim.keymap.set("n", "<leader>rr", tl.reloader)

vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<leader>dC", require("dap").continue) -- when debugging, continue. otherwise start debugging.
vim.keymap.set("n", "<leader>dc", require("dap").run_to_cursor) -- when debugging, continue. otherwise start debugging.
vim.keymap.set("n", "<leader>d<space>", require("dap").stop) -- stop debugging.
vim.keymap.set("n", "<leader>dr", require("dap").run) -- restart debugging with the same configuration.
vim.keymap.set("n", "<leader>dR", require("dap").restart) -- restart debugging with the same configuration.
vim.keymap.set("n", "<leader>dP", require("dap").pause) -- pause debuggee.
vim.keymap.set("n", "<leader>d<space>", require("dap").run_to_cursor) -- run to cursor
vim.keymap.set("n", "<leader>ds", require("dap").step_over) -- step over
vim.keymap.set("n", "<leader>dS", require("dap").step_into) -- step into
vim.keymap.set("n", "<F5>", require("dap").step_into) -- step into
vim.keymap.set("n", "<leader>do", require("dap").step_out) -- step out of current function scope
vim.keymap.set("n", "<leader>du", require("dap").up) -- step out of current function scope
vim.keymap.set("n", "<leader>dd", require("dap").down) -- step out of current function scope
vim.keymap.set("n", "<leader>td", require("dap-go").debug_test)
vim.keymap.set("n", "<leader>dj", "<cmd>call v:lua.dap_prompt_expr()<cr>")

vim.keymap.set("n", "<leader>tB", vim.custom.toggleBackground)
vim.keymap.set("n", "cu", ":UndotreeToggle<cr>")
vim.keymap.set("n", "gl", ":EasyAlign<cr>")
vim.keymap.set("v", "gl", ":EasyAlign<cr>")

vim.keymap.set("n", "<leader>ng", require("neogen").generate)

return M
