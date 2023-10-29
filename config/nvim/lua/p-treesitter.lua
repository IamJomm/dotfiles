require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "cpp", "lua", "python" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})
