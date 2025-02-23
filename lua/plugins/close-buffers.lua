return {
  "Asheq/close-buffers.vim",
  init = function()
    vim.keymap.set("n", "<leader>bo", ":Bdelete other<CR>", { desc = "[B]uffers close [O]thers" })
    vim.keymap.set("n", "<leader>bh", ":Bdelete hidden<CR>", { desc = "[B]uffers close [H]idden" })
  end,
}
