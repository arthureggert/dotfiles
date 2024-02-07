return {
  "s1n7ax/nvim-window-picker",
  opts = {},
  event = "VeryLazy",
  version = "2.*",
  config = function(_, opts)
    require("window-picker").setup(opts)
  end,
}
