local should_reload = true
local reloader = function()
  if should_reload then
    require("plenary.reload").reload_module("plenary")
    require("plenary.reload").reload_module("popup")
    require("plenary.reload").reload_module("telescope")
  end
end

reloader()

local actions = require("telescope.actions")
-- local sorters = require'telescope.sorters'
local themes = require("telescope.themes")

require("telescope").setup({
  defaults = {
    prompt_prefix = "> ",
    scroll_strategy = "cycle",
    mappings = {
      i = { ["<c-q>"] = actions.send_to_qflist + actions.open_qflist },
      n = { ["<c-q>"] = actions.send_to_qflist + actions.open_qflist },
    },
    extensions = {
      fzf = {
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("notify")

local no_preview = themes.get_dropdown({
  winblend = 20,
  prompt_title = " ",
  result_title = "",
  layout_config = { width = 80 },
  previewer = false,
})

local M = {}

function M.edit_cfg()
  local opt = vim.deepcopy(no_preview)
  opt.cwd = vim.env["XDG_CONFIG_HOME"]
  opt.prompt_title = "CFG Files>"
  require("telescope.builtin").find_files(opt)
end
function M.edit_zsh()
  local opt = vim.deepcopy(no_preview)
  opt.cwd = vim.env["XDG_CONFIG_HOME"] .. "/zsh"
  opt.prompt_title = "ZSH CFG Files>"
  require("telescope.builtin").find_files(opt)
end

function M.edit_nvim()
  local opt = vim.deepcopy(no_preview)
  opt.search_dirs = { vim.fn.stdpath("config") }
  opt.prompt_title = "NVIM CFG Files>"
  require("telescope.builtin").find_files(opt)
end

function M.navigate()
  local opt = vim.deepcopy(no_preview)
  opt.prompt_title = "Nanvigating"
  opt.hidden = true
  require("telescope.builtin").file_browser(opt)
end

function M.buffers()
  local opt = vim.deepcopy(no_preview)
  opt.prompt_title = " B U F F E R S "
  require("telescope.builtin").buffers(opt)
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
