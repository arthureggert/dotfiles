 " Specify a directory for plugins
call plug#begin('~/.vim/plugged')
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
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-fugitive'

call plug#end()

filetype plugin indent on
syntax on

let g:notes_markdown_program= 'markdown2'
let g:notes_directories = ['~/Box Sync']
let g:vimade = {}
let g:vimade.enablefocusfading = 1 
let g:python_host_prog  = '/Users/aheggert/.pyenv/versions/2.7.18/bin/python'
let g:python3_host_prog  = '/Users/aheggert/.pyenv/shims/python'
let mapleader=","
let maplocalleader="."
let g:rg_command = 'rg --vimgrep -S'
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
let g:airline_theme='dracula'

"set fillchars=vert:\│,eob:\ 
set foldmethod=syntax "syntax highlighting items specify folds
set foldcolumn=0 "defines 1 col at window left, to indicate folding
set foldlevelstart=99 "start file with all folds opened
set hidden  
set cmdheight=2 
set nobackup " Some servers have issues with backup files
set nowritebackup " Some servers have issues with backup files
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
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
"set background=dark
"set t_Co=256
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

colorscheme dracula

if (has("termguicolors"))
 set termguicolors
endif

" after a resource, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if has("gui_running")
  if has("gui_macvim")
    " MacVim
    set guifont=FiraMonoForPowerline-Medium:h12
  endif
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

nnoremap <Leader>ww :e ~/Box\ Sync/Notes/index.md<cr>
nnoremap <silent> <Leader>tlg :call ToggleLazyGit()<CR>
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
nnoremap <silent> <Leader>t :call ToggleScratchTerm()<CR>
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

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" run prettier on save
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" open NERDTree automaticaly
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" When term starts, auto go into insert mode
"autocmd TermOpen * startinsert

" Turn off line numbers etc
" autocmd TermOpen * setlocal listchars= nonumber norelativenumber

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup filetypes
  autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc setfiletype json
augroup END

autocmd BufNewFile,BufRead *.mdx set syntax=markdown.pandoc

"hi ActiveWindow ctermbg=None ctermfg=None guibg=#011627
"hi InactiveWindow ctermbg=none ctermfg=none guibg=#282C34
"set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

highlight MyLineTooLongMarker ctermbg=red guibg=red
"  call matchadd('MyLineTooLongMarker', '\%81v', 100)
call matchadd('MyLineTooLongMarker', '\%121v', 100)

function! TerminalPreviewMarkdown()
	new % | terminal ! mdv %
endfu

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

" Cria uma janela sobre o vim atual
function! CreateCenteredFloatingWindow()
  let width = float2nr(&columns * 0.6)
  let height = float2nr(&lines * 0.6)
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  autocmd BufWipeout <buffer> call CleanupBuffer(s:buf)
  tnoremap <buffer> <silent> <Esc> <C-\><C-n><CR>:call DeleteUnlistedBuffers()<CR>
endfunction

" Opens a throwaway/scratch terminal
function! ToggleScratchTerm()
  call ToggleTerm('zsh')
endfunction

function! ToggleTerm(cmd)
  if empty(bufname(a:cmd))
    call CreateCenteredFloatingWindow()
    call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
  else
    call DeleteUnlistedBuffers()
  endif
endfunction

function! OnTermExit(job_id, code, event) dict
  if a:code == 0
    call DeleteUnlistedBuffers()
  endif
endfunction

" Opens lazygit
function! ToggleLazyGit()
  call ToggleTerm('lazygit')
endfunction

function! DeleteUnlistedBuffers()
  for n in nvim_list_bufs()
    if ! buflisted(n)
      let name = bufname(n)
      if name == '[Scratch]' ||
            \ matchend(name, ":bash") ||
            \ matchend(name, ":lazygit") ||
            \ matchend(name, ":tmuxinator-fzf-start.sh") ||
            \ matchend(name, ":hstarti")
        call CleanupBuffer(n)
      endif
    endif
  endfor
endfunction

function! CleanupBuffer(buf)
  if bufexists(a:buf)
    silent execute 'bwipeout! '.a:buf
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
