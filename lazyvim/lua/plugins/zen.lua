return {
  --"folke/zen-mode.nvim",
  "Pocco81/true-zen.nvim",
  config = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>z"] = { name = "+zenmode" },
    })
    --vim.keymap.set("n", "<leader>zt", ":ZenMode<CR>", { desc = "Toggle ZenMode" })
    vim.keymap.set("n", "<leader>zt", ":TZAtaraxis<CR>", { desc = "Toggle ZenMode" })

    require("true-zen").setup({
      modes = {
        ataraxis = {
          callbacks = {
            open_pre = function()
              require("lualine").hide({ unhide = false })
            end,
            close_pos = function()
              require("lualine").hide({ unhide = true })
            end,
          },
        },
      },
      integrations = {
        twilight = true,
      },
    })
  end,
  dependencies = {
    "folke/twilight.nvim",
  },
}
