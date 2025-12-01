return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  -- branch = "master",
  branch = "main",
  config = function(_, opts)
    local languages = {
      "bash",
      "c",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "vim",
      "vimdoc",
      "c3",
      "odin",
      "zig",
      "css",
      "scss",
      "typescript",
      "htmlangular",
      "angular",
    }

    require("nvim-treesitter").install(languages)

    local max_filesize = 100 * 1024 -- 100 KB

    vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function()
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size > max_filesize then
          vim.notify("Treesitter disabled: file too big (" .. stats.size .. " bytes)", vim.log.levels.WARN)
          return
        end
        vim.treesitter.start()
      end,
    })
  end,
}
