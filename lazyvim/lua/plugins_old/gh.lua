-- gh.nvim, initially, is a plugin for interactive code reviews which take place on the GitHub platform.

return {
  "ldelossa/gh.nvim",
  config = function()
    require("litee.gh").setup()
  end,
  dependencies = {
    "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup()
    end,
  },
}
