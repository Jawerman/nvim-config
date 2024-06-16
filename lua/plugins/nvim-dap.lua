return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require('dap')
    dap.adapters.godot = {
      type = "server",
      host = '127.0.0.1',
      port = 6006,
    }
    dap.configurations.gdscript = {
      {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
      }
    }
    local dap = require('dap')
    
    vim.keymap.set("n", "<F5>", dap.continue, { desc = 'Debug: Start/Continue'})
    vim.keymap.set("n", "<F6>", function()
        dap.terminate()
    end, { desc = 'Debug: Stop'})
    vim.keymap.set("n", "<F8>", dap.step_into, { desc = 'Debug: Step Into'})
    vim.keymap.set("n", "<F7>", dap.step_over, { desc = 'Debug: Step Over'})
    vim.keymap.set("n", "<F9>", dap.step_out, { desc = 'Debug: Step Out'})
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint'})
    vim.keymap.set("n", "<leader>B", function()
    dap.set_breakpoint(vin.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Toggle Breakpoint with condition'})

    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)
  end
}
