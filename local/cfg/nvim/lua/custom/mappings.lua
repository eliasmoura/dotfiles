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
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")
-- vim.keymap.set('n', "<leader>gg", neogit.status )
-- vim.keymap.set('n', "<leader>gG", ":Git! " )
-- vim.keymap.set('n', "<leader>gs", require("neogit").cr>" )
vim.keymap.set("n", "<leader>gc", function()
  require("neogit").open({ "commit" })
end, { desc = "Neogit commit" })
vim.keymap.set("n", "<leader>gm", function()
  require("neogit").open({ "merge" })
end, { desc = "Neogit merge" })
vim.keymap.set("n", "<leader>gl", function()
  require("neogit").open({ "log" })
end, { desc = "Neogit log" })

-- Lsp
-- For the Lsp mappings see lua/custom/lsp.lua
vim.keymap.set(
  "n",
  "<c-n>",
  vim.diagnostic.goto_next,
  { desc = "Go to next lint error." }
)
vim.keymap.set(
  "n",
  "<c-p>",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous lint error." }
)

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
vim.keymap.set("n", "<leader>tt", tl.builtin, { desc = "Telescope builtin." })
vim.keymap.set(
  "n",
  "<leader>ti",
  tl.edit_nvim,
  { desc = "Telescope edit_nvim." }
)
vim.keymap.set(
  "n",
  "<leader>tcf",
  tl.edit_cfg,
  { desc = "Telescope edit_cfg." }
)
vim.keymap.set(
  "n",
  "<leader>tg",
  tl.live_grep,
  { desc = "Telescope live_grep." }
)
vim.keymap.set("n", "<leader>tb", tl.buffers, { desc = "Telescope buffers." })
vim.keymap.set("n", "<leader>tf", tl.navigate, { desc = "Telescope navigate." })
vim.keymap.set(
  "n",
  "<leader>tm",
  tl.man_pages,
  { desc = "Telescope man_pages." }
)
vim.keymap.set(
  "n",
  "<leader>tcs",
  tl.colorscheme,
  { desc = "Telescope colorscheme." }
)
vim.keymap.set("n", "<leader>tq", tl.quickfix, { desc = "Telescope quickfix." })
vim.keymap.set("n", "<leader>tl", tl.loclist, { desc = "Telescope loclist." })
vim.keymap.set(
  "n",
  "<leader>tss",
  tl.spell_suggest,
  { desc = "Telescope spell_suggest." }
)
vim.keymap.set(
  "n",
  "<leader>th",
  tl.help_tags,
  { desc = "Telescope help_tags." }
)
vim.keymap.set(
  "n",
  "<leader><space>",
  tl.find_files,
  { desc = "Telescope find_files." }
)
vim.keymap.set("n", "<leader>rr", tl.reloader, { desc = "Telescope reloader." })

vim.keymap.set("n", "<leader>db", function()
  return require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint." })
local set_bp = function()
  require("dap").set_breakpoint(vim.fn.input("Set breakpoint: "), nil, nil)
end
vim.keymap.set("n", "<leader>dB", set_bp, { desc = "Set breakpoint." })
vim.keymap.set("n", "<leader>dC", function()
  return require("dap").continue()
end, { desc = "when debugging, continue. otherwise start debugging." })
vim.keymap.set("n", "<leader>dc", function()
  return require("dap").run_to_cursor()
end, { desc = "dap: Run to cursor." }) -- when debugging, continue. otherwise start debugging.
vim.keymap.set("n", "<leader>d<space>", function()
  return require("dap").stop()
end, { desc = "dap: Stop Debugging." }) -- stop debugging.
vim.keymap.set("n", "<leader>dr", function()
  return require("dap").run()
end, { desc = "dap: Run." }) -- restart debugging with the same configuration.
vim.keymap.set("n", "<leader>dR", function()
  return require("dap").restart()
end, { desc = "dap: Restart." }) -- restart debugging with the same configuration.
vim.keymap.set("n", "<leader>dP", function()
  return require("dap").pause()
end, { desc = "dap: Pause." }) -- pause debuggee.
vim.keymap.set("n", "<leader>d<space>", function()
  return require("dap").run_to_cursor()
end, { desc = "dap: Run to cursor." }) -- run to cursor
vim.keymap.set("n", "<leader>ds", function()
  return require("dap").step_over()
end) -- step over
vim.keymap.set("n", "<leader>dS", function()
  return require("dap").step_into()
end) -- step into
vim.keymap.set("n", "<F5>", function()
  return require("dap").step_into()
end) -- step into
vim.keymap.set("n", "<leader>do", function()
  return require("dap").step_out()
end) -- step out of current function scope
vim.keymap.set("n", "<leader>du", function()
  return require("dap").up()
end) -- step out of current function scope
vim.keymap.set("n", "<leader>dd", function()
  return require("dap").down()
end) -- step out of current function scope
vim.keymap.set("n", "<leader>td", function()
  return require("dap-go").debug_test()
end, { desc = "Debug test" })
vim.keymap.set("n", "<leader>dj", "<cmd>call v:lua.dap_prompt_expr()<cr>")

vim.keymap.set(
  "n",
  "<leader>tB",
  vim.custom.toggleBackground,
  { desc = "Toggle dark/light colorscheme." }
)
vim.keymap.set("n", "cu", ":UndotreeToggle<cr>")
vim.keymap.set("n", "gl", ":EasyAlign<cr>")
vim.keymap.set("v", "gl", ":EasyAlign<cr>")

vim.keymap.set("n", "<leader>ng", function()
  return require("neogen").generate()
end, { desc = "neogen: Start docummenting the code." })

return M
