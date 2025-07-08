-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local homedir = os.getenv("HOME")

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.95)))
end

vim.opt.winbar = "%=%m %f"
vim.opt.spelllang = { "en" }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.vim_markdown_folding_disabled = 1
vim.g.python3_host_prog = homedir .. "/.virtualenvs/nvim/bin/python"

vim.g.lazyvim_eslint_auto_format = false

vim.wo.wrap = false
vim.wo.linebreak = true
vim.wo.list = false

vim.opt.list = false
vim.opt.listchars = "tab:>·,trail:~,extends:>,precedes:<,space:␣,eol:¬"

-- vim.opt.colorcolumn = "79,119"

-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.signcolumn = "number"
vim.opt.statuscolumn = "%@SignCb@%s%=%T%@NumCb@%l %r│%T"

if vim.g.neovide then
  vim.o.guifont = "Hack Nerd Font:h20"
  -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_opacity = 0.0
  vim.g.transparency = 0.95
  vim.g.neovide_background_color = "#0f1117" .. alpha()
end
