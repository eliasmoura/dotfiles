pcall(require, "impatient")
vim.g.data = vim.fn.stdpath("data")
local packer_ok = true
local install_path =
  string.format("%s/site/pack/packer/start/packer.nvim", vim.g.data)
vim.custom = {}

--if vim.fn.empty(vim.fn.glob(install_path)) == 0 then
local fd = io.open(install_path)
if fd then
  require("custom").setup({ plugmgr = packer_ok, bootstrap = false})
  return --require("custom").setup({ plugmgr = packer_ok })
end

-- Bootstrap packer
vim.notify("[packer] not found. Initiating bootstrap.", vim.log.levels.WARN)
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
if not packer_ok then
vim.notify("Failed to donload packer. stopping bootstrap.\n"..err, vim.log.levels.ERROR)
return
end
vim.notify("Finished downloading packer. Starting plugins setup.", vim.log.levels.INFO)
vim.cmd("packadd packer.nvim")
require("custom").setup({ plugmgr = packer_ok , bootstrap = true})
