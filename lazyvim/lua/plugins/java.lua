return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local path = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
    local config = {
      cmd = { path },
      root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
    }
    require("jdtls").start_or_attach(config)
  end,
}
