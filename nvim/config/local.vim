" My vimrc
" The_Squid

" General {{{
" ====================
set shell=/bin/bash

" To allow \":Man cmd"
runtime! ftplugin/man.vim

set relativenumber
set number              " Line numbers
syntax on               " syntax highlighting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showcmd             " Show commands in the bottom right corner
set ai                  " Sets autoindent
set cursorline
set vb                  " Turn off terminal bell
set colorcolumn=80      " Turn on the colored column at column 80
set textwidth=80
set spelllang=en_us
set nowrap              " Turn off line wraps
set t_ut=
set foldlevelstart=10   " most folds should be open on start
set foldmethod=indent
set lazyredraw          " Don't redraw the screen during a macro
set mat=1               " How many seconds to blink on a matched paren
set backspace=indent,eol,start " Backspace for insert mode

set shell=bash\ --login " make the sh command source the bash_profile
set backupcopy=yes      " For webpack hot reloading

"set list
set listchars=tab:▸\ ,eol:¬

let mapleader="-"
let maplocalleader = "\\"

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

" Make with all cores
" nnoremap <leader>n :make! -j<cr>

" Use vimgrep to search for the previous search in the arg list
nnoremap <leader>v :vimgrep /<C-r>//g ##<cr>

" SyntasticToggle - following vim unimpaired style
nnoremap coz :SyntasticToggleMode<cr>

" Change Tmux Line color scheme
nnoremap <leader>z :Tmuxline airline_insert<cr>

" See the full file path 
nnoremap <leader>p :echo expand("%:p")<cr>

" Open and close the quickfix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>

" Change CWD for the window to the dir of the current file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Eval till = char
nnoremap <leader>= vt="zyf=a <C-r>=<C-r>z<cr><esc>

nnoremap <silent> <leader>i :call Idea()<cr>

" Calling external commands
nnoremap <leader>c :!clear<cr><cr>:echo "Terminal Cleared"<cr>

" Run the current line as a command and read in the output
" nnoremap <leader>q !!sh<cr>

" Edit Bash Profile
nnoremap <leader>eb :tabe ~/.bash_profile<cr>

" Source Bash Profile
nnoremap <leader>sb :!source ~/.bash_profile<cr>

" Edit vimrc 
nnoremap <leader>ev :tabe $MYVIMRC<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit tmux config
nnoremap <leader>et :tabe ~/.tmux.conf<cr>

" Source tmux config
nnoremap <leader>st :!tmux source-file ~/.tmux.conf<cr>

" }}}

" Autocommands {{{
" ====================
augroup text
	autocmd!
	autocmd FileType text,unix :setlocal wrap spell foldmethod=indent
augroup END

augroup yaml
	autocmd!
	autocmd FileType yaml :call LongTab()
augroup END

augroup cpp
	autocmd!
	autocmd FileType cpp :call LongTab()
augroup END

augroup markdown
	autocmd!
	autocmd FileType markdown, :setlocal wrap spell foldmethod=indent
augroup END

augroup python
	autocmd!
	autocmd FileType python :setlocal list foldmethod=indent
	autocmd FileType python :setlocal commentstring=#\ %s
	autocmd FileType python :nnoremap <buffer> <leader>t :!python2 <C-r>%<cr>
	autocmd FileType python :call PyTab()
augroup END

augroup javascript
	autocmd!
	autocmd FileType javascript :nnoremap <buffer> <leader>t :!node <C-r>%<cr>
	autocmd FileType javascript :cnoreabbr  <buffer> lint !./node_modules/.bin/eslint % 
	autocmd FileType javascript :cnoreabbr  <buffer> lintfix !npm run lint:fix
	autocmd FileType javascript :call LongTab()
augroup END

augroup bash
	autocmd!
	autocmd FileType sh :setlocal commentstring=#\ %s
	autocmd FileType sh :nnoremap <buffer> <leader>t :!%<cr>
augroup END

augroup html
	autocmd!
	autocmd FileType html :setlocal nowrap
