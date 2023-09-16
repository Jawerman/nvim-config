-- relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tabs
local tabSize = 2
vim.opt.tabstop = tabSize
vim.opt.softtabstop = tabSize
vim.opt.shiftwidth = tabSize
vim.opt.expandtab = true
vim.opt.smartindent = true

--better search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch  = true

-- Folding
vim.opt.foldmethod="expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldnestmax=10
vim.opt.foldlevel=2

-- remove swap using undo file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.opt.list = true

-- show hidden characters
vim.opt.listchars="nbsp:¬,extends:»,precedes:«,trail:•"
