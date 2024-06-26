local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{import = "plugins"}})

-- require("lazy").setup({
--   {
--     'rose-pine/neovim',
--     as = 'rose-pine',
--     config = function()
--       vim.cmd('colorscheme rose-pine')
--     end
--   },
--   {
--     'nvim-treesitter/nvim-treesitter',
--     build = ':TSUpdate',
--   },
--   'nvim-treesitter/playground',
--   {
--     'stevearc/oil.nvim',
--     opts = {},
--     -- Optional dependencies
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     config = function()
--       require("oil").setup()
--     end
--   },
--   'mbbill/undotree',
--   'nvim-tree/nvim-tree.lua',
--   'tpope/vim-fugitive',
--   'tpope/vim-surround',
--   'tpope/vim-projectionist',
--   'tpope/vim-repeat',
--   'tpope/vim-commentary',
--   'jiangmiao/auto-pairs',
--   'justinmk/vim-sneak',
--   {
--     'lewis6991/gitsigns.nvim',
--     config = function()
--       require('gitsigns').setup()
--     end
--   },
--   'machakann/vim-highlightedyank',
--   'editorconfig/editorconfig-vim',
--   'Asheq/close-buffers.vim',
--   {
--     'nvim-lualine/lualine.nvim',
--     dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
--   },
--   {
--     'VonHeikemen/lsp-zero.nvim',
--     branch = 'v3.x',
--     dependencies = {
--       --- Uncomment these if you want to manage LSP servers from neovim
--       { 'williamboman/mason.nvim' },
--       { 'williamboman/mason-lspconfig.nvim' },

--       -- LSP Support
--       { 'neovim/nvim-lspconfig' },
--       -- Autocompletion
--       { 'hrsh7th/nvim-cmp' },
--       { 'hrsh7th/cmp-nvim-lsp' },
--       { 'L3MON4D3/LuaSnip' },
--     }
--   },
--   {
--     'prettier/vim-prettier',
--     -- run = 'npm install',
--     -- ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'graphql', 'markdown', 'vue', 'html'}
--   },
--   'mogelbrod/vim-jsonpath',

--   -- Harpoon 2

--   -- use "nvim-lua/plenary.nvim"
--   -- use {
--   --   "ThePrimeagen/harpoon",
--   --   branch = "harpoon2",
--   --   dependencies = { { "nvim-lua/plenary.nvim" } }
--   -- }


--   'lvimuser/lsp-inlayhints.nvim',

-- })
