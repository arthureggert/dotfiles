return {
  -- "binhtran432k/dracula.nvim",
  --lazy = false,
  --priority = 1000,
  --opts = {},
  { "dracula-pro/vim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd("colorscheme dracula_pro_van_helsing")
      end,
    },
  },
}
