local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = ","

keymap("n", "<leader><leader>", ":Files<cr>", opts)
keymap("n", "<leader><Enter>", ":Buffers<cr>", opts)
keymap("n", "<leader>w", ":Windows<cr>", opts)
keymap("n", "<leader>c", ":BCommits<cr>", opts)
keymap("n", "<leader>r", ":Rg<space>", opts)
keymap("n", "<C-t>", ":NERDTreeToggle<cr>", opts)
keymap("n", "<leader>x", ":registers<cr>", opts)
keymap("n", "<leader>t", ":terminal<cr>", opts)
keymap("n", "<C-l>", ":nohlsearch<cr><C-l>", opts)
keymap("n", "<S-y>", "\"+y<cr>", opts)

-- Move selected chunk up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
