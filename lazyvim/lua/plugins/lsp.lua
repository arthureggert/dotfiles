return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.grammarly.setup({
      on_attach = function(client, bufnr)
        require("lsp").on_attach(client, bufnr)
      end,
      init_options = { clientId = "client_BaDkMgx4X19X9UxxYRCXZo" },
      filetypes = { "tex", "markdown", "txt", "text" },
    })
  end,
}
