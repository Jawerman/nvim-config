return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
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
      "markdown_inline",
      "vim",
      "gdscript",
      "vimdoc",
      "c3",
      "odin",
      "zig",
      "css",
      "scss",
      "typescript",
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

    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
    vim.bo.indentexpr = "v:lua.vim.treesitter.indent()"

    -- Opcional: Esto hace que el área de plegado sea visible en el lateral
    -- '0' para ocultar, '1' para ver una columna con indicadores
    vim.opt.foldcolumn = "0"
  end,
}
