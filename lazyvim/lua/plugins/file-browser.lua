-- telescope-file-browser.nvim is a file browser extension for telescope.nvim.
-- It supports synchronized creation, deletion, renaming, and moving of files and folders.
-- Its powered by telescope.nvim and plenary.nvim.

return {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = {
    {
      "<leader>sB",
      ":Telescope file_browser path=%:p:h=%p:h<CR>",
      desc = "Browse Files",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
