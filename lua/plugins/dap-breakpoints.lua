return {
  "Carcuis/dap-breakpoints.nvim",
  dependencies = {
    "Weissle/persistent-breakpoints.nvim",
  },
  config = function()
    require("persistent-breakpoints").setup()
    require("dap-breakpoints").setup({
      auto_load = false, -- auto load breakpoints on 'BufReadPost'
      auto_save = false, -- auto save breakpoints when make changes to breakpoints
    })

    vim.keymap.set("n", "<leader>db", "<CMD>DapBpToggle<CR>", { desc = "[d]ebug [b]reakpoint", silent = true })
    vim.keymap.set("n", "<leader>dc", "<CMD>DapBpClearAll<CR>", { desc = "[d]ebug [c]lear breakpoints", silent = true })
    -- vim.keymap.set("n", "<leader>dt", "<CMD>DapBpVirtToggle<CR>", { desc = "[d]ap virtual [t]ext", silent = true })
    vim.keymap.set("n", "<leader>ds", "<CMD>DapBpSave<CR>", { desc = "[d]ap [s]ave breakpoints", silent = true })
    vim.keymap.set("n", "<leader>dl", "<CMD>DapBpLoad<CR>", { desc = "[d]ap [l]oad breakpoints", silent = true })
    vim.keymap.set("n", "<leader>dn", "<CMD>DapBpNext<CR>", { desc = "[d]ap [n]ext breakpoint", silent = true })
    vim.keymap.set("n", "<leader>dp", "<CMD>DapBpPrev<CR>", { desc = "[d]ap [p]rev breakpoint", silent = true })
    vim.keymap.set(
      "n",
      "<leader>dC",
      "<CMD>DapBpSetConditionalPoint<CR>",
      { desc = "[d]ebug [B]reakpoint condition", silent = true }
    )
  end,
}
