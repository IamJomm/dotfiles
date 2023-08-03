local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"nvim-treesitter/nvim-treesitter",
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"BurntSushi/ripgrep",
		},
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	"rmagatti/alternate-toggler",
	"windwp/nvim-autopairs",
	"mg979/vim-visual-multi",
	"gcmt/wildfire.vim",
	"tpope/vim-surround",

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("p-alpha").config
		end,
	},
})
