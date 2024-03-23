require("base")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("p-mason"),
    require("p-lsp"),
    require("p-null-ls"),
    require("p-treesitter"),
    require("p-cmp"),
    require("p-trouble"),
    require("p-dap"),
    require("p-telescope"),
    require("p-noice"),
    require("p-tree"),
    require("text"),
    require("p-which-key"),
    require("p-lazygit"),
    require("color"),
    require("p-lualine"),
    require("p-alpha"),
})
