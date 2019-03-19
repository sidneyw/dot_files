" Vim Plug {{{
" ====================
" Init {{{
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,go,html,javascript,python"
let g:vim_bootstrap_editor = "nvim"       " nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
" }}}

" NERDTree {{{
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
" "}}}

" Tpope {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" }}}

" Shougo {{{
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neco-vim'
" }}}

" Junegunn {{{
Plug 'junegunn/goyo.vim'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
" }}}

" Other {{{
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/CSApprox'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'machakann/vim-highlightedyank'
Plug 'neomake/neomake'
Plug 'Yggdroot/indentLine'
Plug 'avelino/vim-bootstrap-updater'
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

if v:version >= 703
  Plug 'Shougo/vimshell.vim'
endif

if v:version >= 704
  "" Snippets
  Plug 'SirVer/ultisnips'
endif

Plug 'honza/vim-snippets'

" Color
Plug 'tomasr/molokai'
Plug 'flazz/vim-colorschemes'

" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'
" }}}

" Go Lang Bundle {{{
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'jodosha/vim-godebug'
let g:go_bin_path= $HOME . "/go/bin"
" }}}
" Plug 'sheerun/vim-polyglot'

" HTML Bundle {{{
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-markdown'
Plug 'mattn/emmet-vim'
" }}}

" Javascript Bundle {{{
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'isRuslan/vim-es6', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'jparise/vim-graphql'
Plug 'elzr/vim-json', { 'for': ['javascript', 'javascript.jsx', 'json'] }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" }}}

" Python Bundle {{{
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
" }}}

" Typescript Bundle {{{
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'Quramy/tsuquyomi', { 'do': 'make -f make_mac.mak' }
Plug 'HerringtonDarkholme/yats.vim'
" }}}

" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Required:
filetype plugin indent on
" }}}

" General {{{
" ====================
let mapleader='-'
let maplocalleader = "\\"

" To allow \":Man cmd"
runtime! ftplugin/man.vim

set relativenumber number " Line numbers
syntax on

set autoread
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set autoindent                  " Sets autoindent
set colorcolumn=80      " Turn on the colored column at column 80
set cursorline
set nowrap              " Turn off line wraps
set showcmd             " Show commands in the bottom right corner
set spelllang=en_us
set t_ut=
set textwidth=80

set foldlevelstart=10   " most folds should be open on start
set foldmethod=indent

set lazyredraw          " Don't redraw the screen during a macro
set mat=1               " How many seconds to blink on a matched paren
set backspace=indent,eol,start " Backspace for insert mode
set ruler

set inccommand=split " Interactive substitute

" set shell=bash\ --login " make the sh command source the bash_profile
set backupcopy=yes      " For webpack hot reloading

"set list
set listchars=tab:▸\ ,eol:¬

set noshowmode   " Gets rid of the original showing of modes in vim
set laststatus=2 " Shows the status bar even if there is only one file

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

set fileformats=unix,dos,mac

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Directories for swp files
set nobackup
set noswapfile

" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif
" }}}

" Mappings {{{
" ====================
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

nnoremap <space> zt

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;

vnoremap ; :
vnoremap : ;

