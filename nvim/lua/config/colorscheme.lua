vim.o.background = "dark" -- or "light" for light mode

vim.g.gruvbox_material_background = "soft"
vim.cmd([[colorscheme gruvbox-material]])

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

local function set_git_preview_highlights()
  -- Improve contrast for Gitsigns preview popup content.
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#d4be98", bg = "#282828" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7c6f64", bg = "#282828" })
  vim.api.nvim_set_hl(0, "GitSignsAddPreview", { fg = "#a9b665", bg = "#2f3b2f" })
  vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { fg = "#ea6962", bg = "#3c2a2a" })
  vim.api.nvim_set_hl(0, "GitSignsNoEOLPreview", { fg = "#ea6962", bg = "#3c2a2a" })
end

set_git_preview_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_git_preview_hl", { clear = true }),
  callback = set_git_preview_highlights,
})
