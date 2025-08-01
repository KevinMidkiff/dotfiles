local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex 20<cr>", opts)

keymap("n", "<leader>l", ":ls<cr>", opts)
keymap("n", "<leader>,", ":nohlsearch<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Insert --

-- Visual --

-- Terminal --

-- Telescope --
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>ff",
  "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
  opts)
keymap("n", "<leader>tt", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb",
  "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
  opts)

keymap("n", "<leader>vs", '<cmd>VenvSelect<cr>', opts)

-- LSP --
keymap("n", "<leader>ls", "<cmd>LspStop<cr>", opts)
keymap("n", "<leader>ll", "<cmd>LspStart<cr>", opts)

-- DiffOpen
keymap("n", "<leader>do", "<cmd>DiffviewOpen<cr>", opts)
keymap("n", "<leader>dc", "<cmd>DiffviewClose<cr>", opts)
