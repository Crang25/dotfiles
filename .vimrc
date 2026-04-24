set nocompatible

filetype plugin indent on
syntax on

set number
set relativenumber
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent
set wrap
set cursorline
set ignorecase
set smartcase
set hlsearch
set incsearch
set wildmenu
set wildmode=longest:full,full

if has('clipboard')
  set clipboard=unnamedplus
endif

if exists('+termguicolors')
  set termguicolors
endif

let mapleader = ' '
let maplocalleader = ' '

nnoremap <silent> <C-s> :update<CR>
inoremap jk <Esc>
nnoremap <silent> <leader>h :nohlsearch<CR>

nnoremap <silent> <C-Up> :resize -2<CR>
nnoremap <silent> <C-Down> :resize +2<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

nnoremap <silent> <leader>tn :tabnew<CR>
nnoremap <silent> <leader>tx :tabclose<CR>
nnoremap <silent> <leader>to :tabonly<CR>
nnoremap <silent> <leader>tl :tabnext<CR>
nnoremap <silent> <leader>th :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabprevious<CR>

nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprev<CR>

nnoremap <silent> <S-l> :bnext<CR>
nnoremap <silent> <S-h> :bprevious<CR>
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

augroup user_filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.inc setfiletype asm
  autocmd BufRead,BufNewFile *.jinja,*.jinja2,*.j2,*.njk setfiletype jinja
  autocmd BufRead,BufNewFile */templates/*.html setfiletype htmldjango
augroup END
