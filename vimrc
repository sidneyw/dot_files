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
set spelllang=en_us

set list
set listchars=tab:▸\ ,eol:¬

let mapleader="-"

" ====================
" Some mappings
" ====================
nnoremap <space> zt

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;

nnoremap <leader>t :r !date<cr>
nnoremap <leader>l :setlocal list!<cr>
nnoremap <leader>s :setlocal spell!<cr>

" Edit vimrc 
nnoremap <leader>ev :vsplit $MYVIMRC<cr> 
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr> 

" ====================
" Some autocommands
" ====================
runtime! ftplugin/man.vim

" ====================
" Color Scheme
" ====================
colorscheme badwolf
"highlight ColorColumn cterm=NONE ctermbg=green

" ====================
" Abbreviations
" ====================
iabbrev teh the
iabbrev Teh The
iabbrev THe the

iabbrev yuo you
iabbrev Yuo You

iabbrev taht that
iabbrev Taht That

iabbrev waht what
iabbrev Waht What

iabbrev tehn then
iabbrev Tehn Then

" ====================
" Plugins stuff
" ====================
" Plugin list
" NERDTREE
" Airline
" Syntastic
" Bufferline
" Fugitive

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Bufferline
let g:bufferline_echo = 0

" Airline
source ~/.vim/airline_config.vim
