return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  version = "2.*",
  config = function()
    local window_picker = require("window-picker")
    window_picker.setup({
      hint = "floating-letter",
      -- hint = "floating-big-letter",
      -- hint = "statusline-winbar",
    })

    vim.keymap.set("n", "<leader><leader>w", function()
      vim.api.nvim_set_current_win(require("window-picker").pick_window())
    end, { desc = "[w]indow picker", silent = true })
  end,
}
