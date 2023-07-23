vim.keymap.set("n", "<leader>ta", "<cmd>ToggleAlternate<cr>")

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})
