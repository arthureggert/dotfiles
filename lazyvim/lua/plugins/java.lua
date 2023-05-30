local function get_system()
  local SYSTEM = "linux"
  if vim.fn.has("mac") == 1 then
    SYSTEM = "mac"
  end
  return SYSTEM
end

local function get_jdtls()
  local system = get_system()
  local mason_registry = require("mason-registry")
  local jdtls = mason_registry.get_package("jdtls")
  local jdtls_path = jdtls:get_install_path()
  local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local config = jdtls_path .. "/config_" .. system
  local lombok = jdtls_path .. "/lombok.jar"

  return launcher, config, lombok
end

local function get_bundles()
  local mason_registry = require("mason-registry")
  local java_debug = mason_registry.get_package("java-debug-adapter")
  local java_test = mason_registry.get_package("java-test")
  local java_debug_path = java_debug:get_install_path()
  local java_test_path = java_test:get_install_path()
  local bundles = {}

  vim.list_extend(
    bundles,
    vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
  )

  vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))

  return bundles
end

local function get_workspace()
  local home = os.getenv("HOME")
  local workspace_path = home .. "/Documents/workspaces"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = workspace_path .. project_name
  return workspace_dir
end

local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local function setup()
  -- Autocmd
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      local jdtls = require("jdtls")
      local capabilities = get_capabilities()
      local extendedClientCapabilities = jdtls.extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

      local launcher, os_config, lombok = get_jdtls()
      local workspace_dir = get_workspace()
      -- local bundles = get_bundles()

      require("lazyvim.util").on_attach(function(_, bufnr)
        --   -- vim.lsp.codelens.refresh()
        --   -- jdtls.setup_dap({ hotcodereplace = "auto" })
        --   -- require("jdtls.dap").setup_dap_main_class_configs()
        require("jdtls.setup").add_commands()
        --
        --   local map = function(mode, lhs, rhs, desc)
        --     if desc then
        --       desc = desc
        --     end
        --     vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
        --   end
        --
        --   -- Register keymappings
        --
        --   map("n", "<leader>jo", jdtls.organize_imports, "Organize Imports")
        --   map("n", "<leader>jv", jdtls.extract_variable, "Extract Variable")
        --   map("n", "<leader>jc", jdtls.extract_constant, "Extract Constant")
        --   map("n", "<leader>jt", jdtls.test_nearest_method, "Test Nearest Method")
        --   map("n", "<leader>jT", jdtls.test_class, "Test Class")
        --   map("n", "<leader>ju", "<cmd>JdtUpdateConfig<cr>", "Update Config")
        --   map("v", "<leader>jv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable")
        --   map("v", "<leader>jc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant")
        --   map("v", "<leader>jm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method")
        --
        --   -- vim.api.nvim_create_autocmd("BufWritePost", {
        --   --   pattern = { "*.java" },
        --   --   callback = function()
        --   --     local _, _ = pcall(vim.lsp.codelens.refresh)
        --   --   end,
        --   -- })
      end)

      local config = {
        cmd = {
          "java",
          "-javaagent:" .. lombok,
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",

          "-jar",
          launcher,

          "-configuration",
          os_config,

          "-data",
          workspace_dir,
        },
        root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
        capabilities = capabilities,

        settings = {
          java = {
            home = "/Users/aheggert/.sdkman/candidates/java/17.0.2-open",
            autobuild = { enabled = false },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            saveActions = {
              organizeImports = true,
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              hashCodeEquals = {
                useJava7Objects = true,
              },
              useBlocks = true,
            },
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                name = "JavaSE-11",
                path = "/Users/aheggert/.sdkman/candidates/java/11.0.15-zulu/",
              },
              {
                name = "JavaSE-17",
                path = "/Users/aheggert/.sdkman/candidates/java/17.0.2-open/",
              },
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = "all", -- literals, all, none
              },
            },
            format = {
              enabled = false,
            },
          },
        },
        init_options = {
          -- bundles = bundles,
          extendedClientCapabilities = extendedClientCapabilities,
        },
        handlers = {},
      }

      jdtls.start_or_attach(config)
    end,
  })
end

return {
  "mfussenegger/nvim-jdtls",
  dependencies = { "mfussenegger/nvim-dap", "neovim/nvim-lspconfig" },
  event = "VeryLazy",
  config = function()
    setup()
  end,
}
