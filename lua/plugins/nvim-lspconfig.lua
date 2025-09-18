return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "mason-org/mason-lspconfig.nvim" },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "saghen/blink.cmp",
  },

  config = function()
    -- =========================
    -- 1. Keymaps when LSP attaches
    -- =========================
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Navigation and actions
        map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[g]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "type [d]efinition")
        map("<leader>ss", require("telescope.builtin").lsp_document_symbols, "[s]earch [s]ymbols")
        map("<leader>sS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[s]earch workspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
        map("K", function()
          vim.lsp.buf.hover({ border = "rounded" })
        end, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

        -- Document highlight
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(ev)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = ev.buf })
            end,
          })
        end

        -- Toggle inlay hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    -- =========================
    -- 2. Diagnostics configuration
    -- =========================
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      } or {},
      virtual_text = {
        current_line = true,
        source = "if_many",
        spacing = 2,
        format = function(d)
          return d.message
        end,
      },
    })

    -- =========================
    -- 3. Helper to register and enable servers
    -- =========================
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local function setup_server(name, config)
      config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end

    -- =========================
    -- 4. Servers managed by Mason
    -- =========================
    local servers = {
      vtsls = {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      },
      -- ts_ls = {
      --   settings = {
      --     typescript = {
      --       -- tsdk = vim.fs.dirname(vim.fs.find({ "node_modules/typescript/lib" }, { upward = true })[1]),
      --       -- preferences = {
      --       --   tsConfigFile = "tsconfig.strict.json",
      --       -- },
      --       inlayHints = {
      --         includeInlayParameterNameHints = "all",
      --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --         includeInlayFunctionParameterTypeHints = true,
      --         includeInlayVariableTypeHints = true,
      --         includeInlayPropertyDeclarationTypeHints = true,
      --         includeInlayFunctionLikeReturnTypeHints = true,
      --         includeInlayEnumMemberValueHints = true,
      --       },
      --     },
      --     javascript = {
      --       inlayHints = {
      --         includeInlayParameterNameHints = "all",
      --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      --         includeInlayFunctionParameterTypeHints = true,
      --         includeInlayVariableTypeHints = true,
      --         includeInlayPropertyDeclarationTypeHints = true,
      --         includeInlayFunctionLikeReturnTypeHints = true,
      --         includeInlayEnumMemberValueHints = true,
      --       },
      --     },
      --   },
      -- },
      eslint = {
        on_attach = function(client, _)
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    }

    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    for name, cfg in pairs(servers) do
      setup_server(name, cfg)
    end

    -- =========================
    -- 5. Servers not managed by Mason (e.g., Godot)
    -- =========================
    local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
    local port = os.getenv("GDScript_Port") or "6005"
    local cmd_windows = vim.lsp.rpc.connect("127.0.0.1", tonumber(port))
    local cmd = { "ncat", "localhost", "6005" }

    local non_mason_servers = {
      gdscript = {
        name = "Godot",
        cmd = is_windows and cmd_windows or cmd,
        -- root_dir = function()
        --   return vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1])
        -- end,
        on_attach = function(client, bufnr)
          print("Connected to Godot LSP ✔️")
        end,
      },
    }

    for name, cfg in pairs(non_mason_servers) do
      setup_server(name, cfg)
    end

    -- =========================
    -- 6. Extra tools installation via Mason
    -- =========================
    require("mason-tool-installer").setup({
      ensure_installed = vim.tbl_keys(servers),
    })
  end,
}
