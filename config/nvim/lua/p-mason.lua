return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "pyright", "bashls" },
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "stylua", "clang-format", "black", "beautysh" },
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "python" },
			})
		end,
	},
}
