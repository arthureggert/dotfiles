return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(
      opts.ensure_installed,
      { "prettierd", "jdtls", "java-debug-adapter", "java-test", "google-java-format" }
    )
  end,
}
