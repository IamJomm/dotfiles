require("mason").setup()
require("mason-lspconfig").setup({
    insure_installed = {
		"lua_ls"
    },
    automatic_installation = true,
    handlers = nil,
})
