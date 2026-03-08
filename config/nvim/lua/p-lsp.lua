return {
	"neovim/nvim-lspconfig",
	dependencies = "WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		local lspconfig = vim.lsp.config
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("lua_ls", { capabilities = capabilities })
		vim.lsp.config("qmlls", { capabilities = capabilities })
		vim.lsp.config("clangd", { capabilities = capabilities })
		vim.lsp.config("pyright", { capabilities = capabilities })
		vim.lsp.config("bashls", { capabilities = capabilities })
		vim.lsp.config("ts_ls", { capabilities = capabilities })
		vim.lsp.config("cssls", { capabilities = capabilities })
	end,
}
