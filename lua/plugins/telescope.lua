return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    -- or                            , branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'molecule-man/telescope-menufacture',
        'natecraddock/telescope-zf-native.nvim',
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("live_grep_args")
        telescope.load_extension("menufacture")
        telescope.load_extension("zf-native")
        
        local builtin = require('telescope.builtin')
        local manufacture = telescope.extensions.menufacture;

        telescope.setup {
            defaults = {
                path_display = {"truncate"},
                layout_strategy = "vertical",
                layout_config = {
                    anchor = "S",
                    -- height = vim.o.lines,
                    height = 0.75,
                    width = vim.o.columns,
                    prompt_position = "bottom",
                    preview_height = 0.5
                },
                wrap_results = true,
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                    }
                }
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
                    show_line = false
                },
                jumplist = {
                    fname_width = 0.5,
                    show_line = false
                },
                loclist = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_definitions = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_document_symbols = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_dynamic_workspace_symbols = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_implementations = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_incoming_calls = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_outgoing_calls = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_references = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_type_definitions = {
                    fname_width = 0.5,
                    show_line = false
                },
                lsp_workspace_symbols = {
                    fname_width = 0.5,
                    show_line = false
                },
                oldfiles = {
                    cwd_only = true
                },
                quickfix = {
                    fname_width = 0.5,
                    show_line = false
                },
                tags = {
                    fname_width = 0.5,
                    show_line = false
                }
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
            }
        }

        vim.api.nvim_create_autocmd("User", {
            pattern = "TelescopePreviewerLoaded",
            callback = function()
                vim.wo.number = true
                vim.wo.wrap = true
            end
        })

        -- files
        vim.keymap.set('n', '<leader>sf', manufacture.find_files, {})
        vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>so', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>sl', manufacture.live_grep, {})
        vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>sq', builtin.quickfix, {})
        vim.keymap.set('n', '<leader>sws', builtin.lsp_dynamic_workspace_symbols, {})
        vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>sm', builtin.marks, {})

        vim.keymap.set('n', '<leader>sgb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>sgs', builtin.git_status, {})

        vim.keymap.set('n', '<leader>tr', builtin.resume, {})

        -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        -- vim.keymap.set("n", "<leader>fga", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        --
        -- custom
        vim.keymap.set('n', '<leader>fg', function()
            builtin.live_grep({
                glob_pattern = vim.fn.input("Pattern > ")
            })
        end, {})

        vim.keymap.set('n', '<leader>st', function()
            builtin.grep_string {
                shorten_path = true,
                word_match = "-w",
                only_sort_text = true,
                search = ''
            }
        end, {})

        vim.keymap.set('n', '<leader>se', function()
            local sorter = require("telescope.sorters").get_fzy_sorter()

            local fn = sorter.scoring_function

            sorter.scoring_function = function(_, prompt, line)
                local score = fn(_, prompt, line)

                return score > 0 and 1 or -1;
            end

            builtin.oldfiles({
                sorter = sorter,
                tiebreak = function(current_entry, existing_entry, _)
                    return current_entry.index > existing_entry.index
                end
            })
        end, {})

    end
}
