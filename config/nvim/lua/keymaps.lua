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

-- Move selected chunk up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Maintain cursor where it is when use J
keymap("n", "J", "mzJ`z", opts)

-- Maintain cursor at the center when using C-d C-u
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Search terms are kept in the middle
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Paste/delete without losing clipboard
keymap("x", "<S-p>", [["_dP]], opts)
keymap("n", "<S-d>", [["_d]], opts)
keymap("v", "<S-d>", [["_d]], opts)

-- Yank to system clipboard
keymap("n", "<S-y>", [["+y]], opts)
keymap("v", "<S-y>", [["+y]], opts)
