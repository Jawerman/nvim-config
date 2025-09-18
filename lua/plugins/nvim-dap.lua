-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  "mfussenegger/nvim-dap",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
    -- Minimalistic ui
    "igorlfs/nvim-dap-view",
    "theHamsta/nvim-dap-virtual-text",
    {
      "mxsdev/nvim-dap-vscode-js",
      dependencies = { "microsoft/vscode-js-debug" },
    },
  },
  config = function()
    local dap = require("dap")
    local dap_ui = require("dapui")
    local dap_view = require("dap-view")

    require("nvim-dap-virtual-text").setup()

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- "delve",
        "codelldb",
        "cpptools",
        "lldb",
        "pwa-node",
      },
    })

    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      adapters = { "pwa-node", "pwa-chrome" },
    })

    -- 4. Adaptador pwa-chrome apuntando al nuevo entrypoint
    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }
    -- local mason_registry = require 'mason-registry'
    -- local codelldb = mason_registry.get_package 'codelldb'
    -- local codelldb_path = codelldb:get_install_path() .. '/extension/adapter/'
    -- dap.adapters.codelldb = {
    --   type = 'executable',
    --   port = '${port}',
    --   command = codelldb_path .. 'codelldb.exe',
    --   name = 'codelldb',
    -- }

    -- local mason_registry = require 'mason-registry'
    -- local codelldb_root = mason_registry.get_package('codelldb'):get_install_path() .. '/extension/'
    -- local codelldb_path = codelldb_root .. 'adapter/codelldb'
    -- local liblldb_path = codelldb_root .. 'lldb/lib/liblldb.so'
    -- dap.adapters.codelldb = {
    --   type = 'server',
    --   port = '${port}',
    --   host = '127.0.0.1',
    --   name = 'codelldb',
    --   executable = {
    --     command = codelldb_path,
    --     args = { '--liblldb', liblldb_path, '--port', '${port}' },
    --   },
    -- }
    --
    -- dap.configurations.zig = {
    --   {
    --     name = 'Debug using codelldb',
    --     type = 'cppdbg',
    --     request = 'launch',
    --     program = function()
    --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --     end,
    --     cwd = '${workspaceFolder}',
    --     stopAtEntry = true,
    --   },
    -- }

    -- local mason_registry = require 'mason-registry'
    -- local cpptools = mason_registry.get_package 'cpptools'
    -- local cpptools_path = cpptools:get_install_path() .. '/extension/debugAdapters/bin/'
    -- local cpptools_bin = cpptools_path .. 'OpenDebugAD7'
    -- dap.adapters.cppdbg = {
    --   id = 'cppdbg',
    --   type = 'executable',
    --   command = cpptools_bin,
    --   options = {
    --     detached = false,
    --   },
    -- }
    --
    --
    local chrome_attach_config = {
      {
        name = "Attach to Chrome (Web App)",
        type = "pwa-chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222, -- Chrome con remote debugging
        webRoot = "${workspaceFolder}",
      },
    }
    dap.configurations.typescript = chrome_attach_config
    dap.configurations.javascript = chrome_attach_config

    dap.configurations.zig = {
      {
        type = "codelldb",
        request = "launch",
        name = "Debug with lldb",
        stopAtEntry = true,
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = { "/usr/local/bin/zig" },
        cwd = "${workspaceFolder}",
      },
      {
        name = "debug with cpptools",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = {},
        stopAtEntry = true,
        cwd = "${workspaceFolder}/zig-out/bin",
        symbolSearchPath = "${workspaceFolder}/zig-out/bin",
        environment = {},
        externalConsole = false,
        logging = {
          moduleLoad = false,
        },
      },
    }

    local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1

    if is_windows then
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "C:\\absolute\\path\\to\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe",
        options = {
          detached = false,
        },
      }
    else
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        -- command = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",),
        command = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/OpenDebugAD7"),
      }
    end

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      },
      -- {
      --   name = "Attach to gdbserver :1234",
      --   type = "cppdbg",
      --   request = "launch",
      --   MIMode = "gdb",
      --   miDebuggerServerAddress = "localhost:1234",
      --   miDebuggerPath = "/usr/bin/gdb",
      --   cwd = "${workspaceFolder}",
      --   program = function()
      --     return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      --   end,
      -- },
    }

    dap.configurations.odin = dap.configurations.cpp

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F4>", dap.terminate, { desc = "Debug: End" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })

    -- vim.keymap.set("n", "<leader>dB", function()
    --   dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    -- end, { desc = "[d]ebug [B]reakpoint condition" })

    -- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: [t]oggle [b]reakpoint" })
    -- vim.keymap.set("n", "<leader>B", function()
    --   dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    -- end, { desc = "Debug: Set Breakpoint" })

    -- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[d]ebug [b]reakpoint" })
    -- vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "[d]ebug [c]lear breakpoints" })
    dap_ui.setup({
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 80,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    })
    dap_view.setup()

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- dapui.setup {
    --   -- Set icons to characters that are more likely to work in every terminal.
    --   --    Feel free to remove or use ones that you like more! :)
    --   --    Don't feel like these are good choices.
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '⏎',
    --       step_over = '⏭',
    --       step_out = '⏮',
    --       step_back = 'b',
    --       run_last = '▶▶',
    --       terminate = '⏹',
    --       disconnect = '⏏',
    --     },
    --   },
    -- }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<leader>du", dap_ui.toggle, { desc = "[d]ap [u]i" })
    vim.keymap.set("n", "<leader>dv", "<Cmd>DapViewToggle<CR>", { desc = "[d]ap [v]iew", silent = true })
    vim.keymap.set("n", "<leader>dt", "<Cmd>DapVirtualTextToggle<CR>", { desc = "[d]ap virtual [t]ext", silent = true })
    -- vim.keymap.set("n", "<F7>", dap_ui.toggle, { desc = "Debug: Toggle dap ui" })
    -- vim.keymap.set("n", "<F6>", "<Cmd>DapViewToggle<CR>", { desc = "Debug: Toggle dap view", silent = true })
    vim.keymap.set(
      { "n", "v" },
      "<leader>de",
      "<cmd>lua require('dap.ui.widgets').hover()<CR>",
      { desc = "[d]ebug [e]valuate" }
    )
    vim.keymap.set({ "n", "v" }, "<leader>dw", "<cmd>DapViewWatch<CR>", { desc = "[d]ebug [w]atch" })

    dap.defaults.fallback.external_terminal = {
      command = "alacritty.exe",
      args = { "-e" },
    }

    -- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    -- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    -- dap.listeners.before.event_exited["dapui_config"] = dapui.close
    --
    -- local function dap_init()
    --   vim.cmd("DapVirtualTextEnable")
    -- end
    --
    -- local function dap_end()
    --   vim.cmd("DapVirtualTextDisable")
    -- end

    -- dap.listeners.after.event_initialized["dapui_config"] = dap_init
    -- dap.listeners.before.event_terminated["dapui_config"] = dap_end
    -- dap.listeners.before.event_exited["dapui_config"] = dap_end

    -- Install golang specific config
    require("dap-go").setup({
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has("win32") == 0,
      },
    })

    -- debug web app
    local function launch_chrome_debug(url)
      local target_url = url or "http://localhost:5200"

      -- Launch Chrome in detached mode
      vim.fn.jobstart({
        "google-chrome",
        "--remote-debugging-port=9222",
        "--user-data-dir=" .. os.getenv("HOME") .. "/chrome-debug-profile",
        target_url,
      }, { detach = true })

      -- Attach to Chrome via DAP
      dap.run({
        name = "Attach to Chrome (" .. target_url .. ")",
        type = "pwa-chrome",
        request = "attach",
        port = 9222,
        webRoot = "${workspaceFolder}",
      })
    end

    vim.keymap.set("n", "<leader>dw", function()
      local input_url = vim.fn.input("URL to debug: ", "http://localhost:5200")
      launch_chrome_debug(input_url)
    end, { desc = "[d]ebug [w]eb" })
  end,
}
