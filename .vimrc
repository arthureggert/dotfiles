if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'psliwka/vim-smoothie'
    Plug 'tpope/vim-eunuch'
    Plug 'ctrlpvim/ctrlp.vim' 
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
    Plug 'SirVer/ultisnips'
    Plug 'junegunn/goyo.vim'
    Plug 'honza/vim-snippets'
    Plug 'APZelos/blamer.nvim'
    Plug 'Yggdroot/indentLine' 
    Plug 'jremmen/vim-ripgrep'
    Plug 'ryanoasis/vim-devicons'
    Plug 'airblade/vim-gitgutter'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'junegunn/limelight.vim'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'tsony-tsonev/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'majutsushi/tagbar'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'TaDaa/vimade'
    Plug 'pbrisbin/vim-mkdir'
    Plug 'vim-scripts/utl.vim'
    Plug 'xolox/vim-misc'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'tpope/vim-fugitive'
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
    Plug 'jparise/vim-graphql'
call plug#end()

syntax on

filetype plugin indent on

set foldmethod=syntax "syntax highlighting items specify folds
set foldcolumn=0 "defines 1 col at window left, to indicate folding
set foldlevelstart=99 "start file with all folds opened
set hidden  
set cmdheight=2 
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes
set clipboard=unnamed
set spell
set spelllang=en_us,pt_br,de_de
set number relativenumber
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

colorscheme dracula

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let mapleader=","
let maplocalleader="."
let g:rg_command = 'rg --vimgrep -S'
let NERDTreeIgnore = ['^node_modules$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:blamer_prefix = ''
let g:blamer_template = '[<author> @ <committer-time>] -> <summary>'
let g:prettier#autoformat = 0
let g:vitality_tmux_can_focus = 1
let g:coc_global_extensions = ['coc-snippets', 'coc-pairs', 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-json']
let g:airline_theme='dracula'
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '-'
let g:gitgutter_sign_modified_removed = '-'
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


if (has("termguicolors"))
    set termguicolors
endif

" after a resource, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

nmap <F3> i<C-R>=strftime("%Y.%m.%d_%A_%H%M")<CR><Esc>
imap <F3> <C-R>=strftime("%Y.%m.%d_A%_%H%M")<CR>

map <silent> <leader>m :call TerminalPreviewMarkdown()<CR>
map <silent> <leader>M :MarkdownPreview<CR>
map <silent> <leader>df :Goyo<CR>
map <silent> <C-v>l :vertical resize +10<CR>
map <silent> <C-v>s :vertical resize -10<CR>
map <silent> <F9> /^\(<\{7\}\\|>\{7\}\\|=\{7\}\\|\|\{7\}\)\( \\|$\)<cr>

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
nmap <leader>nt :NERDTreeToggle<CR><C-W>l:call SyncTree()<CR><C-W>h
nmap <leader>p :PrettierAsync<CR>
nmap <leader>b :BlamerToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F5> :call SyncTree()<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nmap <leader>f <Plug>(coc-format-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <silent> <C-d> <Plug>(coc-range-select)

xmap <leader>a  <Plug>(coc-codeaction-selected)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
xmap <silent> <C-d> <Plug>(coc-range-select)
xmap <leader>f <Plug>(coc-format-selected)

omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==
nnoremap <leader>s :w<cr>
nnoremap <S-s> :w<cr>
nnoremap <leader>q :bd<cr>
nnoremap <leader>qq :bd!<cr>
nnoremap <silent> <leader>bh :new<CR>
nnoremap <S-Right> :bn<cr>
nnoremap <S-Left> :bp<cr>
nnoremap <silent> <leader>bv :vnew<CR>
nnoremap <C-s> <Esc> :w<cr>
nnoremap <silent> <leader>cls :nohlsearch<CR><C-L>
nnoremap <C-z> <Esc>:u <CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>l

vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv

inoremap jk <ESC>
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <C-s> <Esc> :w<cr>==gi
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
inoremap <S-Down> <Esc>:m .+1<CR>==gi
inoremap <S-Up> <Esc>:m .-2<CR>==gi
inoremap <C-z> <Esc>:u <CR>==gi
inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

highlight MyLineTooLongMarker ctermbg=red guibg=red

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc setfiletype json
autocmd BufNewFile,BufRead *.mdx set syntax=markdown.pandoc
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

call matchadd('MyLineTooLongMarker', '\%121v', 100)

function! TerminalPreviewMarkdown()
	new % | terminal ! mdv %
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! IsNERDTreeOpen()        
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! SyncTree()
    if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
    endif
endfunction

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

" light-grey
hi tsxTypeBraces guifg=#999999
" dark-grey
hi tsxTypes guifg=#666666
