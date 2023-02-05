local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = ","

keymap("n", "<leader><leader>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader><Enter>", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>r", ":Telescope live_grep<cr>", opts)

keymap("n", "<leader>gs", ":G<cr>", opts)

keymap("n", "<leader>x", ":registers<cr>", opts)

keymap("n", "<C-l>", ":nohlsearch<cr><C-l>", opts)
