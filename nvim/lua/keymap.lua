local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })
keymap.set('n', '<S-Left>', 'gT')
keymap.set('n', '<S-Right>', 'gt')

-- Split window
keymap.set('n', 'bv', ':vnew<Return>')
keymap.set('n', 'bh', ':new<Return>')
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('n', 'sh', '<C-w>h')
keymap.set('n', 'sk', '<C-w>k')
keymap.set('n', 'sj', '<C-w>j')
keymap.set('n', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Move Line
keymap.set('n', '<S-Up>', ':m .-2<CR>==')
keymap.set('n', '<S-Down>', ':m .+1<CR>==')

-- File Actions
keymap.set('n', '<leader> s', ':w<CR>')
keymap.set('n', '<leader> q', ':bd<CR>')
keymap.set('n', '<leader> qq', ':bd!<CR>')
keymap.set('n', '<C-s>', '<Esc> :w <CR>')

--nnoremap <leader>q :bd<cr>
--nnoremap <leader>qq :bd!<cr>
--nnoremap <C-s> <Esc> :w<cr>
--nnoremap <C-z> <Esc> :u <CR>


