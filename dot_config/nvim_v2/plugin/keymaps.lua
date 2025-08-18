local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader=","
vim.g.maplocalleader=","

keymap("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')
