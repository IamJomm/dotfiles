local opt = vim.opt

opt.number = true
opt.cursorline = true

opt.clipboard:append("unnamedplus")

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utd-8"

opt.mouse = "a"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
