-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local wk = require("which-key")

wk.register({
  ["<leader>D"] = { name = "+docker" },
  ["<leader>m"] = { name = "+markdown" },
  ["<leader>z"] = { name = "+zenmode" },
})

vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

vim.keymap.set("n", "<leader>we", ":Neotree<CR>", { noremap = true, silent = true, desc = "Neo Tree" })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==", { noremap = true })
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==", { noremap = true })
vim.keymap.set("n", "<S-Left>", ":bp<CR>")
vim.keymap.set("n", "<S-Right>", ":bn<CR>")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { noremap = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { noremap = true })
vim.keymap.set("n", "<C-h>", ":bp<CR>")
vim.keymap.set("n", "<C-l>", ":bn<CR>")
vim.keymap.set("n", "<C-p>", Util.telescope("files"))
vim.keymap.set("i", "<C-g>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
vim.keymap.set("n", "<C-g>", "[s1z=<c-o>")
vim.keymap.set("n", "<S-t>", ":Ttoggle<CR>")
vim.keymap.set("n", "<C-\\>", ":Commentary<CR>", { noremap = true })
vim.keymap.set("i", "<C-\\>", "<Esc>:Commentary<CR>a", { noremap = true })

vim.keymap.set("n", "<leader>cc", ":Commentary<CR>", { noremap = true })

vim.keymap.set("n", "<leader>ws", function()
  local picker = require("window-picker")
  local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick window" })

vim.keymap.set("n", "<leader>Dl", function()
  Util.float_term({ "lazydocker" }, { cwd = Util.get_root() })
end, { desc = "Lazydocker" })

vim.keymap.set("n", "<leader>Dc", function()
  Util.float_term({ "ctop" }, { cwd = Util.get_root() })
end, { desc = "Ctop" })

vim.keymap.set("n", "<leader>Dd", function()
  Util.float_term({ "dockly" }, { cwd = Util.get_root() })
end, { desc = "Dockly" })

vim.keymap.set("n", "<leader>zt", ":TZAtaraxis<CR>", { desc = "Toggle ZenMode" })
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>mg", ":Glow<CR>", { desc = "Markdown Preview (Glow)" })
