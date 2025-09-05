return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>bf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[b]uffer [f]ormat",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      print("format_on_save", vim.bo[bufnr].filetype)
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      gdscript = { "gdformat" },
      markdown = { "prettier" },
      -- typescript = { "eslint_d", "prettier", stop_after_first = true },
      html = { "prettier", "prettierd" },
      htmlangular = { "prettier", "prettierd" },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      gdformat = {
        command = vim.fn.stdpath("data") .. "/mason/bin/gdformat",
        args = { "$FILENAME" },
        stdin = false,
      },
    },
  },
  -- config = function(_, opts)
  --   require("conform").setup(opts)
  --
  --   -- Autocmd manual para que HTML se formatee al guardar
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     pattern = "*.html",
  --     callback = function(args)
  --       require("conform").format({
  --         bufnr = args.buf,
  --         timeout_ms = 500,
  --         lsp_fallback = true,
  --       })
  --     end,
  --   })
  -- end,
}
