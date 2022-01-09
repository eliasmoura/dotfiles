local ok, dap = pcall(require, "dap")
if not ok then
  return
end
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- adjust as needed
  name = "lldb",
}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

    runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.configurations.zig = dap.configurations.cpp

require("dapui").setup({
  icons = { expanded = "-", collapsed = "+" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "<c-]>",
    remove = "d",
    edit = "<c-i>",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.60, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.20 },
      -- { id = "stacks", size = 0.25 },
      { id = "watches", size = 0.15 },
    },
    size = 50,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

function _G.dap_prompt_expr_close_win(bufnr, winid)
  vim.api.nvim_win_close(winid, false)
  local txt = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  -- Removing 4 bytes because there are(lua indexing start at 1)
  -- - 3 bytes for the unicode `➤`
  -- - 1 byte for the space so that the cursor don't stay on top of the unicode character
  txt = string.sub(txt[1], 5, -1)
  if #txt > 0 then
    vim.notify(string.format("set breakpoint: %s\n", txt))
    require("dap").set_breakpoint(txt)
  end
  vim.api.nvim_buf_delete(bufnr, { force = true })
end

function _G.dap_prompt_expr()
  local ft = vim.bo.filetype
  local bufnr = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_option(bufnr, "filetype", ft)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  vim.api.nvim_buf_set_option(bufnr, "buftype", "prompt")
  vim.fn.prompt_setprompt(bufnr, "➤ ")
  local opts = {
    width = 40,
    height = 1,
    relative = "cursor",
    row = 1,
    col = 0,
    style = "minimal",
    border = "double",
  }
  winid = vim.api.nvim_open_win(bufnr, true, opts)

  local fcall = string.format(
    "v:lua.dap_prompt_expr_close_win(%d,%d)",
    bufnr,
    winid
  )

  vim.cmd([[startinser!]])
  vim.api.nvim_command(
    string.format(
      "autocmd QuitPre <buffer> ++nested ++once :silent call %s<cr>",
      fcall
    )
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<esc>",
    "<esc><cmd>call " .. fcall .. "<cr>",
    {}
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "q",
    "<esc><cmdcall " .. fcall .. "<cr>",
    {}
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "i",
    "<cr>",
    "<esc><cmd>call " .. fcall .. "<cr>",
    {}
  )
end

local my_continue = function()
  local widgets = require("dap.ui.widgets")
  local my_widgets = widgets.sidebar(widgets.expression)
  my_widgets.open()
  my_widgets = widgets.builder(widgets.expression)
  dap.continue()
end
dap.my_continue = my_continue
vim.custom.dap = vim.custom.dap or {}
local cdap = vim.custom.dap
cdap.open = false
vim.custom.dap.is_map = false
cdap.cm = {
  s = "require('dap').step_over",
  S = "require('dap').step_into",
  ["<c-s>"] = "require('dap').step_out",
  ["<c-c>"] = "require('dap').close",
  ["<m-b>"] = "require('dap').set_breakpoint()",
}
local opts = { noremap = true, silent = true }

vim.custom.dap.default_keymap = function()
  local dm = vim.api.nvim_get_keymap("n") -- other mappins are sourced
  local cm = vim.custom.dap.cm
  for k, vc in pairs(cm) do
    for i in ipairs(dm) do
      if k == dm[i].lhs then
        cdap.dm[k] = dm[i]
        vim.api.nvim_set_keymap("n", k, "<cmd>lua " .. vc .. "()<cr>", opts)
      end
    end
  end
end
vim.custom.dap.dapui_toggle = function()
  if not cdap.open then
    vim.custom.dap.set_cmaps()
    cdap.open = true
    require("dapui").open()
  else
    vim.custom.dap.set_dmaps()
    cdap.open = false
    require("dapui").close()
  end
end
vim.custom.dap.set_cmaps = function()
  vim.custom.dap.is_map = true
  for k, v in pairs(cdap.cm) do
    vim.api.nvim_set_keymap("n", k, "<cmd>lua " .. v .. "()<cr>", opts)
  end
end
vim.custom.dap.set_dmaps = function()
  if vim.custom.dap.dm == nil then -- It seams that this file is sorced before the
    local dm = vim.api.nvim_get_keymap("n") -- other mappins are sourced
    cdap.dm = {}
    for k, _ in pairs(dm) do
      cdap.dm[k] = { rhs = k }
    end
  end
  vim.custom.dap.is_map = false
  for k, v in pairs(cdap.dm) do
    local cmd = ""
    if not v then
      cmd = k
    else
      cmd = v.rhs
    end
    vim.api.nvim_set_keymap("n", "" .. k .. "", "" .. cmd .. "", opts)
  end
end
vim.api.nvim_set_keymap(
  "n",
  "<leader>dt",
  "<cmd>lua vim.custom.dap.dapui_toggle()<cr>",
  { noremap = true, silent = true }
)

return dap
