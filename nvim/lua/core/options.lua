-- General settings

local opt = vim.opt

opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- System clipboard integration
opt.tabstop = 2 -- Tab width (in spaces)
opt.shiftwidth = 2 -- Auto-indent width
opt.softtabstop = 2
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Automatically indent code
opt.wrap = true -- Enable line wrapping
opt.cursorline = true -- Highlight the current line
opt.smartcase = true -- use smart search. h smartcase for more info
opt.ignorecase = true
opt.termguicolors = true

vim.filetype.add({
  extension = {
    inc = "asm",
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
    njk = "jinja",
  },
  pattern = {
    [".*%.component%.html"] = "htmlangular",
    [".*%.directive%.html"] = "htmlangular",
    [".*%.pipe%.html"] = "htmlangular",
    [".*/templates/.*%.html"] = "htmldjango",
  },
})