" Delete a function
nnoremap <leader>df vf{%d

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Create Splits
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <leader>te :tabe %<CR>
nnoremap <leader>tc :tabc<CR>

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

" Run the current line as a command and read in the output
" nnoremap <leader>q !!sh<cr>

nnoremap <leader>ue :UltiSnipsEdit<cr>

" Edit Bash Profile
nnoremap <leader>eb :tabe ~/.bash_profile<cr>

" Edit vimrc
nnoremap <leader>ev :call EditRC()<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit tmux config
nnoremap <leader>et :tabe ~/.tmux.conf<cr>

" Launch Terminal
nnoremap <silent> <leader>sh :terminal<CR>

vnoremap <leader>s :sort<cr>
" }}}

" Autocommands {{{
" ====================
" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

augroup text
  autocmd!
  autocmd FileType text,unix :setlocal wrap spell foldmethod=indent
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

augroup yaml
  autocmd!
  autocmd FileType yaml :call ShortTab()
augroup END

augroup cpp
  autocmd!
  autocmd FileType cpp :call LongTab()
augroup END


let g:markdown_syntax_conceal = 0
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
  autocmd FileType javascript :nnoremap <buffer> <leader>ne :!npx eslint --fix <C-r>%<cr>
  autocmd FileType javascript :call ShortTab()
  autocmd FileType javascript setlocal foldmethod=syntax
  autocmd BufWritePre *.js,*.css,*.scss,*.json,*.less,*.ts,*.tsx PrettierAsync
augroup END

augroup bash
  autocmd!
  autocmd FileType sh :setlocal commentstring=#\ %s
  autocmd FileType sh :nnoremap <buffer> <leader>t :!%<cr>
augroup END

augroup html
  autocmd!
  autocmd FileType html :setlocal nowrap
  autocmd Filetype html setlocal ts=2 sw=2 expandtab
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
" hi clear
" colorscheme monokai-phoenix
colorscheme badwolf
" colorscheme brogrammer
" colorscheme turtles
" colorscheme molokai_dark
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

cnoreabbr evim e $MYVIMRC
cnoreabbr bad colorscheme badwolf

cnoreabbr count %s///gn

" Quotes
cnoreabbr double %s/'/"/g
cnoreabbr single %s/"/'/g

" Env to JSON
cnoreabbr etj s/\(\w*\)=\(.*$\)/"\1": "\2",/
" JSON to Env
cnoreabbr jte s/"\(\w*\)": "\(.*\)"/export \1="\2"/

"JSON to graphql
cnoreabbr jtg s/:.*[ {}]\@<!//

cnoreabbr evim e $MYVIMRC
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

function! TabCd(dir)
	if !isdirectory(a:dir)
		echoerr a:dir . " is not a directory"
		return
	endif

	execute "tabe " . a:dir
	execute "lcd " . a:dir
endfunction


command! -nargs=1 -complete=dir Tabcd call TabCd(<f-args>)

" remap tabcd to Tabcd
cnoreabbr tabcd Tabcd

function! ScratchFn(fileExt)
	let curdate=system('date +%s')[:-2]
	let buffName="scratch-" . curdate . "." . a:fileExt
	execute "new " . l:buffName

	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endfunction

" remap scratch to Scratch
cnoreabbr scratch Scratch

command -nargs=1 Scratch call ScratchFn(<f-args>)

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

function! EditRC()
  tabe $HOME/.config/nvim/init.vim
	execute "Glcd"
endfunction

" }}}

" Plugins {{{
" ===================

" Airline {{{
" ======================

" badwolf
" dark
" durant
" luna
" murmur
" sky
" wombat
" powerlineish

" let g:airline_theme= 'murmur'
let g:airline_theme = 'murmur'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  " let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  " let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif
" }}}

" Bufferline {{{
" ======================
let g:bufferline_echo = 0
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
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'javascriptcomplete#CompleteJS',
  \ 'jspc#omni'
\]

let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

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

" Fzf {{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

nnoremap <silent> <leader>a :Ag<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))<CR>
nnoremap <silent> <leader>m :History -m<CR>
nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>q :BLines<CR>
nnoremap <silent> <leader>w :Windows<CR>
" }}}

" Fugitive {{{
" ======================
" Autoclean fugitive buffers
autocmd! BufReadPost fugitive://* set bufhidden=delete

" Mappings
noremap <leader>ga  :Gwrite<CR>
noremap <leader>gb  :Gblame<CR>
noremap <leader>gc  :Gcommit<CR>
noremap <leader>gd  :Gvdiff<CR>
noremap <leader>gh  :!gh-launch<CR>
noremap <leader>glc :Glcd<CR>
noremap <leader>gll :Gpull<CR>
noremap <leader>gr  :Gremove<CR>
noremap <leader>gs  :Gstatus<CR>
noremap <leader>gu  :Gpush -u<CR>
" Open current line on github
nnoremap <leader>go :.Gbrowse<CR>

