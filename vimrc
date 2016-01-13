" My vimrc
" The_Squid

" For pathogen to work
execute pathogen#infect()

" ====================
" General
" ====================
set number         " Line numbers
syntax on          " syntax highlighting
set tabstop=4
set shiftwidth=4
set softtabstop=4  
set showcmd        " Show commands in the bottom right corner
set hidden
set hlsearch       " Highlight search results
set incsearch      " Searches while still typing
set ai             " Sets autoindent
set cursorline
set vb			   " Turn off terminal bell
set colorcolumn=80 " Turn on the colored column at column 80

let mapleader="-"

" Some mappings
nnoremap <space> zt

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;

nmap <leader>t ;r!date<cr>

" Edit vimrc 
nnoremap <leader>ev :vsplit $MYVIMRC<cr> 
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr> 

runtime! ftplugin/man.vim

" ====================
" Color Scheme
" ====================
highlight CursorLine cterm=NONE ctermbg=blue ctermfg=NONE guibg=blue guifg=white
highlight LineNr ctermfg=grey ctermbg=blue
highlight StatusLine  ctermfg=white  guifg=#ffffff ctermbg=blue guibg=#4e4e4e cterm=bold gui=bold
highlight ColorColumn cterm=NONE ctermbg=green

" ====================
" Abbreviations
" ====================
iabbrev teh the
iabbrev Teh The
iabbrev yuo you
iabbrev Yuo You
iabbrev waht what
iabbrev tehn then

" ====================
" Plugins stuff
" ====================

" NERDTree
" ; instead of : due to the colon remap above
nmap <C-n> ;NERDTreeToggle<CR>

" Bufferline
let g:bufferline_echo = 0

" Airline
source ~/.vim/airline_config.vim
