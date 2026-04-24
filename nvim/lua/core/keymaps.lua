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

map("t", "<leader>tc", '<C-\\><C-n>:lua require("toggleterm").exec("clear")<CR>', { noremap = true, silent = true })

-- Tabs
map("n", "<leader>tn", ":tabnew<CR>", opts)
map("n", "<leader>tx", ":tabclose<CR>", opts)
map("n", "<leader>to", ":tabonly<CR>", opts)
map("n", "<leader>tl", ":tabnext<CR>", opts)
map("n", "<leader>th", ":tabprevious<CR>", opts)
map("n", "]t", ":tabnext<CR>", opts)
map("n", "[t", ":tabprevious<CR>", opts)

-- Quickfix and location list
map("n", "]q", ":cnext<CR>", opts)
map("n", "[q", ":cprev<CR>", opts)
map("n", "]l", ":lnext<CR>", opts)
map("n", "[l", ":lprev<CR>", opts)

-- Buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bp", ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)
