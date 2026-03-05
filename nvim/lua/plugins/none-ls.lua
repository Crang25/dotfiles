return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,
				-- typescript/javascript
				null_ls.builtins.formatting.prettier,
				-- eslint has problems announced here: https://github.com/nvimtools/none-ls.nvim/discussions/81
				--null_ls.builtins.diagnostics.eslint_d,
				require("none-ls.code_actions.eslint_d"),
				-- python
				-- null_ls.builtins.formatting.flake8,
        null_ls.builtins.formatting.black,
        -- optional static type checker
        -- null_ls.builtins.diagnostics.mypy,
        -- An extremely fast Python linter, written in Rust.
				null_ls.builtins.formatting.isort,
				-- null_ls.builtins.formatting.asmfmt,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
