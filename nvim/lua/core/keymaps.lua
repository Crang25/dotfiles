local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<C-s>", ":w<CR>", opts) -- save with ctrl+s
map("i", "jk", "<Esc>", opts) -- Escape from insert mode quickly
map("n", "<leader>h", ":noh<CR>", opts)

-- setting split resize maps
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

map("t", "<leader>cl", '<C-\\><C-n>:lua require("toggleterm").exec("clear")<CR>', { noremap = true, silent = true })
