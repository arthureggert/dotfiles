vim.opt.guicursor = "i:ver100"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.writebackup = false
vim.opt.wildignore:append("*/tmp/*,*.so,*.swp,*.zip")
vim.opt.wildignore:append("*.pyc,*.o,*.obj,*.dll,*.exe,*.so,*.a,*.lib,*.out")
vim.opt.smarttab = true