augroup END

augroup C
	autocmd!
	autocmd FileType c :setlocal list foldmethod=syntax
	autocmd FileType c :iabbrev <buffer> xmain int main()<cr>{<cr><cr>}<esc>ki	<bs>
augroup END

augroup vim
	autocmd!
	autocmd FileType vim :setlocal foldmethod=marker
	autocmd FileType vim :setlocal foldlevelstart=0
augroup END
" }}}

" Color Scheme {{{
" ====================
hi clear
" colorscheme monokai-phoenix
colorscheme molokai
" colorscheme firewatch
" colorscheme badwolf
" colorscheme sky
" colorscheme brogrammer

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

iabbrev xdatef <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr><cr><c-r>a
iabbrev xdate <c-r>=strftime("%H:%M:%S")<cr><cr><c-r>a

iabbrev xbash #!/bin/bash
iabbrev xpython #!/usr/bin/python

" Turn sleep on and off (OSX)
cnoreabbr caf !caffeinate -d&
cnoreabbr kcaf !killall caffeinate

" Todo: use retab instead
cnoreabbr xwhite %s/    /\t/g

cnoreabbr makec make! clean; make -j
cnoreabbr makel make! load_elf -j

cnoreabbr count %s///gn
cnoreabbr double %s/'/"/g
cnoreabbr single %s/"/'/g

" }}}

" Functions {{{
" ===================
function! Idea()
	let filename = expand(system("~/bin/idea -v"))
	execute "edit" filename
endfunction

function! ShortTab()
	let &l:tabstop = 2
	let &l:shiftwidth = 2
	let &l:softtabstop = 2
	let &l:expandtab = 1
	exe "retab"
endfunction

function! LongTab()
	let &l:tabstop = 4
	let &l:shiftwidth = 4
	let &l:softtabstop = 4
	let &l:expandtab = 1
	exe "retab"
endfunction

function! PyTab()
	let &l:tabstop = 4
	let &l:shiftwidth = 4
	let &l:softtabstop = 4
	let &l:expandtab = 0
	exe "retab"
endfunction

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
" ignore .o files - see :h NERDTreeIgnore
let NERDTreeIgnore=['\.o$[[file]]', '\.py[cdo]$[[file]]', 'node_modules$[[dir]]']
let g:NERDTreeWinSize = 30

" Close vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" set winfixwidth

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
" luna
" murmur
" sky
" wombat

let g:airline_theme= 'murmur'

" let g:airline#extensions#bufferline#enabled = 1
"
" let g:airline#extensions#branch#enabled = 1
"
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#tab_nr_type = 1 " splits and tab number
" let g:airline#extensions#tabline#show_tabs = 1   " shows tabs regardless of num
"
" let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" let g:airline_symbols.branch = ''
"
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline_section_warning = '[syntastic]'
" let g:airline#extensions#whitespace#checks = 'long'

" }}}

" Syntastic {{{
" ======================
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {'mode': 'active', 'active_filetypes': ['python', 'html', 'css', 'scss', 'javascript'] }

let g:syntastic_error_symbol = '🚫'
let g:syntastic_warning_symbol = '🔮'

" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn

let g:syntastic_cpp_compiler = "clang++"
let g:syntastic_cpp_compiler_options = " -std=c++11 -stdlib=libc++"

let g:syntastic_python_flake8_args='--ignore=E501,E302,E128,W191,F403,E402'

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let g:jsx_ext_required = 0
" }}}

" Fugitive {{{
" ======================

" Autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

cnoreabbr Gco Git co
cnoreabbr Gbranch Git branch
cnoreabbr Gca Gcommit --amend --no-edit
cnoreabbr Gcb Git co -b
" }}} 

" UltiSnips {{{
" ======================
" set rtp^=$HOME
let g:UltiSnipsSnippetsDir="/Users/sidneywijngaarde/.config/nvim/UltiSnips/"
"let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" }}}

" }}}