cnoreabbr Gco Git co
cnoreabbr Gbranch Git branch
cnoreabbr Gca Gcommit --amend --no-edit
cnoreabbr Gcb Git co -b
cnoreabbr Gstash Git stash
cnoreabbr Gapply Git stash apply

let g:github_enterprise_urls = ['https://github.ibm.com']
" " }}}

" Goyo {{{
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" NeoMake {{{
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
" let g:neomake_scss_enabled_makers = ['stylelint']
" let g:neomake_scss_stylelint_maker = {
" 	\'args': ['--syntax', 'scss'],
" 	\ }

" let g:neomake_typescript_tslint_exe = system('PATH=$(npm bin):$PATH && which tslint | tr -d "\n"')
" let g:neomake_typescript_enabled_makers = ['tslint', 'tsc']

let g:neomake_python_flake8_maker = {
    \ 'args': ['--ignore=E501,E302,E128,W191,F403,E402',  '--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }

let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_go_enabled_makers = ['golint', 'govet']
" }}}

" NERDTree {{{
" ======================
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>

" setlet g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" }}}

" Prettier {{{
" ===================
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 1

" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 100

" single quotes over double quotes
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'true'
" }}}

" Tagbar {{{
" ======================
nnoremap <leader>tb :TagbarToggle<CR>
" }}}

" Tern {{{
" ===================
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  let g:tern_map_keys = 1
	" let g:tern#command = ["tern"]
	let g:tern#arguments = ["--persistent"]
endif
" }}}

" UltiSnips {{{
" ======================
" set rtp^=$HOME
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="/Users/sidneywijngaarde/.config/nvim/UltiSnips/"
" }}}

" Vim Go {{{
" ===================
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:syntastic_go_checkers = ['golint', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_auto_type_info = 1
" Uncomment to highlight variable references
" let g:go_auto_sameids = 1
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:echodoc#highlight_trailing = 1
" let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_types = 1

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go
  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

	au Filetype go nmap <localleader>ae <Plug>(go-alternate-edit)
	au Filetype go nmap <localleader>ah <Plug>(go-alternate-split)
	au Filetype go nmap <localleader>a  <Plug>(go-alternate-vertical)

	" gd = :GoDef
	" <C-t> :GoDefPop
	" K :GoDoc press enter to quit
	" :GoDescribe shows all information about a type
	" :GoChannelPeers shows all sends and recvs from a channel
	" :GoCallers :Gocallees show where functions are used
	" :GoWhichErrs shows what type an error might be
	au Filetype go nnoremap <localleader>p :GoImport<space>

  au FileType go nmap <localleader>dd <Plug>(go-def-vertical)
  au FileType go nmap <localleader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <localleader>db <Plug>(go-doc-browser)

  au FileType go nmap <localleader>r  <Plug>(go-run)
  au FileType go nmap <localleader>rb :<C-u>call <SID>build_go_files()<CR>
  au FileType go nmap <localleader>R  <Plug>(go-rename)
  au FileType go nmap <localleader>gr :GoReferrers<cr>
  au FileType go nmap <localleader>t  <Plug>(go-test)
  au FileType go nmap <localleader>c  <Plug>(go-coverage-toggle)
  au FileType go nmap <localleader>gi <Plug>(go-info)
  au FileType go nmap <localleader>i  <Plug>(go-implements)

  au FileType go nnoremap <silent> <localleader>l <Plug>(go-metalinter)

  au FileType go nnoremap <localleader>gd :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>


  au FileType go nnoremap <localleader>b :GoDebugBreakpoint<cr>
augroup END
" }}}

" Vim Highlighted Yank {{{
" ===================
let g:highlightedyank_highlight_duration = 200
" }}}

" Vim Python {{{
" ===================
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python', 'go']
let python_highlight_all = 1
" }}}
