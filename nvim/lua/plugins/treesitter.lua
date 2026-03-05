return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "angular", "scss" })
      end
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.component.html", "*.container.html" },
        callback = function()
          vim.treesitter.start(nil, "angular")
        end,
      })
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				-- disable = {
				-- 	"html",
    --       "tsx",
    --       "jsx"
				-- },
				--ensure_installed = {
				--"bash",
				--"c",
				--"css",
				--"diff",
				--"go",
				--"html",
				--"javascript",
				--"jsdoc",
				--"json",
				--"jsonc",
				--"lua",
				--"luadoc",
				--"luap",
				--"markdown",
				--"markdown_inline",
				--"printf",
				--"python",
				--"query",
				--"regex",
				--"rust",
				--"toml",
				--"tsx",
				--"typescript",
				--"vim",
				--"vimdoc",
				--"xml",
				--"yaml",
				--},
			})
		end,
	},
}
