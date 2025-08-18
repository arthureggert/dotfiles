-- ~/.config/nvim-new/plugin/configs.lua
local opt = vim.opt

local homedir = os.getenv("HOME")

opt.guicursor = {
    'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
    'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
    'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100'
}
opt.colorcolumn = "120"
opt.signcolumn = "yes:1"
opt.termguicolors = true
opt.ignorecase = true
opt.swapfile = false
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.listchars = "tab: ,multispace:|   ,eol:󰌑"
opt.list = true
opt.number = true
opt.relativenumber = true
opt.statuscolumn = "%@SignCb@%s%=%T%@NumCb@%l %r│%T"
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8
opt.inccommand = "nosplit"
opt.undodir = homedir .. "/.vim/undodir"
opt.undofile = true
opt.completeopt = { "menuone", "popup", "noinsert" }
opt.winborder = "rounded"
opt.hlsearch = false
opt.winbar = "%=%m %f"

vim.cmd.filetype("plugin indent on")

vim.cmd.colorscheme("dracula_pro_van_helsing")

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"
