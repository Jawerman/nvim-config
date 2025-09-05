-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Deactivating treesitter folding for too large files
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    if vim.fn.getfsize(vim.fn.expand("%")) > 1000000 then
      vim.opt_local.foldmethod = "manual"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-float",
  callback = function()
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = true, silent = true, desc = "Cerrar popup DAP" })
  end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   desc = "Enable completion triggered by <c-x><c-o>",
--   group = vim.api.nvim_create_augroup("kickstart-completion", { clear = true }),
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client and client:supports_method("textDocument/completion") then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
--

-- Deactivating treesitter folding for txt files
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "txt",
--   callback = function()
--     vim.opt_local.foldmethod = "manual"
--     -- deactivate syntax highlighting
--     --vim.cmd("syntax off")
--   end,
-- })
