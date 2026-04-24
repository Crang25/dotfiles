return {
  {
    "williamboman/mason.nvim",

    lazy = false,
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",

    lazy = false,
    opts = function()
      local ensure_installed = {
        "lua_ls",
        "vtsls",
        "angularls",
        "pyright",
        "html",
        "css_variables",
        "somesass_ls",
        "djlsp",
        "clangd",
        "asm_lsp",
      }

      if vim.fn.executable("cargo") == 1 then
        table.insert(ensure_installed, "jinja_lsp")
      end

      return {
        ensure_installed = ensure_installed,
        automatic_enable = false,
      }
    end,
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = vim.lsp.config
      local has_jinja_lsp = vim.fn.executable("jinja-lsp") == 1

      lspconfig("lua_ls", {
        capabilities = capabilities,
      })

      lspconfig("vtsls", {
        capabilities = capabilities,
        settings = {
          vtsls = {
            angular = {
              enable = true,
            },
          },
        },
      })

      lspconfig("angularls", {
        capabilities = capabilities,
      })

      lspconfig("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
            },
          },
        }
      })

      lspconfig("djlsp", {
        capabilities = capabilities,
        filetypes = { "htmldjango" },
        root_markers = { "manage.py", "pyproject.toml", ".git" },
      })

      if has_jinja_lsp then
        lspconfig("jinja_lsp", {
          capabilities = capabilities,
        })
      end

      lspconfig("html", {
        capabilities = capabilities,
        init_options = {
          provideFormatter = false,
        },
      })

      lspconfig("css_variables", {
        capabilities = capabilities,
      })

      lspconfig("somesass_ls", {
        capabilities = capabilities,
      })

      lspconfig("glint", {
        capabilities = capabilities,
        filetypes = { "handlebars", "typescript.glimmer" },
      })

      lspconfig("gopls", {
        capabilities = capabilities,
      })

      lspconfig("clangd", {
        capabilities = capabilities,
      })

      lspconfig("asm_lsp", {
        capabilities = capabilities,
      })

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("vtsls")
      vim.lsp.enable("angularls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("djlsp")
      if has_jinja_lsp then
        vim.lsp.enable("jinja_lsp")
      end
      vim.lsp.enable("html")
      vim.lsp.enable("css_variables")
      vim.lsp.enable("somesass_ls")
      vim.lsp.enable("glint")
      vim.lsp.enable("gopls")
      vim.lsp.enable("clangd")
      vim.lsp.enable("asm_lsp")

      local lsp_keymaps = vim.api.nvim_create_augroup("user_lsp_keymaps", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_keymaps,
        callback = function(event)
          local opts = { buffer = event.buf, silent = true }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
