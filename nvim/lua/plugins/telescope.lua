return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope_utils = require("utils.telescope_helpers")

			local state = require("telescope.state")
			local action_state = require("telescope.actions.state")

			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					mappings = {
						n = {
							-- setting maps for scrolling in preview window
							["<C-e>"] = function(bufnr)
								telescope_utils.slow_scroll(action_state, state, bufnr, 1)
							end,
							["<C-y>"] = function(bufnr)
								telescope_utils.slow_scroll(action_state, state, bufnr, -1)
							end,
						},
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
			--Lists open buffers in current neovim instance, opens selected buffer on
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})

			-- show line numbers in previewk
			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopePreviewerLoaded",
				callback = function()
					-- Your custom logic when the Telescope previewer is loaded
					vim.opt_local.number = true
				end,
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
