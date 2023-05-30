return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      jdtls = function(_, _)
        -- this will disable LazyVim from setting up jdtls automatically
        return true
      end,
    },
  },
}
