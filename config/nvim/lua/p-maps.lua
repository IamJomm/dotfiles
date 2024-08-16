return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.g.mapleader = " "
		vim.g.maplocalleader = " "

		vim.keymap.set("n", "<c-e>", "<cmd>NvimTreeToggle<cr>")

		local ls = require("luasnip")
		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-J>", function()
			ls.jump(-1)
		end, { silent = true })

		local builtin = require("telescope.builtin")
		local dapui = require("dapui")
		require("which-key").add({
			{ "<leader>w", "<cmd>w<cr>", desc = "Save File" },
			{ "<leader>q", "<cmd>q<cr>", desc = "Quit" },
			{ "<leader>f", group = "File" },
			{ "<leader>ff", builtin.find_files, desc = "Find File" },
			{ "<leader>fg", builtin.live_grep, desc = "Live Grep" },
			{ "<leader>fo", builtin.oldfiles, desc = "Old Files" },
			{ "<leader>g", group = "Git" },
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diff View" },
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
			{ "<leader>t", group = "Trouble" },
			{
				"<leader>tt",
				"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
				desc = "Diagnostics",
			},
			{
				"<leader>tw",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>tq",
				"<cmd>Trouble qflist toggle focus=true<cr>",
				desc = "Quick Fix",
			},
			{ "<leader>d", group = "Dap" },
			{
				"<leader>dt",
				function()
					dapui.toggle()
				end,
				desc = "Toggle UI",
			},
			{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
			{ "<leader>ds", "<cmd>DapStepOver<cr>", desc = "Step Over" },
			{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
			{ "<leader>do", "<cmd>DapStepOut<cr>", desc = "Step Out" },
			{ "<leader>dq", "<cmd>DapTerminate<cr>", desc = "Terminate" },
			{
				"<leader>dr",
				function()
					dapui.open({ reset = true })
				end,
				desc = "Reset UI",
			},
		})
	end,
}
