return {
  {
    "williamboman/mason.nvim",

    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",

    lazy = false,
    -- set auto to automatically install needed lsp
    -- instead to declare it manually in setup
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "vtsls",
          "pyright",
          -- "clangd",
          "angularls",
          "html",
          'css_variables',
          'somesass_ls',
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- local lspconfig = require("lspconfig")
      local lspconfig = vim.lsp.config

      lspconfig('lua_ls', {
        capabilities = capabilities,
      })
      lspconfig('vtsls', {
        capabilities = capabilities,
        filetypes = {
          'javascript',
          -- 'javascriptreact',
          -- 'javascript.jsx',
          'typescript',
          -- 'typescriptreact',
          'typescript.tsx',
          -- Add the Angular filetypes to ensure templates are handled.
          'html',
          'css',
        },
        settings = {
          vtsls = {
            -- This is the key setting to enable Angular support
            angular = {
              enable = true,
            },
            -- You might also need to explicitly disable the standard tsserver
            -- if it's conflicting.
            tsserver = {
              enabled = false,
            },
          },
        },
      })
      lspconfig('angularls', {
        capabilities = capabilities,
        on_new_config = function(new_config, new_root_dir)
          -- Tell angular-language-server where your project's node_modules are
          new_config.cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations", new_root_dir,
            "--ngProbeLocations", new_root_dir
          }
        end,
        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
        -- root_dir = vim.lsp.util.root_pattern("angular.json", ".git"),
        root_markers = { "typescript", "html", "typescriptreact", "typescript.tsx" }
      })
      -- python
      lspconfig('pyright', {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              -- typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
            venvPath = {
              "venv",
              ".venv",
              "env",
              ".env",
              -- vim.fn.expand("~/.pyenv/versions"),
            },
          },
        }
      })
      lspconfig('html', {
        capabilities = capabilities,
      })
      lspconfig('css_variables', {
        capabilities = capabilities,
      })
      -- scss
      lspconfig('somesass_ls', {
        capabilities = capabilities,
      })
      -- handlebars
      lspconfig('glint', {
        capabilities = capabilities,
        filetypes = { 'handlebars', 'typescript.glimmer' }, -- Only for Glimmer files
      })
      -- golang
      lspconfig('gopls', {
        capabilities = capabilities,
      })
      -- c/c++
      -- lspconfig('clangd', {
      --   capabilities = capabilities,
      -- })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      -- what does buf.declaration do???
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, {})
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- it's better to use telescope.lsp_references,
      -- so i declared a map in telescope's spec
      --vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
    end,
  },
}
