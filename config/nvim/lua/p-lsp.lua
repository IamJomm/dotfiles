return {
	"neovim/nvim-lspconfig",
	dependencies = "WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		lspconfig.lua_ls.setup({ capabilities = capabilities })
		lspconfig.clangd.setup({ capabilities = capabilities })
		lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.bashls.setup({ capabilities = capabilities })
		lspconfig.ts_ls.setup({ capabilities = capabilities })
		lspconfig.cssls.setup({ capabilities = capabilities })
	end,
}
