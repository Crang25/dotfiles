return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
        default_integrations = true,
			})
		end,
	},
}
