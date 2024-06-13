-- Easy window handing
vim.keymap.set("n", "<leader>w", "<C-w>")

-- Move highlighted selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines doesn't move the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Center cursor while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Center cursor while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over, overwrited text to void register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- copy to system clipboard
vim.keymap.set("n", "Y", "\"+y")
vim.keymap.set("v", "Y", "\"+y")
vim.keymap.set("n", "yY", "^\"+y$")

-- buffer navigation
vim.keymap.set("n", "<leader><tab>", ":b#<CR>")

-- search selected text
vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>")

-- terminal
vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>")

-- hide search highlight
vim.keymap.set("n", "<leader>sc", ":noh<CR>")

-- copy file path to clipboard
vim.keymap.set("n", "<leader>cp", '<Cmd>let @+ = expand("%")<CR>', { silent = true })

vim.keymap.set("n", "<C-j>", ":cn<CR>")
vim.keymap.set("n", "<C-k>", ":cp<CR>")

-- vim.keymap.set('n', '<Leader>sc', '<cmd>lua require("jawer.my_funcs").switch_case()<CR>', {noremap = true, silent = true})
