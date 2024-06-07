-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    -- or                            , branch = '0.1.x',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      { 'molecule-man/telescope-menufacture' },
      { 'natecraddock/telescope-zf-native.nvim' },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("menufacture")
      require("telescope").load_extension("zf-native")
    end
  }

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('mbbill/undotree')

  use('tpope/vim-fugitive')
  use('tpope/vim-surround')
  use('tpope/vim-projectionist')
  use('tpope/vim-repeat')
  use('tpope/vim-commentary')

  use('jiangmiao/auto-pairs')
  use('justinmk/vim-sneak')
  use('machakann/vim-highlightedyank')
  use('editorconfig/editorconfig-vim')
  use('Asheq/close-buffers.vim')
  use('preservim/nerdtree')
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }

  use {
    'prettier/vim-prettier',
    -- run = 'npm install',
    -- ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'graphql', 'markdown', 'vue', 'html'}
  }

  use('mogelbrod/vim-jsonpath')

  -- Harpoon 2

  -- use "nvim-lua/plenary.nvim"
  -- use {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   requires = { { "nvim-lua/plenary.nvim" } }
  -- }


  use('lvimuser/lsp-inlayhints.nvim')
end)
