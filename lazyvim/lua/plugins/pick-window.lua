return {
  "s1n7ax/nvim-window-picker",
  opts = {},
  config = function(_, opts)
    require("window-picker").setup(opts)
  end,
}
