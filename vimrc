" My vimrc
" The_Squid


" General {{{
" ====================
" For pathogen to work
execute pathogen#infect()

" To allow \":Man cmd"
runtime! ftplugin/man.vim

set number              " Line numbers
syntax on               " syntax highlighting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showcmd             " Show commands in the bottom right corner
set hidden
set hlsearch            " Highlight search results
set incsearch           " Searches while still typing
set ai                  " Sets autoindent
set cursorline
set vb                  " Turn off terminal bell
set colorcolumn=80      " Turn on the colored column at column 80
set textwidth=90
set spelllang=en_us
set nowrap              " Turn off line wraps
set t_ut=               " Fixes colors in tmux

set shell=bash\ --login " make the sh command source the bash_profile

"set list
set listchars=tab:▸\ ,eol:¬

let mapleader="-"

" }}}

" Mappings {{{
" ====================
nnoremap <space> zt

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;

" Delete a function
nnoremap <leader>df vf{%d

" Change the window size more easily
nnoremap <silent> <leader>a <C-w>10<
nnoremap <silent> <leader>d <C-w>10>

" Run the notes command on the current file
nnoremap <leader>n :vs ~/Desktop/notes<cr>

" Move across windows holding control
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Some common toggles
nnoremap <leader>l :setlocal list!<cr>
nnoremap <leader>s :setlocal spell!<cr>
nnoremap <leader>w :setlocal wrap!<cr>

" SyntasticToggle
nnoremap <leader>z :SyntasticToggleMode<cr>
" Reformat the current buffer
nnoremap <leader>r mzgqG`z

" Change CWD for the window to the dir of the current file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Eval till = char
nnoremap <leader>= vt="zyf=a <C-r>=<C-r>z<cr><esc>

" Calling external commands
nnoremap <leader>i :r !idea -v<cr>"zy$dd:e <C-r>z<cr>
nnoremap <leader>c :!class 

" Edit Bash Profile
nnoremap <leader>eb :vsplit ~/.bash_profile<cr>

" Source Bash Profile
nnoremap <leader>sb :!source ~/.bash_profile<cr>

" Edit vimrc 
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit tmux config
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>

" Source tmux config
nnoremap <leader>st :!tmux source-file ~/.tmux.conf<cr>

" Edit my GTD todo list
nnoremap <leader>g :vsplit ~/Desktop/todo.txt<cr>

" }}}

" Autocommands {{{
" ====================
augroup text
	autocmd!

	autocmd FileType text,unix :setlocal wrap spell foldmethod=indent
augroup END

augroup python
	autocmd!
	autocmd FileType python :nnoremap <buffer> <leader>t :!python <C-r>%<cr>
augroup END

augroup javascript
	autocmd!
	autocmd FileType javascript :iabbrev <buffer> clog console.log()<esc>i
	autocmd FileType javascript :iabbrev <buffer> { {<esc>o}<esc>O 
	" } Fixes syntax highlights in this file
	autocmd FileType javascript :nnoremap <buffer> <leader>t :!node <C-r>%<cr>
augroup END

augroup html
	autocmd!
	autocmd FileType html :setlocal nowrap
augroup END

augroup vim
	autocmd!
	autocmd FileType vim :setlocal foldmethod=marker
augroup END
" }}}

" Color Scheme {{{
" ====================
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set t_Co=256
colorscheme badwolf
" colorscheme sky
" colorscheme lanox
" colorscheme brogrammer
" highlight ColorColumn cterm=NONE ctermbg=green

" }}}

" Abbreviations {{{
" ====================
iabbrev teh the
iabbrev Teh The
iabbrev THe The

iabbrev Im I'm
iabbrev im I'm

iabbrev yuo you
iabbrev Yuo You

iabbrev taht that
iabbrev Taht That

iabbrev waht what
iabbrev Waht What

iabbrev tehn then
iabbrev Tehn Then

iabbrev xdate <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr><esc>@o2jo
iabbrev xbash #!/bin/bash<cr>
iabbrev xpython #!/usr/bin/python<cr>

" Turn sleep on and off
cnoreabbr caf !caffeinate -d&
cnoreabbr kcaf !killall caffeinate

" }}}

" Functions {{{
" ===================

" }}}

" Plugins stuff {{{
" ===================
" Plugin list
" NERDTREE
" Bufferline
" Airline
" Tmuxline
" Syntastic
" Fugitive
" CtrlP

" NERDTree {{{
" ======================
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" ignore .o files - see help NERDTreeIgnore
let NERDTreeIgnore=['\.o$[[file]]', '\.py[cdo]$[[file]]']

" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set winfixwidth

" }}}

" Bufferline
" ======================
let g:bufferline_echo = 0

" Airline {{{
" ======================
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_loaded = 1

set noshowmode   " Gets rid of the original showing of modes in vim
set laststatus=2 " Shows the status bar even if there is only one file

" badwolf
" dark
" durant
" sky
" wombat
let g:airline_theme= 'dark'

let g:airline#extensions#bufferline#enabled = 1

let g:airline#extensions#branch#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
let g:airline#extensions#tabline#show_tabs = 1   " shows tabs regardless of num

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''

let g:airline#extensions#syntastic#enabled = 1
let g:airline_section_warning = '[syntastic]'
let g:airline#extensions#whitespace#checks = 'long'

let g:airline#extensions#tmuxline#enabled = 1

" }}}

" Tmux line {{{
" ======================

" crosshair
" full
" minimal
" nightly_fox
" powerline
" righteous
" tmux

let g:tmuxline_preset = 'full'

" crosshair
" full
" minimal
" nightly_fox
" powerline
" righteous
" tmux
" let g:tmuxline_preset = 'powerline'
" }}}

" Syntastic {{{
" ======================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Python Config
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,W191'

let g:syntastic_mode_map = {'mode': 'active',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': ['html'] }

" }}}

" Ctrl P {{{
" ======================
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode='a'

" }}}

" }}}
