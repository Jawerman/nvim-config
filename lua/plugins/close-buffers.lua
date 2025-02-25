return {
  "Asheq/close-buffers.vim",
  init = function()
    vim.keymap.set("n", "<leader>bo", ":Bdelete other<CR>", { desc = "[b]uffers close [o]thers" })
    vim.keymap.set("n", "<leader>bh", ":Bdelete hidden<CR>", { desc = "[b]uffers close [h]idden" })
  end,
}
