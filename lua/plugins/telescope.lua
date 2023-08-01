return {
    {
        'nvim-telescope/telescope.nvim',
        branch = 'master',
        dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep', 'nvim-telescope/telescope-fzf-native.nvim' },
        config = function()
            require('telescope').setup()
            require('telescope').load_extension('fzf')
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
}
