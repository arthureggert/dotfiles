if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
   Plug 'dracula/vim', { 'as': 'dracula' }
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:dracula_colorterm = 0 "For some reason with this value as 1 the colorscheme does not work as expected

filetype plugin on

colorscheme dracula 
highlight Comment cterm=italic " Comments are now show in italic

set encoding=utf8
set termguicolors
set number relativenumber
set nobackup
set nowritebackup
set t_ZH=[3m  " This is a 'HACK' to see italics in vim
set t_ZR=[23m " This is a 'HACK' to see italics in vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip "willignore listed files will be ignored by vim and by CTRL+P

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab

let mapleader=","

"CTRL+P Will ignore all the files listed on the gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"CTRL+P will ignore those files/dirs
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

"List of COC-Vim extensions to load
let g:coc_global_extensions = ['coc-sh', 'coc-clangd', 'coc-cl', 'coc-css', 'coc-go', 'coc-html', 'coc-java', 'coc-tsserver', 'coc-json', 'coc-markdownlint', 'coc-perl', 'coc-pyright', 'coc-metals' ]

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument "Will make prettier use coc-prettier to do the formating

"Use TAB to do autocompletion from snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Blame plugin config
let g:blamer_prefix = ' > '
let g:blamer_template = '<committer> • <summary>'

" IdentLine Plugin config
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" NERDTREE Plugin Config
let NERDTreeIgnore = ['^node_modules$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1

" VimAirline Plugin Config
let g:airline#extensions#tabline#enabled = 1

" Keynboard Shortcuts
nmap <leader>nt :NERDTreeToggle<CR><C-W>l:call SyncTree()<CR><C-W>h
nmap <leader>p :PrettierAsync<CR>
nnoremap <S-Left> :bp<CR>
nnoremap <S-Right> :bn<CR>
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==
nnoremap <S-s> :w<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>q :bd<cr>
nnoremap <leader>qq :bd!<cr>
nnoremap <C-s> <Esc> :w<cr>
nnoremap <C-z> <Esc> :u <CR>
nnoremap <S-Right> :bn<cr>
nnoremap <S-Left> :bp<cr>
nnoremap <silent> <leader>bh :new<CR>
nnoremap <silent> <leader>bv :vnew<CR>

"Autocmds
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Custom Functions
function! IsNERDTreeOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction
