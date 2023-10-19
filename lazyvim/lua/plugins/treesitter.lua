return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  opts = function(_, opts)
    opts.ignore_install = { "help" }

    vim.list_extend(opts.ensure_installed, {
      "json",
      "json5",
      "jsonc",
      "typescript",
      "tsx",
      "bash",
      "help",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "vim",
      "yaml",
    })
  end,
}
