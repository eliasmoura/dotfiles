
require'packer'.startup({function()
  use{'https://github.com/wbthomason/packer.nvim'}
  use{ 'https://github.com/lambdalisue/suda.vim', config = 'vim.g.suda_smart_edit = 1' }
  use{'https://github.com/tweekmonster/startuptime.vim'}
  use{'https://github.com/tjdevries/astronauta.nvim'}-- for vim.keymap.nnoremap…
  use{'https://github.com/nvim-lua/plenary.nvim'}-- " lua functions used by others plugins
  use{'https://github.com/nvim-lua/popup.nvim'}--   " popup menu used by telescope

  use{'https://github.com/vim-pandoc/vim-pandoc', ft = 'markdown'}
  use { 'https://github.com/beyondmarc/glsl.vim.git',    ft = 'gls'}
  -- " Makes vim/nvim slow when there are list blocks in the view
  use { 'https://github.com/chrisbra/NrrwRgn.git', ft = { 'adoc', 'asciidoc' }}
  use { 'https://github.com/inkarkat/vim-SyntaxRange', ft = { 'adoc', 'asciidoc' , 'html', 'vim' }}
  -- " Plug 'https://github.com/dahu/vim-asciidoc',          'ft': [ 'adoc', 'asciidoc' ]
  -- " Plug 'https://github.com/vim-scripts/rfc-syntax',     'ft': [ 'rfc' , 'txt'      ]
  use{'https://github.com/plasticboy/vim-markdown', ft = { 'markdown' }}
  use{'https://github.com/mhinz/vim-rfc', cmd = {'RFC'}}
  -- " Plug 'https://github.com/tpope/vim-rhubarb' "consider this ft github things
  use{'https://github.com/tpope/vim-surround'}
  use{'https://github.com/tpope/vim-repeat.git'}
  use{'https://github.com/tpope/vim-fugitive.git'}--    "Git integration
  use{'https://github.com/junegunn/gv.vim', opt = true}
  use{'https://github.com/tpope/vim-commentary.git', opt = true}
  use{'https://github.com/tommcdo/vim-exchange.git', opt = true}
  use{'https://github.com/vim-utils/vim-man', cmd = {'Man'}}
  use{'https://github.com/hoob3rt/lualine.nvim'}
  use{'https://github.com/mbbill/undotree', cmd = {'UndotreeToggle'}}
  use{'https://github.com/junegunn/vim-easy-align', cmd = {'EasyAlign'}}
  -- " Plug 'https://github.com/groenewege/vim-less'
  -- "Plug 'https://github.com/hsanson/vim-android'

  use{'https://github.com/nvim-telescope/telescope.nvim'}

  use{'https://github.com/neovim/nvim-lspconfig'}
  use{'https://github.com/nvim-lua/lsp-status.nvim'}
  use{'https://github.com/bfredl/nvim-luadev', opt = true}
  use{'nvim-telescope/telescope-symbols.nvim', opt = true}
  use{'https://github.com/nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use{'https://github.com/nvim-lua/completion-nvim'}
  use{'https://github.com/hrsh7th/nvim-compe', opt = true}

  use{'https://github.com/folke/tokyonight.nvim'}
  use{'https://github.com/morhetz/gruvbox', opt = true}
  use{'https://github.com/nvim-treesitter/nvim-treesitter', run = 'vim.cmd("TSUpdate")'}
  use{'https://github.com/lewis6991/gitsigns.nvim', config = function() require'gitsigns'.setup() end }
  -- TODO(kotto): figure out if I really want these
  use{'https://github.com/puremourning/vimspector', cmd = { 'VimspectorLaunch' },
  	config = function() vim.g.vimspector_enable_mappings = 'HUMAN' end}
  use{'https://github.com/AckslD/nvim-whichkey-setup.lua',
  requires = {'https://github.com/liuchengxu/vim-which-key'}, }
  use{'https://github.com/steelsojka/pears.nvim'}
end,
config = { profile = {enable = true}}})
