vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set("n", "<c-e>", "<cmd>NvimTreeToggle<cr>")

local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-L>", function()
    ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
    ls.jump(-1)
end, { silent = true })

local trouble = require("trouble")
local builtin = require("telescope.builtin")
local dapui = require("dapui")
return {
    w = { "<cmd>w<cr>", "Save File" },
    q = { "<cmd>q<cr>", "Quit" },
    f = {
        name = "File",
        f = { builtin.find_files, "Find File" },
        g = { builtin.live_grep, "Live Grep" },
        o = { builtin.oldfiles, "Old Files" },
    },
    l = {
        g = { "<cmd>LazyGit<cr>", "Open LazyGit" },
    },
    t = {
        name = "Trouble",
        t = {
            function()
                trouble.toggle("document_diagnostics")
            end,
            "Document Diagnostics",
        },
        w = {
            function()
                trouble.toggle("workspace_diagnostics")
            end,
            "Workspace Diagnostics",
        },
        q = {
            function()
                trouble.toggle("quickfix")
            end,
            "Quick Fix",
        },
    },
    d = {
        name = "Dap",
        t = {
            function()
                dapui.toggle()
            end,
            "Toggle UI",
        },
        b = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
        c = { "<cmd>DapContinue<cr>", "Continue" },
        r = {
            function()
                dapui.open({ reset = true })
            end,
            "Reset UI",
        },
    },
}
