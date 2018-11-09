" http://vimdoc.sourceforge.net/htmldoc/usr_41.html#vim-script-intro:

" FIX ISSUE: http://unix.stackexchange.com/questions/305415/enabling-python3-on-vim-in-fedora-24
if exists('py2') && has('python')
elseif has('python3')
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'Quramy/tsuquyomi'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tomaskallup/vim-styled-components', { 'branch': 'main' }
Plug 'jxnblk/vim-mdx-js'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'

call plug#end()

colorscheme elflord   

" General configuration -------------------------------------------------------
set number
set ruler
set backspace=indent,eol,start
set noswapfile
set termwinsize="1x0"
" set autochdir

let mapleader = ','
let NERDTreeShowHidden=1

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Autocompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Seach
set hlsearch
set incsearch

"set paste
set ttyfast

set autoindent
set showcmd
set guifont=Fira\ Code:h18 

" Fugitive (Diff for resolve conflicts) ---------------------------------------
set diffopt+=vertical

" Fold by grouping indented text
set foldmethod=indent

" Sets the maximum nesting of folds
set foldnestmax=10

" Avoid folding when the file is being open
set nofoldenable

" Folds with a higher level will be closed
set foldlevel=2


" NERDTree Configuration ------------------------------------------------------
map <F3> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>
" map <C-b> :NERDTreeFocus<CR>

let g:tsuquyomi_disable_quickfix = 1

" TagBar Configuration --------------------------------------------------------

" autofocus on Tagbar open
let g:tagbar_autofocus = 1

" toggle Tagbar display
map <F4> :TagbarToggle<CR>

" Set default width
let g:tagbar_width = 30

" Load the JavaScript type support
let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'js',
    \ 'kinds'     : [
        \ 'o:objects',
        \ 'u:functions',
        \ 'v:variables',
        \ 'c:controllers',
        \ 'd:directives',
        \ 's:services',
        \ 'f:factories',
        \ 'm:modules',
        \ 'c:controllers',
    \ ]
\ }

:nnoremap <F5> :buffers<CR>:buffer<Space>

" FZF Configuration -----------------------------------------------------------
" nnoremap <F2> :FZF<CR>
nnoremap <F2> :call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))<CR>

" CtrlP Configuration ---------------------------------------------------------
nnoremap <silent> <leader>f :CtrlP<CR>
nnoremap <silent> <leader>fm :CtrlPMRU<CR>

" Don't change working directory
let g:ctrlp_working_path_mode = 0

" Ignore this files/dirs
let g:ctrlp_custom_ignore = {
            \ 'dir': 'node_modules\|build\|coverage\|git',
            \ }

" Update the search once the user ends typing.
let g:ctrlp_lazy_update = 2

" Ale Configuration -----------------------------------------------------------
" let g:ale_open_list=0
" let g:ale_set_loclist=1
" let g:ale_set_quickfix=0
" let g:ale_statusline_format = ['✖ %d', '⚠  %d', '⬥ ok']
let airline#extensions#ale#error_symbol = '✖'
let airline#extensions#ale#warning_symbol = '⚠'
let airline#extensions#ale#open_lnum_symbol = '('
let airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_fix_on_save = 1
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'typescript': ['prettier', 'tslint']}
" let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
" let g:ale_sign_error = '->'
" let g:ale_sign_warning = '>='
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

" Airline configuration -------------------------------------------------------
" Make airline to appear on all the tabs
set laststatus=2

" Use 256 colors
set t_Co=256

let g:airline#extensions#tabline#show_tabs = 0
let g:airline_powerline_fonts = 1 

" call airline#parts#define_function('ALE', 'ALEGetStatusLine')
" call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
" let g:airline_section_error = airline#section#create_right(['ALE'])

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '->'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '<-'
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = 'RE'
" let g:airline_symbols.linenr = 'Line'
let g:airline#extensions#tabline#enabled = 1

set colorcolumn=120
set cursorline

" Searching colors
highlight Search cterm=NONE ctermfg=LightGrey ctermbg=Blue

" BINDINGS --------------------------------------------------------------------

" Eliminates delay issues
set timeoutlen=1000 ttimeoutlen=50


noremap <S-Left> :bp<CR>
noremap <S-Right> :bn<CR>
noremap <C-w> :bd<CR>

" Toggle tabs display
noremap <C-k> :setlocal list!<CR>

" Navigate between errors
" nmap <silent> <S-h> <Plug>(ale_previous_wrap)
" nmap <silent> <C-h> <Plug>(ale_next_wrap)

" Toggle errors visibility
noremap <silent> <C-e> :ALEToggle<CR>

" Move lines
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==

" Leader C is the prefix for code related mappîngs
noremap <silent> <Leader>cc :TComment<CR>

" reloads .vimrc -- making all changes active
map <silent> <Leader>v :source ~/.vimrc<CR>:PlugInstall<CR>:bdelete<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Ctrl B for buffer related mappings
nnoremap <silent> <Leader>b :CtrlPBuffer<CR> " cycle between buffer
nnoremap <silent> <Leader>bb :bn<CR> "create (N)ew buffer
nnoremap <silent> <Leader>bd :bdelete<CR> "(D)elete the current buffer
nnoremap <silent> <Leader>bu :bunload<CR> "(U)nload the current buffer
nnoremap <silent> <Leader>bl :setnomodifiable<CR> " (L)ock the current buffer"

let g:UltiSnipsExpandTrigger="<c-j>"
