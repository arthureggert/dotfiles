vim.g.mapleader = ","

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<S-Left>", ":bp<CR>")
vim.keymap.set("n", "<S-Right>", ":bn<CR>")
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==")
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==")
vim.keymap.set("n", "<leader>s", "<ESC>:w<CR>")
vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>Q", ":bd!<CR>")
vim.keymap.set("n", "<leader>qq", "<ESC>:NvimTreeClose<CR>:q<CR>")
vim.keymap.set("n", "<leader>U", "<ESC>:u<CR>")
vim.keymap.set("n", "<leader>bh", ":new<CR>")
vim.keymap.set("n", "<leader>bv", ":vnew<CR>")
vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
