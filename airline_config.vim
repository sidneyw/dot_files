"Config file for airline vim

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_loaded = 1

set noshowmode   " Gets rid of the original showing of modes in vim
set laststatus=2 " Shows the status bar even if there is only one file

let g:airline_theme= 'badwolf'

let g:airline#extensions#bufferline#enabled = 1

let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
let g:airline#extensions#tabline#show_tabs = 1   " shows tabs regardless of num

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''

let g:airline_section_warning = '[syntastic, whitespace]'
let g:airline#extensions#whitespace#checks = 'long'

" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
