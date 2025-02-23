return {
  "tpope/vim-projectionist",
  init = function()
    vim.g.projectionist_heuristics = {
      ["*"] = {
        ["*.ts"] = {
          alternate = { "{}.html", "{}.scss", "{}.spec.ts" },
          type = "controller",
        },
        ["*.html"] = {
          alternate = { "{}.ts", "{}.scss", "{}.spec.ts" },
          type = "view",
        },
        ["*.scss"] = {
          alternate = { "{}.html", "{}.ts", "{}.spec.ts" },
          type = "styles",
        },
        ["*.spec.ts"] = {
          alternate = { "{}.ts", "{}.html", "{}.scss" },
          type = "test",
        },
      },
    }
  end,
}
