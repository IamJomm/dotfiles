require("base")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("p-mason"),
	require("p-lsp"),
	require("p-debug"),
	require("p-visual"),
	require("p-text"),
	require("p-utils"),
	require("p-maps"),
})
