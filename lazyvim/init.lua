-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").typos_lsp.setup({
  init_options = {
    config = "~/Documents/dotfiles/lazyvim/spell/.typos.toml",
  },
})
