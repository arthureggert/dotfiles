return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = function(_, opts)
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")
    return {
      files = {
        cwd_prompt = false,
        actions = {
          -- ["ctrl-i"] = { actions.toggle_ignore },
          ["ctrl-i"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          -- ["ctrl-i"] = { actions.toggle_ignore },
          ["ctrl-i"] = { actions.toggle_hidden },
        },
      },
    }
  end,
}
