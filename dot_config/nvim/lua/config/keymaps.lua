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

vim.keymap.set("n", "<leader>wr", "<cmd>w<cr>", { desc = "Save file", silent = true })

vim.keymap.set("i", "<D-v>", '<esc>"+p<esc>A', { desc = "Paste" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste" })

vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
