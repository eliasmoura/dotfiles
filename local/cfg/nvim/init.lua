pcall(require, "impatient")
vim.g.data = vim.fn.stdpath("data")
local packer_ok = true
local install_path = string.format(
  "%s/site/pack/packer/start/packer.nvim",
  vim.g.data
)
vim.custom = {}

--if vim.fn.empty(vim.fn.glob(install_path)) == 0 then
local fd = io.open(install_path)
if fd then
  return require("custom").setup({ plugmgr = packer_ok })
end

-- Bootstrap packer
local backup = vim.g.data .. "/backup/"
if not vim.fn.isdirectory(backup) then
  vim.fn.mkdir(backup, "p")
end

local err = ""
packer_ok, err = pcall(vim.fn.system, {
  "git",
  "clone",
  "--depth",
  "1",
  "https://github.com/wbthomason/packer.nvim",
  install_path,
})
vim.notify(err)
vim.cmd("packadd packer.nvim")
