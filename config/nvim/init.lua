local opt = vim.opt
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.g.mapleader = " "

require("plugins")
require("p-mason")
require("p-lsp")
require("p-tree")
require("color")
