return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    -- require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup {
    --   n_lines = 500,
    --   search_method = 'cover_or_next',
    -- }

    -- File explorer
    require("mini.files").setup({
      windows = {
        width_focus = 60,
      },
    })

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require("mini.statusline")
    -- set use_icons to true if you have a Nerd Font
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return "%2l:%-2v"
    end

    vim.keymap.set("n", "<leader>fm", function()
      require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
    end, { desc = "[f]iles [m]ini" })

    vim.keymap.set("n", "<leader>fM", function()
      require("mini.files").open(vim.uv.cwd(), true)
    end, { desc = "[f]iles [M]ini (cwd)" })

    -- Keybindingf
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
