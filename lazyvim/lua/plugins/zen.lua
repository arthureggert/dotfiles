return {
  --"folke/zen-mode.nvim",
  "Pocco81/true-zen.nvim",
  opts = {
    modes = {
      ataraxis = {
        callbacks = {
          open_pre = function()
            require("lualine").hide({ unhide = false })
            vim.opt.statuscolumn = ""
          end,
          close_pos = function()
            require("lualine").hide({ unhide = true })
            vim.opt.statuscolumn = "%@SignCb@%s%=%T%@NumCb@%l %r│%T"
          end,
        },
      },
    },
    integrations = {
      twilight = true,
    },
  },
  dependencies = {
    "folke/twilight.nvim",
  },
}
