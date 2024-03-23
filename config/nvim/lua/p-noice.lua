return {
    {
        "rcarriga/nvim-notify",
        opts = {
            timeout = 5000,
            background_colour = "#000000",
            render = "wrapped-compact",
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup()
        end,
    },
}
