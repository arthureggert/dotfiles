return {
  "jghauser/follow-md-links.nvim",
  init = function()
    vim.keymap.set("n", "<bs>", ":edit #<cr>", { silent = true })
  end,
}
