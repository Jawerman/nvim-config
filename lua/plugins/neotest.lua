return {
  {
    "nvim-neotest/neotest-jest",
  },
  {
    "nvim-neotest/neotest",
    commit = "1d4b3bd89afa8bfa12fffd2bb1ccd26ac3c92ce5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-jest",
    },
    -- opts = {
    --   adapters = {
    --     require("neotest-jest"),
    --   },
    -- },
    opts = function()
      return {
        -- log_level = vim.log.levels.DEBUG,
        adapters = { require("neotest-jest") },
        summary = {
          open = "botright split | resize 20",
        },
      }
    end,
    keys = {
      {
        "<leader>nf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "[n]eotest [f]ile",
      },
      {
        "<leader>na",
        function()
          require("neotest").run.run(vim.loop.cwd())
        end,
        desc = "[n]eotest [A]ll",
      },
      {
        "<leader>nn",
        function()
          require("neotest").run.run()
        end,
        desc = "[n]eotest [n]earest",
      },
      {
        "<leader>nS",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "[n]eotest [S]ummary",
      },
      {
        "<leader>no",
        function()
          require("neotest").output.open({ enter = false, auto_close = true })
        end,
        desc = "[n]eotest [o]utput",
      },
      {
        "<leader>nO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "[n]eotest [O]utput panel",
      },
      {
        "<leader>ns",
        function()
          require("neotest").run.stop()
        end,
        desc = "[n]eotest [s]top",
      },
      {
        "<leader>nd",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "[n]eotest [d]ebug",
      },
    },
  },
}
