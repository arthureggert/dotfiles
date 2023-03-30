return {
  "mickael-menu/zk-nvim",
  config = function()
    require("zk").setup({
      picker = "telescope",
      default_keybindings = true,
      default_notebook_path = "~/Documents/workbench",
    })
  end,
}
