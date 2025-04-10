return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- { -- If encountering errors, see telescope-fzf-native README for installation instructions
    --   'nvim-telescope/telescope-fzf-native.nvim',
    --
    --   -- `build` is used to run some command when the plugin is installed/updated.
    --   -- This is only run then, not every time Neovim starts up.
    --   build = 'make',
    --
    --   -- `cond` is a condition used to determine whether this plugin should be
    --   -- installed and loaded.
    --   cond = function()
    --     return vim.fn.executable 'make' == 1
    --   end,
    -- },
    { "nvim-telescope/telescope-ui-select.nvim" },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    "natecraddock/telescope-zf-native.nvim",
    "princejoogie/dir-telescope.nvim",
    -- "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require("telescope").setup({
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      defaults = {
        path_display = { "truncate" },
        layout_strategy = "vertical",
        layout_config = {
          width = 0.95,
          -- anchor = 'S',
          -- height = 0.75,
          -- width = vim.o.columns,
          -- prompt_position = 'bottom',
          -- preview_height = 0.6,
        },
        wrap_results = true,
        -- TODO: Check whether is neccesary for node projects
        -- file_ignore_patterns = {
        --   'node_modules'
        -- }
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        --
        current_buffer_tags = {
          fname_width = 0.5,
          show_line = false,
        },
        jumplist = {
          fname_width = 0.5,
          show_line = false,
        },
        loclist = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_definitions = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_document_symbols = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_dynamic_workspace_symbols = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_implementations = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_incoming_calls = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_outgoing_calls = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_references = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_type_definitions = {
          fname_width = 0.5,
          show_line = false,
        },
        lsp_workspace_symbols = {
          fname_width = 0.5,
          show_line = false,
        },
        oldfiles = {
          cwd_only = true,
        },
        quickfix = {
          fname_width = 0.5,
          show_line = false,
        },
        tags = {
          fname_width = 0.5,
          show_line = false,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        ["dir-telescope"] = {
          require("dir-telescope").setup({
            -- these are the default options set
            hidden = false,
            no_ignore = false,
            show_preview = true,
            follow_symlinks = false,
          }),
        },
        -- ["file_browser"] = {
        --   theme = "ivy",
        --   -- disables netrw and use telescope-file-browser in its place
        --   hijack_netrw = true,
        --   mappings = {
        --     ["i"] = {
        --       -- your custom insert mode mappings
        --     },
        --     ["n"] = {
        --       -- your custom normal mode mappings
        --     },
        --   },
        -- },
      },
    })

    -- Enable Telescope extensions if they are installed
    -- pcall(require('telescope').load_extension, 'fzf')
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "zf-native")

    -- Display line numbers and wrap lines in telescope preview
    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      group = vim.api.nvim_create_augroup("kickstart-telescope-preview", { clear = true }),
      callback = function()
        vim.wo.number = true
        vim.wo.wrap = true
      end,
    })

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
    vim.keymap.set("n", "<leader>s.", builtin.builtin, { desc = "[s]earch Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
    vim.keymap.set("n", "<leader>sl", builtin.live_grep, { desc = "[s]earch [l]ive grep" })
    vim.keymap.set("n", "<leader>sg", builtin.git_status, { desc = "[s]earch [g]it status" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
    vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "[s]earch [o]ld files" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[s]earch existing [b]uffers" })
    vim.keymap.set("n", "<leader>st", function()
      builtin.grep_string({
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = "",
      })
    end, { desc = "[s]earch [t]ext" })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
        layout_config = { width = 0.95, height = 0.5 },
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[s]earch [/] in Open Files" })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[s]earch [n]eovim files" })
    -- Shortcut for searching your Neovim configuration files
    --
  end,
}
