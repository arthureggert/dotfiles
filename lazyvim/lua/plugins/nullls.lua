return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      debug = true,
      sources = {
        require("typescript.extensions.null-ls.code-actions"),
        nls.builtins.diagnostics.fish,
        nls.builtins.diagnostics.flake8,

        nls.builtins.formatting.fish_indent,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
        nls.builtins.formatting.isort,
        nls.builtins.formatting.clang_format,
        -- nls.builtins.formatting.astyle,
        -- nls.builtins.formatting.npm_groovy_lint,
        -- nls.builtins.formatting.google_java_format,
      },
    }
  end,
}
