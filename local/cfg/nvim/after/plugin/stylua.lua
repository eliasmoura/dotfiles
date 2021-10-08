-- taken from https://github.com/tjdevries/config_manager/blob/3e4a30866dfe3342dc1089afb010ef9a0cc30923/xdg_config/nvim/after/plugin/stylua.lua
-- Used to run stylua automatically if in a lua file
-- and the file "stylua.toml" exists in the base root of the repo.
--
-- Otherwise doesn't do anything.

if vim.fn.executable "stylua" == 0 then
  return
end

vim.cmd [[
  augroup StyluaAuto
    autocmd BufWritePre *.lua :lua require("custom.stylua").format()
  augroup END
]]
