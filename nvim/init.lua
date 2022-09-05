local map = vim.api.nvim_set_keymap

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

require('base')
require('highlights')
require('macos')
require('plugins')
require('keymap')
