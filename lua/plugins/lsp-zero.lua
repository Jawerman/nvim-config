return {{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = { --- Uncomment these if you want to manage LSP servers from neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim', -- LSP Support
    'neovim/nvim-lspconfig', -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
},
    config = function()
        local lspconfig = require('lspconfig');
        local lsp_zero = require('lsp-zero')
        local lsp = lsp_zero.preset({})
        local inlayhints = require('lsp-inlayhints');

        --  format on save function
        -- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
        -- local lsp_format_on_save = function(bufnr)
        --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --   vim.api.nvim_create_autocmd('BufWritePre', {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --       vim.lsp.buf.format()
        --     end,
        --   })
        -- end

        lsp.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp.default_keymaps({
                buffer = bufnr
            })
            vim.opt.foldmethod = "expr"
            -- lsp_format_on_save(bufnr)
        end)

        -- Mason setup
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {'tsserver', 'angularls', 'lua_ls'},
            handlers = {
                rust_analyzer = function()
                end,
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end
            }
        })

        --  (Optional) Configure lua language server for neovim
    lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
    -- lspconfig.lua_ls.setup({})

        --  Ts server configuration
        lspconfig.tsserver.setup({
            init_options = {
                preferences = {
                    -- includeInlayParameterNameHints = 'all',
                    -- includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    -- includeInlayFunctionParameterTypeHints = true,
                    -- includeInlayVariableTypeHints = true,
                    -- includeInlayPropertyDeclarationTypeHints = true,
                    -- includeInlayFunctionLikeReturnTypeHints = true,
                    -- includeInlayEnumMemberValueHints = true,

                    -- other preferences...
                    importModuleSpecifierPreference = 'relative',
                    importModuleSpecifierEnding = 'minimal'
                },
                completionDisableFilterText = true,
            }
        })

        local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
        local port = os.getenv('GDScript_Port') or '6005'
        local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
        if is_windows then
            cmd = {"ncat", "localhost", "6005"}
        end
        local pipe = '/path/to/godot.pipe' -- I use /tmp/godot.pipe

        lspconfig.gdscript.setup({
            name = 'Godot',
            cmd = cmd,
            root_dir = function()
                return vim.fs.dirname(vim.fs.find({'project.godot', '.git'}, {
                    upward = true
                })[1])
            end,
            on_attach = function(client, bufnr)
                vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
            end
        })

        -- Eslint fix on save
        -- lspconfig.eslint.setup({
        --   on_attach = function(client, bufnr)
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --       buffer = bufnr,
        --       command = "EslintFixAll",
        --     })
        --   end,
        -- })

        ---------------------------------------------------------------------------------------------------
        -- Attempt to customize angularls

        -- local function get_probe_dir(root_dir)
        --   local project_root = lspconfig.util.find_node_modules_ancestor(root_dir)
        --   return project_root and (project_root .. '/node_modules') or ''
        -- end
        --
        -- local default_probe_dir = get_probe_dir(vim.fn.getcwd())
        --
        -- local cmd = {
        --   'ngserver',
        --   '--stdio',
        --   '--tsProbeLocations',
        --   default_probe_dir,
        --   '--ngProbeLocations',
        --   default_probe_dir,
        -- }
        --
        --
        -- lspconfig.angularls.setup {
        --   cmd = cmd,
        --   on_new_config = function(new_config, new_root_dir)
        --     local new_probe_dir = get_probe_dir(new_root_dir)
        --
        --     new_config.cmd = {
        --       'ngserver',
        --       '--stdio',
        --       '--tsProbeLocations',
        --       new_probe_dir,
        --       '--ngProbeLocations',
        --       new_probe_dir,
        --     }
        --   end,
        --   default_config = {
        --     root_dir = [[root_pattern("angular.json")]],
        --   }
        -- }

        ---------------------------------------------------------------------------------------------------

        -- Inlay hints
        vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
        vim.api.nvim_create_autocmd("LspAttach", {
            group = "LspAttach_inlayhints",
            callback = function(args)
                if not (args.data and args.data.client_id) then
                    return
                end

                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                inlayhints.on_attach(client, bufnr)
            end
        })
        inlayhints.setup()

        lsp.setup()

        -- Keymaps
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
        vim.keymap.set('n', '<leader>fb', vim.lsp.buf.format, {})

        -- Setted by default
        --   gl: show line diagnostics
    end
}, 'lvimuser/lsp-inlayhints.nvim'}
