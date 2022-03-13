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
local packer_ok = true
local install_path = string.format(
  "%s/site/pack/packer/start/packer.nvim",
  data
)

if fn.empty(fn.glob(install_path)) > 0 then
  local err = ""
  packer_ok, err = pcall(fn.system, {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.notify(err)
  vim.cmd("packadd packer.nvim")
end

require("custom").setup({ plugmgr = packer_ok })
