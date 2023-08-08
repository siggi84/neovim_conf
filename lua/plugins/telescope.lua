return {
    {
        'nvim-telescope/telescope.nvim',
        branch = 'master',
        dependencies = { 'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
        },
        config = function()
            require('telescope').setup()
        end
    }
}
