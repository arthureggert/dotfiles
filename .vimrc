" FIX ISSUE: http://unix.stackexchange.com/questions/305415/enabling-python3-on-vim-in-fedora-24
if exists('py2') && has('python')
elseif has('python3')
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug '/opt/fzf' | Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'guns/xterm-color-table.vim'
Plug 'ternjs/tern_for_vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tomaskallup/vim-styled-components', { 'branch': 'main' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'Quramy/tsuquyomi'
Plug 'jxnblk/vim-mdx-js'
Plug 'mileszs/ack.vim'

call plug#end()

" General configuration ------------------------------------------------------

syntax enable
filetype plugin indent on

set number
set ruler
set backspace=indent,eol,start
set noswapfile
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set omnifunc=syntaxcomplete#Complete
set hlsearch
set incsearch
set ttyfast
set autoindent
set showcmd
set diffopt+=vertical
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2
set laststatus=2
set t_Co=256
set colorcolumn=120
set cursorline
set timeoutlen=1000 ttimeoutlen=50
set guifont=Fira\ Code:h22
set guioptions-=L
set termguicolors
set signcolumn=yes

let NERDTreeShowHidden=1
let mapleader = ','
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = { 'dir': 'node_modules\|build\|coverage\|git', }
let g:ctrlp_lazy_update = 2
let airline#extensions#ale#error_symbol = '✖'
let airline#extensions#ale#warning_symbol = '⚠'
let airline#extensions#ale#open_lnum_symbol = '('
let airline#extensions#ale#close_lnum_symbol = ')'
let g:airline#extensions#itabline#show_tabs = 0
let g:airline_powerline_fonts = 1 
let g:airline#extensions#tabline#enabled = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'typescript':['prettier','tslint'] }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:quantum_italics=1
let g:tsuquyomi_use_dev_node_module=2
let g:tsuquyomi_tsserver_path='/Users/aheggert/.nvm/versions/node/v10.13.0/bin/tsserver'

map <F3> :NERDTreeToggle<CR>
map <F4> :NERDTreeFind<cr>
map <C-b> :NERDTreeFocus<CR>
map <silent> <Leader>v :source ~/.vimrc<CR>:PlugInstall<CR>:bdelete<CR>:exe ":echo 'vimrc reloaded'"<CR>
            
noremap <S-Left> :bp<CR>
noremap <S-Right> :bn<CR>
noremap <Leader>q :bd<CR>
noremap <C-q> :bd<CR>
noremap <C-k> :setlocal list!<CR>
noremap <silent> <C-e> :ALEToggle<CR>
noremap <silent> <Leader>cc :TComment<CR>

nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==
nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <F2> :call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))<CR>
nnoremap <silent> <Leader>f :CtrlP<CR>
nnoremap <silent> <Leader>fm :CtrlPMRU<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR> " cycle between buffer
nnoremap <silent> <Leader>bb :bn<CR> "create (N)ew buffer
nnoremap <silent> <Leader>bd :bdelete<CR> "(D)elete the current buffer
nnoremap <silent> <Leader>bu :bunload<CR> "(U)nload the current buffer
nnoremap <silent> <Leader>bl :setnomodifiable<CR> " (L)ock the current buffer"
nnoremap <Leader>s :w<CR>

nmap <Leader>iF <Plug>(JsFileImportList)
nmap <Leader>ig <Plug>(JsGotoDefinition)
nmap <Leader>ip <Plug>(PromptJsFileImport)
nmap <Leader>ic <Plug>(JsFixImport)
nmap <Leader>if <Plug>(JsFileImport)
nmap <Leader>is <Plug>(SortJsFileImport)
nmap <silent> <S-h> <Plug>(ale_previous_wrap)
nmap <silent> <C-h> <Plug>(ale_next_wrap)
nmap <Leader>r :TernRename<CR>
nmap <Leader>j :TernDef<CR>

highlight CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
highlight Search cterm=NONE ctermfg=LightGrey ctermbg=Blue

colorscheme quantum

augroup filetypes
  autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc setfiletype json
augroup END

autocmd BufNewFile,BufRead *.mdx set syntax=markdown
