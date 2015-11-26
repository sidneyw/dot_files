" General
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

runtime! ftplugin/man.vim

" Color Scheme
highlight CursorLine cterm=NONE ctermbg=blue ctermfg=NONE guibg=blue guifg=white
highlight LineNr ctermfg=grey ctermbg=blue
highlight StatusLine  ctermfg=white  guifg=#ffffff ctermbg=blue guibg=#4e4e4e cterm=bold gui=bold
highlight ColorColumn cterm=NONE ctermbg=green

" Abbreviations
ab teh the
ab Teh The

ab yuo you
ab Yuo You

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;

" Map cmd number to tabs
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt

" For pathogen to work
execute pathogen#infect()

" NERDTree
" ; instead of : due to the colon remap above
nmap <C-n> ;NERDTreeToggle<CR>

" Bufferline
let g:bufferline_echo = 0

" Airline
set noshowmode   " Gets rid of the original showing of modes in vim
set laststatus=2 " Shows the status bar even if there is only one file

let g:airline_theme= 'badwolf'

let g:airline#extensions#bufferline#enabled = 1

let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
let g:airline#extensions#tabline#show_tabs = 1   " shows tabs regardless of num

let g:airline_symbols = {}
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''

let g:airline_section_warning = '[syntastic, whitespace]'
let g:airline#extensions#whitespace#checks = 'long'

" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
