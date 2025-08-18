-- ~/.config/nvim-new/plugin/plugins.lua
vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
}, { load = true })

require('gitsigns').setup({ signcolumn = false })
require("mason").setup({ })
