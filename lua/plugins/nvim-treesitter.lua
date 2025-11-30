return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  -- branch = "master",
  branch = "main",
  -- opts = {
  --   -- ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "c3", "odin" },
  --   -- Autoinstall languages that are not installed
  --   -- auto_install = true,
  --   highlight = {
  --     enable = true,
  --     -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
  --     --  If you are experiencing weird indenting issues, add the language to
  --     --  the list of additional_vim_regex_highlighting and disabled languages for indent.
  --     additional_vim_regex_highlighting = { "ruby" },
  --     ---@diagnostic disable-next-line: unused-local
  --     disable = function(lang, buf)
  --       local max_filesize = 100 * 1024 -- 100 KB
  --       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  --       if ok and stats and stats.size > max_filesize then
  --         return true
  --       end
  --     end,
  --   },
  --   indent = { enable = true, disable = { "ruby" } },
  -- },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    -- require("nvim-treesitter.install").prefer_git = true

    -- Definir una sola variable con los lenguajes
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

    -- Usar la variable en la instalación
    require("nvim-treesitter").install(languages)

    local max_filesize = 100 * 1024 -- 100 KB

    vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function()
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
        if ok and stats and stats.size > max_filesize then
          vim.notify(
            "Treesitter desactivado: fichero demasiado grande (" .. stats.size .. " bytes)",
            vim.log.levels.WARN
          )
          return
        end
        vim.treesitter.start()
      end,
    })
  end,
}
