require("packer").startup({
  function()
    use({ "https://github.com/lewis6991/impatient.nvim" })
    use({ "https://github.com/wbthomason/packer.nvim" })

    use({ "https://github.com/lambdalisue/suda.vim" })
    -- config = 'vim.g.suda_smart_edit = 1' }
    use({
      "https://github.com/tweekmonster/startuptime.vim",
      cmd = "StartupTime",
    })
    -- use({ "https://github.com/tjdevries/astronauta.nvim" }) -- for vim.keymap.nnoremap…
    use({ "https://github.com/nvim-lua/plenary.nvim" }) -- ' lua functions used by others plugins

    use({ "https://github.com/vim-pandoc/vim-pandoc", ft = "markdown" })
    use({ "https://github.com/beyondmarc/glsl.vim.git", ft = "gls" })
    -- ' Makes vim/nvim slow when there are list blocks in the view
    use({
      "https://github.com/chrisbra/NrrwRgn.git",
      ft = { "adoc", "asciidoc" },
    })
    use({
      "https://github.com/inkarkat/vim-SyntaxRange",
      ft = { "adoc", "asciidoc", "html", "vim" },
    })
    -- ' Plug 'https://github.com/dahu/vim-asciidoc',          'ft': [ 'adoc', 'asciidoc' ]
    -- ' Plug 'https://github.com/vim-scripts/rfc-syntax',     'ft': [ 'rfc' , 'txt'      ]
    use({ "https://github.com/plasticboy/vim-markdown", ft = { "markdown" } })
    use({ "https://github.com/mhinz/vim-rfc", cmd = { "RFC" } })
    -- ' Plug 'https://github.com/tpope/vim-rhubarb' 'consider this ft github things
    use({ "https://github.com/tpope/vim-surround" })
    use({ "https://github.com/tpope/vim-repeat.git" })
    use({ "https://github.com/tpope/vim-fugitive.git", disable = true }) --    'Git integration
    use({
      "tpope/vim-scriptease",
      cmd = {
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
        "Time", -- measure how long it takes to run some stuff.
      },
    })
    use({ "https://github.com/junegunn/gv.vim", cmd = { "GV" } })
    use({
      "https://github.com/tpope/vim-commentary.git",
      requires = {
        {
          "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
          config = function()
            require("nvim-treesitter.configs").setup({
              context_commentstring = { enable = true },
            })
          end,
        },
      },
    })
    use({ "https://github.com/tommcdo/vim-exchange.git" })
    use({ "https://github.com/vim-utils/vim-man", cmd = { "Man" } })
    use({
      "https://github.com/hoob3rt/lualine.nvim",
      requires = { "https://github.com/kyazdani42/nvim-web-devicons" },
      config = function()
        require("custom.lualine")
      end,
    })
    use({ "https://github.com/mbbill/undotree", cmd = { "UndotreeToggle" } })
    use({
      "https://github.com/junegunn/vim-easy-align",
      cmd = { "EasyAlign" },
    })
    -- ' Plug 'https://github.com/groenewege/vim-less'
    -- 'Plug 'https://github.com/hsanson/vim-android'

    use({ "https://github.com/kyazdani42/nvim-web-devicons" })
    use({
      "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    })
    use({ "nvim-telescope/telescope-symbols.nvim", opt = true })
    use({
      "https://github.com/nvim-telescope/telescope.nvim",
      requires = {
        "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
      },
    })

    use({
      "https://github.com/neovim/nvim-lspconfig",
      config = function()
        require("custom.lsp")
      end,
    })
    use({ "https://github.com/nvim-lua/lsp-status.nvim" })
    use({
      "https://github.com/tami5/lspsaga.nvim",
    })
    use({
      "https://github.com/bash-lsp/bash-language-server",
      ft = "sh",
      config = function()
        require("lspconfig").bashls.setup({})
      end,
    })
    use({
      "https://github.com/folke/trouble.nvim",
      config = function()
        require("trouble").setup()
      end,
    })
    use({ "https://github.com/bfredl/nvim-luadev", opt = true })
    use({ "https://github.com/nvim-lua/completion-nvim", disable = true })
    use({
      "https://github.com/hrsh7th/nvim-cmp",
      config = function()
        require("custom.cmp")
      end,
    })
    use({ "https://github.com/hrsh7th/cmp-buffer" })
    use({ "https://github.com/hrsh7th/cmp-path" })
    use({ "https://github.com/hrsh7th/cmp-nvim-lua" })
    use({ "https://github.com/hrsh7th/cmp-nvim-lsp" })
    use({ "https://github.com/saadparwaiz1/cmp_luasnip" })
    use({
      "https://github.com/L3MON4D3/LuaSnip",
      config = function()
        require("custom.snippets")
      end,
    })
    -- use{'https://github.com/hrsh7th/nvim-compe', opt = true}
    -- use{ 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/vim-vsnip', 'hrsh7th/cmp-buffer', }}

    use({
      "https://github.com/folke/tokyonight.nvim",
      setup = function()
        vim.g.tokyonight_style = "night"
      end,
      config = function()
        vim.cmd([[colorscheme tokyonight]])
      end,
    })
    use({ "https://github.com/morhetz/gruvbox", opt = true })

    use({
      "https://github.com/nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("custom.treesitter")
      end,
    })
    use({
      "https://github.com/nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
      config = function()
        require("nvim-treesitter.configs").setup({
          playground = { enable = true },
        })
      end,
    })

    use({
      "https://github.com/lewis6991/gitsigns.nvim",
      requires = { "https://github.com/nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup()
      end,
    })
    -- TODO(kotto): figure out if I really want these
    use({
      "https://github.com/puremourning/vimspector",
      ft = { "c", "c++" },
      disable = true,
    }) --, cmd = { 'call vimspector#Launch()' } }
    use({
      "https://github.com/mfussenegger/nvim-dap",
      config = function()
        require("custom.nvim-dap")
      end,
    })
    use({
      "https://github.com/rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    })
    -- use{'https://github.com/theHamsta/nvim-dap-virtual-text'}
    use({ "https://github.com/mfussenegger/nvim-dap-python" })
    use({
      "https://github.com/leoluz/nvim-dap-go",
      config = function()
        require("dap-go").setup()
      end,
    })
    use({ "https://github.com/nvim-telescope/telescope-dap.nvim" })
    use({ "https://github.com/vim-test/vim-test" })
    use({
      "https://github.com/rcarriga/vim-ultest",
      require = "https://github.com/vim-test/vim-test",
      run = ":UpdateRemotePlugins",
    })
    use({
      "https://github.com/AckslD/nvim-whichkey-setup.lua",
      disable = true,
      requires = { "https://github.com/liuchengxu/vim-which-key" },
      config = function()
        require("whichkey_setup").config()
      end,
    })
    use({
      "https://github.com/j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end,
  })
    -- use{'https://github.com/steelsojka/pears.nvim'}
    use({
      "https://github.com/nvim-neorg/neorg",
      ft = "norg",
      config = function()
        require("custom.neorg")
      end,
      after = "nvim-treesitter",
      requires = {
        "https://github.com/nvim-neorg/neorg-telescope",
        "https://github.com/nvim-neorg/tree-sitter-norg",
      },
    })
    use({
      "https://github.com/TimUntersberger/neogit",
      cmd = "Neogit",
      requires = {
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/sindrets/diffview.nvim",
      },
      config = function()
        require("neogit").setup({ integrations = { diffview = true } })
      end,
    })
    use({
      "https://github.com/sindrets/diffview.nvim",
      cmd = "DiffviewOpen",
      config = function()
        require("diffview").setup({ file_panel = { listing_style = "list" } })
      end,
    })

    use({
      "https://github.com/danymat/neogen",
      config = function()
        require("neogen").setup({ enabled = true })
      end,
      requires = "https://github.com/nvim-treesitter/nvim-treesitter",
    })

    -- use{'https://github.com/aquach/vim-http-client',
    --     cmd = 'HTTPClientDoRequest',
    --     setup = [[set g:http_client_bind_hotkey = 0]]}
    use({
      "https://github.com/pwntester/octo.nvim",
      config = function()
        require("octo").setup()
      end,
    })

    use({ "https://github.com/ledger/vim-ledger" })
    use({ "https://github.com/felipec/notmuch-vim", disable = true })
    use({
      "https://github.com/rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
        vim.notify.setup({ stages = "fade_in_slide_out", timeout = 5000 })
      end,
    })
  end,
  config = { profile = { enable = true } },
})
