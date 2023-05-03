return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      setup = {
        jdtls = function(_, _)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              require("lazyvim.util").on_attach(function(_, buffer)
                vim.keymap.set(
                  "n",
                  "<leader>di",
                  "<Cmd>lua require'jdtls'.organize_imports()<CR>",
                  { buffer = buffer, desc = "Organize Imports" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>dt",
                  "<Cmd>lua require'jdtls'.test_class()<CR>",
                  { buffer = buffer, desc = "Test Class" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>dn",
                  "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
                  { buffer = buffer, desc = "Test Nearest Method" }
                )
                vim.keymap.set(
                  "v",
                  "<leader>de",
                  "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
                  { buffer = buffer, desc = "Extract Variable" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>de",
                  "<Cmd>lua require('jdtls').extract_variable()<CR>",
                  { buffer = buffer, desc = "Extract Variable" }
                )
                vim.keymap.set(
                  "v",
                  "<leader>dm",
                  "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                  { buffer = buffer, desc = "Extract Method" }
                )
                vim.keymap.set(
                  "n",
                  "<leader>jf",
                  "<cmd>lua vim.lsp.buf.formatting()<CR>",
                  { buffer = buffer, desc = "Format" }
                )
              end)

              local home = os.getenv("HOME")

              local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()

              local path_to_config = jdtls_path .. "/config_mac"
              local path_to_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
              local lombok_path = jdtls_path .. "/lombok.jar"

              local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

              local root_dir = require("jdtls.setup").find_root(root_markers)

              local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

              -- local workspace_folder = "/tmp/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

              local config = {
                cmd = {

                  "java", -- or '/path/to/java17_or_newer/bin/java'

                  "-javaagent:" .. lombok_path,
                  -- '-Xbootclasspath/a:/home/jake/.local/share/java/lombok.jar',
                  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                  "-Dosgi.bundles.defaultStartLevel=4",
                  "-Declipse.product=org.eclipse.jdt.ls.core.product",
                  "-Dlog.protocol=true",
                  "-Dlog.level=ALL",
                  -- '-noverify',
                  "-Xms1g",
                  "--add-modules=ALL-SYSTEM",
                  "--add-opens",
                  "java.base/java.util=ALL-UNNAMED",
                  "--add-opens",
                  "java.base/java.lang=ALL-UNNAMED",
                  "-jar",
                  path_to_jar,

                  "-configuration",
                  path_to_config,

                  "-data",
                  workspace_folder,
                },

                root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

                settings = {
                  java = {
                    home = "/Users/aheggert/.sdkman/candidates/java/17.0.2-open",
                    eclipse = {
                      downloadSources = true,
                    },
                    configuration = {
                      updateBuildConfiguration = "interactive",
                      runtimes = {
                        {
                          name = "JavaSE-11",
                          path = "/Users/aheggert/.sdkman/candidates/java/11.0.15-zulu/",
                        },
                        {
                          name = "JavaSE-17",
                          path = "/Users/aheggert/.sdkman/candidates/java/17.0.2-open/",
                        },
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
                    format = {
                      enabled = true,
                      settings = {
                        url = vim.fn.stdpath("config") .. "/formats/aheggert.xml",
                        profile = "aheggert",
                      },
                    },
                  },
                  signatureHelp = { enabled = true },
                  completion = {
                    favoriteStaticMembers = {
                      "org.hamcrest.MatcherAssert.assertThat",
                      "org.hamcrest.Matchers.*",
                      "org.hamcrest.CoreMatchers.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "java.util.Objects.requireNonNull",
                      "java.util.Objects.requireNonNullElse",
                      "org.mockito.Mockito.*",
                    },
                    importOrder = {
                      "java",
                      "javax",
                      "com",
                      "org",
                    },
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
                    useBlocks = true,
                  },
                },

                handlers = {
                  ["language/status"] = function(_, result)
                    -- print(result)
                  end,
                  ["$/progress"] = function(_, result, ctx)
                    -- disable progress updates.
                  end,
                },
              }
              -- require("notify")("jdtls is starting", "info", {})
              require("jdtls").start_or_attach(config)
              -- require("notify")("jdtls started", "info", {})
            end,
          })

          vim.bo.shiftwidth = 4
          vim.bo.tabstop = 4

          return true
        end,
      },
    },
  },
}
