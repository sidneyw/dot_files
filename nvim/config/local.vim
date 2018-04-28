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

set inccommand=split " Interactive substitute

set shell=bash\ --login " make the sh command source the bash_profile
set backupcopy=yes      " For webpack hot reloading

"set list
set listchars=tab:▸\ ,eol:¬

set noshowmode   " Gets rid of the original showing of modes in vim
set laststatus=2 " Shows the status bar even if there is only one file

let mapleader='-'
let maplocalleader = "\\"

let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
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


" Change Tmux Line color scheme
nnoremap <leader>z :Tmuxline airline_insert<cr>

" See the full file path 
nnoremap <leader>p :echo expand("%:p")<cr>

" Open and close the quickfix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
"
" Open and close the location list
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>lo :lopen<cr>

" Change CWD for the window to the dir of the current file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Eval till = char
nnoremap <leader>= vt="zyf=a <C-r>=<C-r>z<cr><esc>

nnoremap <silent> <leader>i :call Idea()<cr>

" Calling external commands
nnoremap <leader>c :!clear<cr><cr>:echo "Terminal Cleared"<cr>

" Run the current line as a command and read in the output
" nnoremap <leader>q !!sh<cr>

nnoremap <leader>ue :UltiSnipsEdit<cr>
" Edit Bash Profile
nnoremap <leader>eb :tabe ~/.bash_profile<cr>

" Source Bash Profile
nnoremap <leader>sb :!source ~/.bash_profile<cr>

" Edit vimrc
nnoremap <leader>ev :call EditRC()<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit tmux config
nnoremap <leader>et :tabe ~/.tmux.conf<cr>

" Source tmux config
nnoremap <leader>st :!tmux source-file ~/.tmux.conf<cr>

vnoremap <leader>s :sort<cr>
" }}}

" Autocommands {{{
" ====================
augroup text
  autocmd!
  autocmd FileType text,unix :setlocal wrap spell foldmethod=indent
augroup END

augroup yaml
  autocmd!
  autocmd FileType yaml :call ShortTab()
augroup END

augroup cpp
  autocmd!
  autocmd FileType cpp :call LongTab()
augroup END

augroup markdown
  autocmd!
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FileType markdown, :setlocal wrap spell foldmethod=indent
  autocmd FileType markdown, :colorscheme badwolf
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
  autocmd FileType javascript :call ShortTab()
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
  autocmd FileType c :iabbrev <buffer> xmain int main()<cr>{<cr><cr>}<esc>ki  <bs>
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
" colorscheme molokai
" colorscheme firewatch
colorscheme badwolf
" colorscheme sky
" colorscheme brogrammer
" colorscheme turtles

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
cnoreabbr bad colorscheme badwolf

cnoreabbr count %s///gn
cnoreabbr double %s/'/"/g
cnoreabbr single %s/"/'/g
" Env to JSON
cnoreabbr etj s/\(\w*\)=\(.*$\)/"\1": "\2",/
" JSON to Env
cnoreabbr jte s/"\(\w*\)": "\(.*\)"/export \1="\2"/

"JSON to graphql
cnoreabbr jtg s/:.*[ {}]\@<!//
" }}}

" Functions {{{
" ===================
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

function! EditRC()
  tabe $HOME/.config/nvim/config/vim-bootstrap.vim
  vs $HOME/.config/nvim/config/local.vim
endfunction

" }}}

" Plugins stuff {{{
" ===================
" Plugin list
" NerdTree
" Bufferline
" Tmux
" Airline
" Deoplete
" Tern
" Syntastic
" Fugitive
" Ultisnips

" NERDTree {{{
" ======================
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" ignore .o files - see :h NERDTreeIgnore
" let NERDTreeIgnore=['\.o$[[file]]', '\.py[cdo]$[[file]]', 'node_modules$[[dir]]']
" let g:NERDTreeWinSize = 30

" Close vim if nerdtree is the only window open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" set winfixwidth

" }}}

" Bufferline {{{
" ======================
let g:bufferline_echo = 0
" }}}

" vim-highlightedyank {{{
let g:highlightedyank_highlight_duration = 200
" }}}

" Markdown
let g:markdown_fenced_languages = ['html', 'javascript', 'python', 'bash=sh']


" Airline {{{
" ======================
" badwolf
" dark
" durant
" luna
" murmur
" sky
" wombat

let g:airline_theme= 'murmur'
" }}}

" Deoplete {{{
" ===================
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:echodoc_enable_at_startup=1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-k>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'javascriptcomplete#CompleteJS',
  \ 'jspc#omni'
\]

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" }}}

" Tern {{{
" ===================
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  let g:tern_map_keys = 1
endif
" }}}

" NeoMake {{{
autocmd! BufWritePost,BufEnter * Neomake
" let g:neomake_error_sign= { 'text': '🚫', 'texthl': 'ErrorMsg' }
" let g:neomake_warning_sign= { 'text': '⚠️', 'texthl': 'WaningMsg' }
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E501,E302,E128,W191,F403,E402',  '--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }

let g:neomake_python_enabled_makers = ['flake8']
" let g:neomake_go_enabled_makers = ['govet']
" }}}

" Prettier {{{
" ===================
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1
" autocmd BufWritePre *.js,*.css,*.scss,*.less,*.json PrettierAsync

" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 100

" single quotes over double quotes
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'true'
" }}}

" Fugitive {{{
" ======================

" Autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

cnoreabbr Gco Git co
cnoreabbr Gbranch Git branch
cnoreabbr Gca Gcommit --amend --no-edit
cnoreabbr Gcb Git co -b
cnoreabbr Gstash Git stash
cnoreabbr Gapply Git stash apply

let g:github_enterprise_urls = ['https://github.ibm.com']
" " }}}

" UltiSnips {{{
" ======================
" set rtp^=$HOME
let g:UltiSnipsSnippetsDir="/Users/sidneywijngaarde/.config/nvim/UltiSnips/"
" }}}

" Deoplete {{{
" ===================
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:echodoc_enable_at_startup=1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-k>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
