local cfg = vim.fn.stdpath('config')
local data = vim.fn.stdpath('data')
local cache = vim.fn.stdpath('cache')
local backup = data .. '/backup/'
vim.custom = {}
if not vim.fn.isdirectory(backup) then
	  vim.fn.mkdir(backup, 'p')
  end
vim.g.cfg = cfg
vim.g.data = data
vim.g.cache = cache

require('custom.sets')
require('custom.plugins')

vim.custom.toggleBackground = function()
  if vim.o.background == "light" then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
  end
end

-- NOTE(kotto): Kinda defer the loading of the mappings so it doens't take 400s to load
vim.schedule(function ()
  vim.custom.mappings = require('custom.mappings')
  vim.keymap.nnoremap{'<silent> <leader>'     , ':<c-u>WhichKey <\\Space><CR>'}
  vim.keymap.nnoremap{'<silent> <localleader>',  ':<c-u>WhichKey  ,<CR>'}
  require('custom.lsp')
end)

vim.cmd[[autocmd BufEnter * :LspStart]]
vim.cmd [[runtime autoload/auto_stuff.vim]]
vim.g.tokyonight_style = 'night'
vim.cmd [[colorscheme tokyonight]]

vim.g.vimspector_enable_mappings = 'HUMAN'

vim.g.tar_cmd = 'bsdtar'
vim.g.tar_secure = 1

-- Tell vim about the additional file extensions we can now use.
vim.cmd [[autocmd BufReadCmd *.iso,*.rar,*.7z call tar#Browse(expand("<tch>"))]]

