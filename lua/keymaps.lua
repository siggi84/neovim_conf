-- Move to window using the <alt> mnei keys
vim.keymap.set("n", "<A-m>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<A-n>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<A-e>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<A-i>", "<C-w>l", { desc = "Go to right window", remap = true })

vim.keymap.set("i", "<A-m>", "<Esc><C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("i", "<A-n>", "<Esc><C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("i", "<A-e>", "<Esc><C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("i", "<A-i>", "<Esc><C-w>l", { desc = "Go to right window", remap = true })

vim.keymap.set("t", "<A-m>", "<c-\\><c-n><c-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("t", "<A-n>", "<c-\\><c-n><c-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("t", "<A-e>", "<c-\\><c-n><c-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("t", "<A-i>", "<c-\\><c-n><c-w>l", { desc = "Go to right window", remap = true })
vim.keymap.set(
    "t",
    "<A-x>",
    vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
    { desc = "Go to right window", remap = true }
)
vim.keymap.set("n", "<C-w>M", "<C-w>H", { desc = "Move current window to the far left", remap = true })
vim.keymap.set("n", "<C-w>N", "<C-w>J", { desc = "Move current window to the bottom", remap = true })
vim.keymap.set("n", "<C-w>E", "<C-w>K", { desc = "Move current window to the top", remap = true })
vim.keymap.set("n", "<C-w>I", "<C-w>L", { desc = "Move current window to the far right", remap = true })

vim.keymap.set("n", "<A-Left>", "<Cmd>vertical resize -2<cr>", { desc = "Decrease window width", remap = true })
vim.keymap.set("n", "<A-Down>", "<Cmd>resize -2<cr>", { desc = "Decrease window height", remap = true })
vim.keymap.set("n", "<A-Up>", "<Cmd>resize +2<cr>", { desc = "Increase window height", remap = true })
vim.keymap.set("n", "<A-Right>", "<Cmd>vertical resize +2<cr>", { desc = "Increase window width", remap = true })

vim.keymap.set("n", "[t", ":tabprevious<cr>", { desc = "Go to previous tab", remap = true })
vim.keymap.set("n", "]t", ":tabnext<cr>", { desc = "Go to next tab", remap = true })
vim.keymap.set("n", "]T", ":tablast<cr>", { desc = "Go to last tab", remap = true })
vim.keymap.set("n", "[T", ":tabfirst<cr>", { desc = "Go to first tab", remap = true })

vim.keymap.set("n", "[b", ":bprevious<cr>", { desc = "Go to previous buffer", remap = true })
vim.keymap.set("n", "]b", ":bnext<cr>", { desc = "Go to next buffer", remap = true })
vim.keymap.set("n", "]B", ":blast<cr>", { desc = "Go to last buffer", remap = true })
vim.keymap.set("n", "[B", ":bfirst<cr>", { desc = "Go to first buffer", remap = true })

vim.keymap.set("n", "[a", ":previous<cr>", { desc = "Go to previous arg list item", remap = true })
vim.keymap.set("n", "]a", ":next<cr>", { desc = "Go to next arg list item", remap = true })
vim.keymap.set("n", "]A", ":last<cr>", { desc = "Go to last arg list item", remap = true })
vim.keymap.set("n", "[A", ":first<cr>", { desc = "Go to first arg list item", remap = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fv', builtin.git_files, { desc = 'Search VC' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'LSP References' })
-- vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'LSP References' })
vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Treesitter' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>fz', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Make nvim-treesitter-textobjects repeatable
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
