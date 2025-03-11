-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local homedir = os.getenv("HOME")

vim.opt.winbar = "%=%m %f"
vim.opt.spelllang = { "en", "pt_br" }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.vim_markdown_folding_disabled = 1
vim.g.python3_host_prog = homedir .. "/.virtualenvs/nvim/bin/python"

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
end
