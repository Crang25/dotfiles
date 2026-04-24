return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = function()
      local ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "vtsls",
        "angular-language-server",
        "pyright",
        "html-lsp",
        "css-variables-language-server",
        "some-sass-language-server",
        "django-template-lsp",
        "gopls",
        "glint",
        "clangd",
        "asm-lsp",
        -- Formatters and linters
        "stylua",
        "prettier",
        "eslint_d",
        "black",
        "isort",
        "djlint",
      }

      if vim.fn.executable("cargo") == 1 then
        table.insert(ensure_installed, "jinja-lsp")
      end

      return {
        ensure_installed = ensure_installed,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        auto_update = false,
      }
    end,
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
    end,
  },
}
