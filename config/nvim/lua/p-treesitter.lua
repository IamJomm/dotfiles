return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "cpp", "python", "bash" },
            auto_install = true,
            highlight = {
                enable = true,
            },
        })
    end,
}
