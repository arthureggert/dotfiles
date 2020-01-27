" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'yuezk/vim-js'
Plug 'elzr/vim-json'
Plug 'benmills/vimux'
Plug 'janko/vim-test'
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'honza/vim-snippets'
Plug 'APZelos/blamer.nvim'
Plug 'Yggdroot/indentLine' 
Plug 'jremmen/vim-ripgrep'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'jacoborus/tender.vim'
Plug 'freitass/todo.txt-vim'
Plug 'jaredgorski/spacecamp'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/limelight.vim'
Plug 'blueyed/vim-diminactive'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'plasticboy/vim-markdown'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'HerringtonDarkholme/yats.vim' 
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'christoomey/vim-tmux-navigator'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()
let $NVIM_TUI_ENABLE_TRUE_COLOR=1


" Configuração do Python para usar Python 2 e Python 3 
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog  = '/usr/local/bin/python3'
" Mapeia <Leader> para ser o simbolo ','
let mapleader=","
let maplocalleader="."
let NERDTreeHijackNetrw=1
let g:rg_command = 'rg --vimgrep -S'
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:airline#extensions#tabline#enabled = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let NERDTreeIgnore = ['^node_modules$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let test#strategy="vimux"
let g:blamer_prefix = ''
let g:blamer_template = '[<author> @ <committer-time>] -> <summary>'

set clipboard=unnamed
set spell
set spelllang=en_us,pt_br,de_de

"if (has("termguicolors"))
 "set termguicolors
"endif

" after a resource, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
nmap <leader>nt :NERDTreeToggle <bar> :call SyncTree()<CR>
nmap <leader>p :PrettierAsync<CR>
nmap <leader>b :BlamerToggle<CR>

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> <Leader>tlg :call ToggleLazyGit()<CR>
nnoremap <S-Up> :m .-2<CR>==
nnoremap <M-m> :MarkdownPreview<CR>
nnoremap <S-Down> :m .+1<CR>==
nnoremap <leader>s :w<cr>
nnoremap <S-s> :w<cr>
nnoremap <leader>q :bd<cr>
nnoremap <silent> <leader>bh :new<CR>
nnoremap <S-Right> :bn<cr>
nnoremap <S-Left> :bp<cr>
nnoremap <silent> <leader>bv :vnew<CR>
nnoremap <C-s> <Esc> :w<cr>
nnoremap <silent> <leader>cls :nohlsearch<CR><C-L>
nnoremap <C-z> <Esc>:u <CR>
nnoremap <silent> <Leader>t :call ToggleScratchTerm()<CR>

vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv

inoremap jk <ESC>
inoremap <C-s> <Esc> :w<cr>==gi
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
inoremap <S-Down> <Esc>:m .+1<CR>==gi
inoremap <S-Up> <Esc>:m .-2<CR>==gi
inoremap <C-z> <Esc>:u <CR>==gi

" open NERDTree automaticaly
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree


" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

set relativenumber
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set background=dark
set t_Co=256

syntax enable
" colorscheme tender
" colorscheme PaperColor
" colorscheme gruvbox
" colorscheme spacecamp
colorscheme nord

" When term starts, auto go into insert mode
autocmd TermOpen * startinsert

" Turn off line numbers etc
autocmd TermOpen * setlocal listchars= nonumber norelativenumber

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

" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>l

highlight MyLineTooLongMarker ctermbg=red guibg=red
"  call matchadd('MyLineTooLongMarker', '\%81v', 100)
call matchadd('MyLineTooLongMarker', '\%121v', 100)

augroup filetypes
  autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc setfiletype json
augroup END

autocmd BufNewFile,BufRead *.mdx set syntax=markdown
