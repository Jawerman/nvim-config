return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()

    -- To used zf-native for fuzzy finding
    local function toggle_telescope(harpoon_files)
      local conf = require("telescope.config").values
      local fznative = require("telescope").extensions["zf-native"]

      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = fznative.native_zf_scorer({}),
        })
        :find()
    end

    -- File Operations
    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():append()
    end, { desc = "Harpoon: Add current file" })
    vim.keymap.set("n", "<leader>hl", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: List all Harpoon files" })

    -- File Selection
    vim.keymap.set("n", "<leader>h1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon: Select Harpoon file 1" })
    vim.keymap.set("n", "<leader>h2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon: Select Harpoon file 2" })
    vim.keymap.set("n", "<leader>h3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon: Select Harpoon file 3" })
    vim.keymap.set("n", "<leader>h4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon: Select Harpoon file 4" })

    vim.keymap.set("n", "<leader>hda", function()
      harpoon:list():clear()
    end, { desc = "Harpoon: Clear all Harpoon files" })
    vim.keymap.set("n", "<leader>hd1", function()
      harpoon:list():remove(1)
    end, { desc = "Harpoon: Clear Harpoon file 1" })
    vim.keymap.set("n", "<leader>hd2", function()
      harpoon:list():remove(2)
    end, { desc = "Harpoon: Clear Harpoon file 2" })
    vim.keymap.set("n", "<leader>hd3", function()
      harpoon:list():remove(3)
    end, { desc = "Harpoon: Clear Harpoon file 3" })
    vim.keymap.set("n", "<leader>hd4", function()
      harpoon:list():remove(4)
    end, { desc = "Harpoon: Clear Harpoon file 4" })

    vim.keymap.set("n", "<leader>hs", function()
      toggle_telescope(harpoon:list())
    end, { desc = "[h]arpoon [s]search" })
  end,
}
