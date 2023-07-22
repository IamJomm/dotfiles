require("nvim-tree").setup({
	sort_by = "case_sensitive",
	actions = {
		open_file = {quit_on_open = true},
	}
})

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<cr>')
