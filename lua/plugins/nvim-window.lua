return {
    "yorickpeterse/nvim-window",
    keys = {{
        "<C-w>",
        "<cmd>lua require('nvim-window').pick()<cr>",
        desc = "nvim-window: Jump to window"
    }},
    config = true
}
