return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    print(opts.ensure_installed)
    vim.list_extend(opts.ensure_installed, { "prettierd" })
  end,
  dependencies = { "nvim-neotest/nvim-nio" },
}
