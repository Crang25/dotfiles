return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },

  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local template_filetypes = { "django", "htmldjango", "jinja", "jinja.html" }

    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.prettier,
        require("none-ls.code_actions.eslint_d"),
        -- Keep Python ordering deterministic: imports first, then code format.
        formatting.isort,
        formatting.black,
        formatting.djlint.with({ filetypes = template_filetypes }),
        diagnostics.djlint.with({ filetypes = template_filetypes }),
      },
    })

    local prefer_null_ls = {
      lua = true,
      javascript = true,
      javascriptreact = true,
      ["javascript.jsx"] = true,
      typescript = true,
      typescriptreact = true,
      ["typescript.tsx"] = true,
      css = true,
      scss = true,
      less = true,
      html = true,
      htmlangular = true,
      python = true,
      django = true,
      htmldjango = true,
      jinja = true,
      ["jinja.html"] = true,
    }

    local function format_buffer()
      local bufnr = vim.api.nvim_get_current_buf()
      local ft = vim.bo[bufnr].filetype
      local has_null_ls = #vim.lsp.get_clients({ bufnr = bufnr, name = "null-ls" }) > 0

      if prefer_null_ls[ft] and has_null_ls then
        vim.lsp.buf.format({
          async = true,
          filter = function(client)
            return client.name == "null-ls"
          end,
        })
        return
      end

      vim.lsp.buf.format({ async = true })
    end

    vim.keymap.set("n", "<leader>gf", format_buffer, { desc = "Format buffer" })
  end,
}
