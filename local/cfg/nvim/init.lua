pcall(require, "impatient")
local data = vim.fn.stdpath("data")
local backup = data .. "/backup/"
local fn = vim.fn
vim.custom = {}
if not vim.fn.isdirectory(backup) then
  vim.fn.mkdir(backup, "p")
end
vim.g.data = data

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
require("custom")
vim.cmd([[runtime autoload/auto_stuff.vim]])

if ok then
  require("custom.plugins")
end
