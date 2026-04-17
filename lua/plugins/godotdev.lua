return {
  "Mathijs-Bakker/godotdev.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("godotdev").setup({
      editor_host = "127.0.0.1", -- Godot editor host
      editor_port = 6005, -- LSP port
      debug_port = 6006, -- DAP port
      -- csharp = true, -- enable C# support
      -- autostart_editor_server = true, -- optional, start server automatically
    })

    local dap = require("dap")
    dap.listeners.after.event_initialized["godotdev"] = nil
    dap.listeners.after.event_initialized["dapui_config"] = nil
  end,
}
