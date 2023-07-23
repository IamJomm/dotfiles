local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {},
	},
})
