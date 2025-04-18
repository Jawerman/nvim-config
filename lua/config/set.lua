-- Set the <space> as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Using nerd font
vim.g.have_nerd_font = true

-- Relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse
vim.opt.mouse = "a"

-- Don't show current mode
vim.opt.showmode = false

-- Sync clipboard between OS and nvim
-- vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo file
vim.opt.undofile = true

-- Case insensitive search UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Display which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- See `:help 'list'`
-- See `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below cursor
vim.opt.scrolloff = 10

-- default tab size
local tabSize = 2
vim.opt.tabstop = tabSize
vim.opt.softtabstop = tabSize
vim.opt.shiftwidth = tabSize
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Set highlight on search
vim.opt.hlsearch = true

-- diagnostics
vim.diagnostic.config({
  -- virtual_text = { current_line = true },
  virtual_lines = { current_line = true },
})
-- vim.o.winborder = "solid"
vim.o.background = "dark" -- or "light" for light mode

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
