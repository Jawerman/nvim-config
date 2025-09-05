-- Hide highlighted search occurrences
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "No highlighted search" })

-- Easy window handling
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window" })

-- Move highlighted selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down", silent = true })

-- Joint lines doesn't move the cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving the cursor" })

-- Center cursor while scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })

-- Center cursor while searching
vim.keymap.set("n", "n", "nzzzv", { desc = "Search next and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous and center" })

-- Paste over, overwrited text to void register
-- TODO: Add to whichkey
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste over, text to void" })

-- Copy to system clipboard
vim.keymap.set("n", "Y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "Y", '"+y', { desc = "Yank to system clipboard" })
-- vim.keymap.set('n', 'yY', '^"+y$', { desc = 'Yank line to system clipboard'})
vim.keymap.set("n", "yY", 'mz^"+y$`z', { desc = "Yank line to system clipboard" }) -- Variant without moving the cursor

-- Alternate last used buffers
vim.keymap.set("n", "<leader><tab>", ":b#<CR>", { desc = "Alternate buffer", silent = true })

-- search highlighted text
vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { desc = "Search highlighted text", silent = true })

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Copy current file path to clipboard
-- TODO: maybe change current
vim.keymap.set(
  "n",
  "<leader>fp",
  '<Cmd>let @+ = expand("%")<CR>',
  { desc = "[f]ile [p]ath to clipboard", silent = true }
)

vim.keymap.set(
  "n",
  "<leader>fn",
  '<Cmd>let @+ = expand("%:t")<CR>',
  { desc = "[f]ile [n]ame to clipboard", silent = true }
)

-- non destructive copy
vim.keymap.set("x", "P", '"_dP')

-- Easy navigate quickfix result
vim.keymap.set("n", "<C-j>", ":cn<CR>", { desc = "Next quickfix", silent = true })
vim.keymap.set("n", "<C-k>", ":cp<CR>", { desc = "Previous quickfix", silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<C-p>", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [d]iagnostic message" })

vim.keymap.set("n", "<C-n>", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next [d]iagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })

vim.keymap.set("n", "<leader>tn", function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
    vim.wo.number = true
  end
end, { desc = "[t]oggle line [n]umbers mode" })

vim.keymap.set("n", "<leader>tl", function()
  local virtual_lines = vim.diagnostic.config().virtual_lines
  if virtual_lines then
    virtual_lines = false
  else
    virtual_lines = { current_line = true }
  end
  vim.diagnostic.config({
    virtual_lines = virtual_lines,
  })
end, { desc = "[t]oggle virtual [l]ines" })
