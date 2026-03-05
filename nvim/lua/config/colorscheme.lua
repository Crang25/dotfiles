vim.o.background = "dark" -- or "light" for light mode

-- set gruvbox as colorscheme
-- vim.cmd([[colorscheme gruvbox]])

-- set vscode as colorscheme
-- vim.cmd([[colorscheme vscode]])

-- set everforest as colorscheme
-- vim.g.everforest_enable_italic = true
-- vim.g.everforest_transparent_background = 1
-- vim.cmd([[colorscheme everforest]])

-- set gruvbox-material as a colorscheme
vim.g.gruvbox_material_background = "soft"
vim.cmd([[colorscheme gruvbox-material]])

-- set catppuccin as a colorscheme
-- vim.cmd([[colorscheme catppuccin-frappe]])

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
