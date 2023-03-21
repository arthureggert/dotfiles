return {
  "iamcco/markdown-preview.nvim",
  config = function()
    local wk = require("which-key")
    vim.fn["mkdp#util#install"]()
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_auto_refresh = 1
    vim.g.mkdp_theme = "light"
    wk.register({
      ["<leader>m"] = { name = "+markdown" },
    })
    vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
  end,
}
