-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local wk = require("which-key")

vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

-- vim.keymap.set(
--   "n",
--   "<leader>sx",
--   require("telescope.builtin").resume,
--   { noremap = true, silent = true, desc = "Resume" }
-- )

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<S-Up>", ":m .-2<CR>==", { noremap = true })
vim.keymap.set("n", "<S-Down>", ":m .+1<CR>==", { noremap = true })
vim.keymap.set("n", "<S-Left>", ":bp<CR>")
vim.keymap.set("n", "<S-Right>", ":bn<CR>")
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { noremap = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { noremap = true })
vim.keymap.set("n", "<C-h>", ":bp<CR>")
vim.keymap.set("n", "<C-l>", ":bn<CR>")
-- vim.keymap.set("n", "<C-p>", Util.telescope("files"))
vim.keymap.set("i", "<C-g>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
vim.keymap.set("n", "<C-g>", "[s1z=<c-o>")
vim.keymap.set("n", "<S-t>", ":Ttoggle<CR>")
vim.keymap.set("n", "<C-\\>", ":Commentary<CR>", { noremap = true })
vim.keymap.set("i", "<C-\\>", "<Esc>:Commentary<CR>a", { noremap = true })

vim.keymap.set("n", "<leader>cc", ":Commentary<CR>", { noremap = true })

-- vim.keymap.set("n", "<leader>ws", function()
--   local picker = require("window-picker")
--   local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
--   vim.api.nvim_set_current_win(picked_window_id)
-- end, { desc = "Pick window" })

-- vim.keymap.set("n", "<leader>Dl", function()
--   Util.float_term({ "lazydocker" }, { cwd = Util.get_root() })
-- end, { desc = "Lazydocker" })

-- vim.keymap.set("n", "<leader>Dc", function()
--   Util.float_term({ "ctop" }, { cwd = Util.get_root() })
-- end, { desc = "Ctop" })

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- wk.register({
--   g = {
--     name = "+Git",
--     h = {
--       name = "+Github",
--       c = {
--         name = "+Commits",
--         c = { "<cmd>GHCloseCommit<cr>", "Close" },
--         e = { "<cmd>GHExpandCommit<cr>", "Expand" },
--         o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
--         p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
--         z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
--       },
--       i = {
--         name = "+Issues",
--         p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
--       },
--       l = {
--         name = "+Litee",
--         t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
--       },
--       r = {
--         name = "+Review",
--         b = { "<cmd>GHStartReview<cr>", "Begin" },
--         c = { "<cmd>GHCloseReview<cr>", "Close" },
--         d = { "<cmd>GHDeleteReview<cr>", "Delete" },
--         e = { "<cmd>GHExpandReview<cr>", "Expand" },
--         s = { "<cmd>GHSubmitReview<cr>", "Submit" },
--         z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
--       },
--       p = {
--         name = "+Pull Request",
--         c = { "<cmd>GHClosePR<cr>", "Close" },
--         d = { "<cmd>GHPRDetails<cr>", "Details" },
--         e = { "<cmd>GHExpandPR<cr>", "Expand" },
--         o = { "<cmd>GHOpenPR<cr>", "Open" },
--         p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
--         r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
--         t = { "<cmd>GHOpenToPR<cr>", "Open To" },
--         z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
--       },
--       t = {
--         name = "+Threads",
--         c = { "<cmd>GHCreateThread<cr>", "Create" },
--         n = { "<cmd>GHNextThread<cr>", "Next" },
--         t = { "<cmd>GHToggleThread<cr>", "Toggle" },
--       },
--     },
--   },
-- }, { prefix = "<leader>" })
