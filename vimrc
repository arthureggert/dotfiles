"Vundle Configuration
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'honza/vim-snippets'
Plugin 'octol/vim-cpp-enhanced-highlight'
call vundle#end() 
filetype plugin indent on

" Pathogen Path
runtime bundle/vim-pathogen/autoload/pathogen.vim

"Pathogen Configuration
call pathogen#infect()
call pathogen#helptags()
syntax on

"SuperTab Configuration
let g:SuperTabMappingForward = '<s-space>'
let g:SuperTabMappingBackward = '<s-c-space>'
let g:SuperTabDefaultCompletionType = 'context'

"UltSnips Configuration
"Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

"IdentLIne Configuration
" vertical line indentation
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

"Delimitmate Configuration
let delimitMate_expand_cr = 1

"CtrlP Configuration
let g:ctrlp_map = '<leader>t' " Use <leader>t to open ctrlp
set wildignore+=*/build/** " Ignore these directories
let g:ctrlp_use_caching=0 " disable caching

"Gradle Configuration
map <F4> :w<CR> :compiler gradle<CR> :make test<CR>:cw 4<CR>

"YouCompleteMe Configuration
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

"Solarized Configuration
syntax enable
set background=dark
colorscheme solarized

"VIM Line Numbers
set number

"Eclim Configuration
let g:EclimCompletionMethod = 'omnifunc'

"Omnifunc autocomplete
set omnifunc=syntaxcomplete#Complete
"TagBar Configuration
nmap <F8> :TagbarToggle<CR>
