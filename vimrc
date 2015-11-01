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

" Color Scheme
highlight CursorLine cterm=NONE ctermbg=blue ctermfg=NONE guibg=blue guifg=white
highlight LineNr ctermfg=red ctermbg=green
highlight StatusLine  ctermfg=white  guifg=#ffffff ctermbg=blue guibg=#4e4e4e cterm=bold gui=bold
highlight ColorColumn cterm=NONE ctermbg=green

" Abbreviations
ab teh the
ab Teh The

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;

" For pathogen to work
execute pathogen#infect()

" NERDTree
" ; instead of : due to the colon remap above
nmap <C-n> ;NERDTreeToggle<CR>

" Airline
let g:airline_section_warning = 'syntastic'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
