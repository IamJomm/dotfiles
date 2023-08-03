vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
keymap.set("n", "<leader>dr", "<cmd>DapContinue<cr>")
keymap.set("n", "<leader>ds", function()
	require("dap").step_over()
end)
