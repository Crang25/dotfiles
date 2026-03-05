-- color theme
return {
  "ellisonleao/gruvbox.nvim",
  lazy = true,
  terminal_colors = true, -- add neovim terminal colors
  config = function()
    -- Optionally configure and load the colorscheme
    -- directly inside the plugin declaration.
    -- vim.cmd.colorscheme('gruvbox-material')
  end,
}
