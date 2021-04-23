local cfg = vim.fn.stdpath('config')
local data = vim.fn.stdpath('data')
local cache = vim.fn.stdpath('cache')
local backup = data .. '/backup/'
if not vim.fn.isdirectory(backup) then
	  vim.fn.mkdir(backup, 'p')
  end
vim.g.cfg = cfg
vim.g.data = data
vim.g.cache = cache

require('plenary.reload').reload_module('custom.mappings')

require('plenary.reload').reload_module('custom.lsp')
require('plenary.reload').reload_module('custom.mappings')
require('plenary.reload').reload_module('custom.plugins')
require('plenary.reload').reload_module('custom.sets')
require('plenary.reload').reload_module('custom.telescope')

require('custom.sets')
require('custom.plugins')
-- diffopt=internal,filler,closeoff,vertical,foldcolumn:0,algorithm:patience`

vim.cmd [[runtime plugin/astronauta.vim]]
vim.cmd [[runtime autoload/auto_stuff.vim]]
vim.cmd [[colorscheme tokyonight]]

vim.g.tokyonight_style = 'night'
require'lualine'.setup{ options = {theme = 'tokyonight'} }

require('custom.lsp')

vim.keymap.nnoremap{'<silent> <leader>'     , ':<c-u>WhichKey <\\Space><CR>'}
vim.keymap.nnoremap{'<silent> <localleader>',  ':<c-u>WhichKey  ,<CR>'}


-- Trying to decide whether to use nvim-compe or completion-nvim
-- Use completion-nvim in every buffer
vim.cmd [[autocmd BufEnter * lua require('completion').on_attach()]]
vim.g.tar_cmd = 'bsdtar'
vim.g.tar_secure = 1

-- " Tell vim about the additional file extensions we can now use.
vim.cmd [[autocmd BufReadCmd *.iso,*.rar,*.7z call tar#Browse(expand("<tch>"))]]

toggleBackground = function()
  if vim.o.background == "light" then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
  end
end

require('pears').setup()
-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'disable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = true;
--   source = {
--     path = true;
--     buffer = true;
--     calc = true;
--     nvim_lsp = true;
--     nvim_lua = true;
--     vsnip = true;
--   };
-- }

-- " Use bsdtar for all the additional formats it supports over GNU tar.
