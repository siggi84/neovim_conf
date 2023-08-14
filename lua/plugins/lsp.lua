return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = 'Open the diagnostic float' })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to the previous diagnostic' })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to the next diagnostic' })
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist,
                { desc = 'Set the location list to the diagnostics' })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show hover" })
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
                        { buffer = ev.buf, desc = "Go to implementation" })
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
                        { buffer = ev.buf, desc = "Show signature help" })
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder,
                        { buffer = ev.buf, desc = "Add workspace folder" })
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                        { buffer = ev.buf, desc = "Remove workspace folder" })
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, { buffer = ev.buf, desc = "List workspace folders" })
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,
                        { buffer = ev.buf, desc = "Go to type definition" })
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action,
                        { buffer = ev.buf, desc = "Show code actions" })
                    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "Some description"}) -- Use telescope instead
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, { buffer = ev.buf, desc = "Format document" })
                end,
            })
        end,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- "jose-elias-alvarez/null-ls.nvim" -- Is this needed?
        }
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "ruff_lsp", "dockerls", "docker_compose_language_service" } -- not an option from mason.nvim
            }
            )
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
            }
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
        opts = function()
            local nls = require("null-ls")
            return {
                sources = {
                    nls.builtins.formatting.black,
                    nls.builtins.diagnostics.mypy,
                    nls.builtins.diagnostics.hadolint,
                },
            }
        end
    },
    {
        "L3MON4D3/LuaSnip",
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end
            }
        },
        opts = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                experimental = {
                    ghost_text = true,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'copilot' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        version = false,
        config = function()
            require("mini.comment").setup()
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        module = "Copilot",
        opts = {
            suggestion = { enable = false },
            panel = { enable = false },
        },
    }
}
