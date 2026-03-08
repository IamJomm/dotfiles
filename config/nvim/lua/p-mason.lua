return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"lua-language-server",
					"clangd",
					"pyright",
					"bash-language-server",
					"typescript-language-server",
					"css-lsp",
					"qmlls",
					--
					"stylua",
					"clang-format",
					"black",
					"beautysh",
					"prettier",
					--
					"debugpy",
				},
			})
		end,
	},
}
