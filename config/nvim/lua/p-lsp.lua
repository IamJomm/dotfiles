local lspconfig = require("lspconfig")
-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
})
lspconfig["clangd"].setup({
	capabilities = capabilities,
})
lspconfig["pyright"].setup({
	capabilities = capabilities,
})
