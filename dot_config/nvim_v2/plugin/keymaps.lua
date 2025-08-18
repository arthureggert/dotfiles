local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end


vim.g.mapleader = ","
vim.g.maplocalleader = ","

map("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')

--save
map("n", "<D-s>", "<cmd>w<cr><esc>")
map("i", "<D-s>", "<esc><cmd>w<cr><esc>a")

--Snacks
local Snacks = require("snacks")
map("n", "<Leader>e", function() Snacks.explorer() end)
map("n", "<Leader>fb", function() Snacks.picker.buffers() end)
map("n", "<Leader>ff", function() Snacks.picker.files() end)
map("n", "<Leader>fr", function() Snacks.picker.recent() end)

--Snacks LSP
map("n", "gd", function() Snacks.picker.lsp_definitions() end)
map("n", "gD", function() Snacks.picker.lsp_declarations() end)
map("n", "gr", function() Snacks.picker.lsp_references() end)
map("n", "gI", function() Snacks.picker.lsp_implementations() end)
map("n", "gY", function() Snacks.picker.lsp_type_definitions() end)

map("n", "<leader>bd", function() Snacks.bufdelete() end)
