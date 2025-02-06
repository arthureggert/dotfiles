return {
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim.git",
    lazy = true,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "java" },
    opts = {
      server = {
        cmd = {
          "sonarlint-language-server",
          "-stdio",
          "-analyzers",
          vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjs.jar"),
        },
        settings = {
          sonarlint = {
            test = "test",
          },
        },
      },
      filetypes = {
        "java",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
      },
    },
  },
}
