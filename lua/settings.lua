HOME = os.getenv("HOME")

-- Remap leader key
vim.keymap.set("n", "<SPACE>", "<Nop>", { desc = "", remap = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use undofile
vim.o.undofile = true
vim.o.undodir = HOME .. '/.vim/tmp/undo//' -- undo files

-- Line numbers
vim.o.wildmenu = true
vim.o.relativenumber = true

vim.o.spelllang = 'en_us'

vim.o.ignorecase = true
vim.o.smartcase = true

-- Tab and indent configuration
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.mouse = 'a'

-- Set highlight on search
vim.o.hlsearch = false

-- Enable break indent
vim.o.breakindent = true
vim.opt.breakindentopt = { 'shift:2', 'sbr' }
--vim.opt.breakat = ' \t;:,!?'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Show spaces, trailing spaces and such
vim.o.list = true
vim.opt.listchars = {
    tab = '│·',
    extends = '›',
    precedes = '‹',
    trail = '·'
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'


-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
