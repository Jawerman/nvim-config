return {
  "Exafunction/codeium.vim",
  config = function()
    vim.g.codeium_disable_bindings = 1
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set("i", "<Tab>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true, desc = "codeium accept" })

    vim.keymap.set("i", "<C-.>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, silent = true, desc = "codeium next" })

    vim.keymap.set("i", "<C-,>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, silent = true, desc = "codeium prev" })

    vim.keymap.set("i", "<c-j>", function()
      return vim.fn["codeium#AcceptNextWord"]()
    end, { expr = true, silent = true, desc = "codeium accept word" })

    vim.keymap.set("i", "<S-Tab>", function()
      return vim.fn["codeium#AcceptNextLine"]()
    end, { expr = true, silent = true, desc = "codeium accept line" })

    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, silent = true, desc = "codeium clear" })
  end,
}
