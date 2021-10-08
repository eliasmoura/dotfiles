pcall(require, "impatient")
local cfg = vim.fn.stdpath("config")
local data = vim.fn.stdpath("data")
local cache = vim.fn.stdpath("cache")
local backup = data .. "/backup/"
local fn = vim.fn
vim.custom = {}
if not vim.fn.isdirectory(backup) then
  vim.fn.mkdir(backup, "p")
end
vim.g.cfg = cfg
vim.g.data = data
vim.g.cache = cache

-- Bootstrap packer
local ok = true
local install_path = string.format(
  "%s/site/pack/packer/start/packer.nvim",
  data
)
if fn.empty(fn.glob(install_path)) > 0 then
  local err = ""
  ok, err = pcall(fn.system, {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print(err)
  vim.cmd("packadd packer.nvim")
end

require("custom.sets")
require("custom.snippets")
require("custom")
vim.custom.toggleBackground = function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end
vim.cmd([[runtime autoload/auto_stuff.vim]])

if ok then
  require("custom.plugins")

  vim.cmd([[autocmd BufEnter * :LspStart]])
  vim.g.tokyonight_style = "night"
  vim.cmd([[colorscheme tokyonight]])

  -- NOTE(kotto): Kinda defer the loading of the mappings so it doens't take
  -- 400s to load. With the plugin https://github.com/lewis6991/impatient.nvim
  -- loading it normaly will take around 100s. Using `vim.schelude` it takes
  -- 50s

  -- vim.cmd [[runtime plugin/astronauta.vim]]
  vim.schedule(function()
    require("custom.mappings")
    vim.keymap.nnoremap({
      "<silent> <leader>",
      ":<c-u>WhichKey <\\Space><CR>",
    })
    vim.keymap.nnoremap({ "<silent> <localleader>", ":<c-u>WhichKey  ,<CR>" })
  end)

  require("custom.luasnip")
end

if vim.bo.filetype ~= "lua" then
  vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
end
