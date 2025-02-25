-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here

vim.keymap.set("x", "<S-Up>", ":m-2<CR>gv=gv", {
  noremap = true,
  silent = true,
})

vim.keymap.set("x", "<S-Down>", ":m'>+<CR>gv=gv", {
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<S-Up>", ":<C-u>move-2<CR>==", {
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<S-Down>", ":<C-u>move+<CR>==", {
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<S-Left>", ":bp<CR>", { silent = true })
vim.keymap.set("n", "<S-Right>", ":bn<CR>", { silent = true })

vim.keymap.set("i", "<C-g>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
vim.keymap.set("n", "<C-g>", "[s1z=<c-o>")

vim.keymap.set("n", "-", require("oil").open, {
  desc = "Open parent directory",
})

vim.keymap.set("n", "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file", silent = true })
vim.keymap.set("i", "<D-s>", "<esc><cmd>w<cr><esc>a", { desc = "Save file", silent = true })

vim.keymap.set("n", "<D-w>", "<cmd>:bd<cr><esc>", { desc = "Close Buffer" })
vim.keymap.set("n", "<D-q>", "<cmd>qa<cr><esc>", { desc = "Close Neovide" })

vim.keymap.set("i", "<D-v>", '<esc>"+p<esc>A', { desc = "Paste" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste" })
