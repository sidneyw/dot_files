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

" NVIM Tree {{{
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua', { 'tag': 'c75e4a63b73f223a80835ab3b75f602dc3e60e66' }
" }}}

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
" }}}

" Coc {{{
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
			\ 'coc-go',
			\ 'coc-lua',
			\ 'coc-css',
			\ 'coc-emmet',
			\ 'coc-html',
			\ 'coc-json',
			\ 'coc-prettier',
			\ 'coc-python',
			\ 'coc-snippets',
			\ 'coc-tsserver',
			\ 'coc-ultisnips',
			\ 'coc-vimlsp',
			\ 'coc-yaml',
			\ ]
" }}}
"
" Telescope {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'fhill2/telescope-ultisnips.nvim'
" }}}

" Lualine {{{
Plug 'nvim-lualine/lualine.nvim'
" Plug 'kdheepak/tabline.nvim'
Plug 'akinsho/bufferline.nvim'
" }}}

Plug 'liuchengxu/vista.vim'
let g:vista_sidebar_width = 50
let g:vista_fzf_preview = ['right:50%']

" Junegunn {{{
Plug 'junegunn/goyo.vim'
"}}} 

" Go Lang Bundle {{{
" Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
let g:go_bin_path= $HOME . "/go/bin"
" }}}

" HTML Bundle {{{
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-markdown'
Plug 'mattn/emmet-vim'
" }}}

" Javascript Bundle {{{
" Plug 'othree/yajs.vim'
" Plug 'elzr/vim-json', { 'for': ['javascript', 'javascript.jsx', 'json'] }
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
" }}}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'towolf/vim-helm'

" Typescript Bundle {{{
" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
" }}}

" Python Bundle {{{
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'psf/black', { 'tag': '19.10b0' }
" }}}

" Other {{{
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'airblade/vim-gitgutter'

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'vim-scripts/CSApprox'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'
Plug 'kristijanhusak/vim-carbon-now-sh'
let g:carbon_now_sh_options = {'t': 'monokai'}
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

if v:version >= 703
  Plug 'Shougo/vimshell.vim'
endif

if v:version >= 704
  " Snippets
  Plug 'SirVer/ultisnips'
endif

Plug 'honza/vim-snippets'
" }}}

" Color {{{
" Plug 'tomasr/molokai'
" Plug 'flazz/vim-colorschemes'

set background=dark
" Plug 'rktjmp/lush.nvim'
" Plug 'ellisonleao/gruvbox.nvim'

let g:gruvbox_contrast_dark = 'hard'
Plug 'morhetz/gruvbox'
" }}}

" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}


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

set cmdheight=2 " Better display for messages
set updatetime=500 " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c
set signcolumn=yes  " always show signcolumns

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
set textwidth=80

set foldlevelstart=15   " most folds should be open on start

set lazyredraw          " Don't redraw the screen during a macro
set mat=1               " How many seconds to blink on a matched paren
set backspace=indent,eol,start " Backspace for insert mode
set ruler

set inccommand=split " Interactive substitute

" set shell=bash\ --login " make the sh command source the bash_profile
set backupcopy=yes      " For webpack hot reloading
set shell=/bin/sh

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

" Term color stuff
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

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
set nowritebackup

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

" Tpope fugitive vim expects netrw which is disabled by nvim-tree
let g:loaded_netrwPlugin = 1
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

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Create Splits
" noremap <leader>h :<C-u>split<CR>
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
" nnoremap <leader>p :echo expand("%:p")<cr>

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
nnoremap <leader>eb :call EditDot("shell/bash_profile.sh")<cr>

" Edit vimrc
nnoremap <leader>ev :call EditDot("nvim/init.vim")<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit tmux config
nnoremap <leader>et :call EditDot("tmux/tmux.conf")<cr>

" Launch Terminal
nnoremap <silent> <leader>sh :terminal<CR>

if has('nvim')
	" Use escape to enter normal mode in a terminal buffer
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif

vnoremap <leader>s :sort<cr>

" }}}

" Autocommands {{{
" ====================
" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
" augroup vimrc-sync-fromstart
"   autocmd!
"   autocmd BufEnter * :syntax sync maxlines=200
" augroup END

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

augroup gitcommit
  autocmd!
  autocmd FileType gitcommit :setlocal wrap spell textwidth=72
augroup END

augroup yaml
  autocmd!
  autocmd BufNewFile,BufRead *.yml,*.yaml setlocal filetype=helm
	autocmd FileType yaml,helm :call ShortTab()
augroup END

augroup helm
	autocmd!
	autocmd FileType helm :setlocal commentstring=#\ %s
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
  " autocmd FileType markdown, :colorscheme badwolf
augroup END

augroup starlark
  autocmd!
  autocmd BufNewFile,BufReadPost *.star set filetype=python
augroup END

augroup python
  autocmd!
  autocmd FileType python :setlocal list foldmethod=indent
  autocmd FileType python :setlocal commentstring=#\ %s
  autocmd FileType python :call PyTab()
	autocmd BufWritePre *.py execute ':Black'
augroup END

augroup javascript
  autocmd!
  autocmd FileType javascript :call ShortTab()
  autocmd FileType javascript setlocal foldmethod=syntax
  " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
  " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.yml,*.html Prettier
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
augroup END

augroup vim
  autocmd!
  autocmd FileType vim :setlocal foldmethod=marker
  " autocmd FileType vim :setlocal foldlevelstart=0
augroup END
" }}}

" Color Scheme {{{
" ====================
" hi clear
" colorscheme monokai-phoenix
" colorscheme badwolf
" colorscheme onedark
colorscheme gruvbox
" colorscheme nightfox
" colorscheme srcerydrk
" colorscheme papercolor
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

" Open Help in it's own tab
cnoreabbr th tab h

" Turn sleep on and off (OSX)
cnoreabbr caf !caffeinate -d&
cnoreabbr kcaf !killall caffeinate

" Quotes
cnoreabbr double %s/'/"/g
cnoreabbr single %s/"/'/g

" Env to JSON
cnoreabbr etj s/\(\w*\)=\(.*$\)/"\1": "\2",/
" JSON to Env
cnoreabbr jte s/"\(\w*\)": "\(.*\)"/export \1="\2"/

"JSON to graphql
cnoreabbr jtg s/:.*[ {}]\@<!//

cnoreabbr mg make gen

cnoreabbr cheat tabe ~/.dot_files/cheatsheets/
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
	" execute "lcd " . a:dir
	execute "Glcd"
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

command! -nargs=1 Scratch call ScratchFn(<f-args>)

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

function! EditDot(file)
	let path = $HOME . '/.dot_files/' . a:file
  execute "tabe " . fnameescape(l:path)
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

" let g:airline_theme = 'badwolf'
" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#coc#enabled = 1
" let g:airline_skip_empty_sections = 1

" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif

" if !exists('g:airline_powerline_fonts')
"   let g:airline#extensions#tabline#left_sep = ' '
"   let g:airline#extensions#tabline#left_alt_sep = '|'
"   " let g:airline_left_sep          = '▶'
"   let g:airline_left_alt_sep      = '»'
"   " let g:airline_right_sep         = '◀'
"   let g:airline_right_alt_sep     = '«'
"   let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
"   let g:airline#extensions#readonly#symbol   = '⊘'
"   let g:airline#extensions#linecolumn#prefix = '¶'
"   let g:airline#extensions#paste#symbol      = 'ρ'
"   let g:airline_symbols.linenr    = '␊'
"   let g:airline_symbols.branch    = '⎇'
"   let g:airline_symbols.paste     = 'ρ'
"   let g:airline_symbols.paste     = 'Þ'
"   let g:airline_symbols.paste     = '∥'
"   let g:airline_symbols.whitespace = 'Ξ'
" else
"   let g:airline#extensions#tabline#left_sep = ''
"   let g:airline#extensions#tabline#left_alt_sep = ''

"   " powerline symbols
"   let g:airline_left_sep = ''
"   let g:airline_left_alt_sep = ''
"   let g:airline_right_sep = ''
"   let g:airline_right_alt_sep = ''
"   let g:airline_symbols.branch = ''
"   let g:airline_symbols.readonly = ''
"   let g:airline_symbols.linenr = ''
" endif
" }}}

" Black {{{
let g:black_linelength=100
" }}}

" Bufferline {{{
" ======================
let g:bufferline_echo = 0
" }}}

" Coc.nvim {{{
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

augroup coc
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `gp` and `gn` for navigate diagnostics
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> <localleader>dd :call CocAction('jumpDefinition', 'vsplit')<CR>
nnoremap <silent> <localleader>dt :call CocAction('jumpDefinition', 'tabe')<CR>

nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

vmap <localleader>p  <Plug>(coc-format-selected)
nmap <localleader>p  <Plug>(coc-format-selected)

command! -nargs=0 Format :call CocAction('format')<Paste>

" " Remap for rename current word
nmap <localleader>R <Plug>(coc-rename)

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
				 \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-l>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-j>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

augroup coc-go
	autocmd BufWritePost *.go !go fmt %
	autocmd BufWritePost *.go CocFix
  autocmd BufWritePost *.go silent! call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

noremap <localleader>gt :call GoTestToggle()<CR>

function! GoTestToggle()
  execute "vsplit"
  execute "CocCommand go.test.toggle"
endfunction

" }}}

" Telescope {{{
" Find files using Telescope command-line sugar.
lua require("sidneyw")

nnoremap <C-p> <cmd>lua require('sidneyw.telescope').project_files()<CR>
nnoremap <leader>a  <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>q  <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <leader>b  <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>h <cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>m  <cmd>lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>fv <cmd>lua require('sidneyw.telescope').search_dotfiles({ hidden = true })<CR>
nnoremap <leader>i <cmd>lua require('sidneyw.telescope').implementations()<CR>
" }}}

" Fzf {{{
" set wildmode=list:longest,list:full
" set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__


" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
" 	\ 'bg':      ['bg', 'Normal'],
" 	\ 'hl':      ['fg', 'Comment'],
" 	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
" 	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
" 	\ 'hl+':     ['fg', 'Statement'],
" 	\ 'info':    ['fg', 'PreProc'],
" 	\ 'border':  ['fg', 'Ignore'],
" 	\ 'prompt':  ['fg', 'Conditional'],
" 	\ 'pointer': ['fg', 'Exception'],
" 	\ 'marker':  ['fg', 'Keyword'],
" 	\ 'spinner': ['fg', 'Label'],
" 	\ 'header':  ['fg', 'Comment'] }

" " Rip Grep
" if executable('rg')
" let $FZF_DEFAULT_COMMAND = 'rg --files'
" endif

" nnoremap <silent> <leader>a :Rg<CR>
" nnoremap <silent> <leader>b :Buffers<CR>
" nnoremap <silent> <leader>f :call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))<CR>
" nnoremap <silent> <leader>y :call fzf#vim#gitfiles('?', fzf#vim#with_preview('right'))<CR>
" nnoremap <silent> <leader>m :History -m<CR>
" nnoremap <silent> <leader>c :Commands<CR>
" nnoremap <silent> <leader>q :BLines<CR>
" nnoremap <silent> <leader>w :Windows<CR>
" }}}

" Fugitive {{{
" ======================
" Autoclean fugitive buffers
autocmd! BufReadPost fugitive://* set bufhidden=delete

" Mappings
noremap <leader>ga  :Gwrite<CR>
noremap <leader>gb  :Git blame<CR>
noremap <leader>gc  :Git commit<CR>
noremap <leader>gd  :Gvdiff<CR>
noremap <leader>gh  :!gh-launch<CR>
noremap <leader>glc :Glcd<CR>
noremap <leader>gll :Git pull<CR>
noremap <leader>gr  :Gremove<CR>
noremap <leader>gs  :Git<CR>
noremap <leader>gu  :Git push -u<CR>
"
" Open current line on github
nnoremap <leader>gn :.GBrowse<CR>
vnoremap <leader>gn :'<,'>GBrowse<CR>

" Copy the github link to the clipboard
nnoremap <leader>go :.GBrowse!<CR>
vnoremap <leader>go :'<,'>GBrowse!<CR>

cnoreabbr Gco Git co
cnoreabbr Gpush Git push
cnoreabbr Gcommit Git commit
cnoreabbr Gcb Git co -b
cnoreabbr Gstash Git stash
" " }}}

" Git Signs {{{
lua <<EOF
require('gitsigns').setup()
EOF
" }}}

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

" NVIM Tree {{{
" let g:nvim_tree_side = 'right' "left by default
let g:nvim_tree_width = 40 "30 by default, can be width_in_columns or 'width_in_percent%'
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 0 "0 by default, closes the tree when it's the last window
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_auto_resize = 0 "1 by default, will resize the tree to its saved width when opening a file
let g:nvim_tree_disable_netrw = 1 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 1 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_hijack_cursor = 1 "1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_update_cwd = 1 "0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
" }}}

" UltiSnips {{{
" ======================
" set rtp^=$HOME
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-j>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="/Users/sidneywijngaarde/.config/nvim/UltiSnips/"
" }}}

"  Vim Go {{{
"" ===================
"" run :GoBuild or :GoTestCompile based on the go file
"function! s:build_go_files()
"  let l:file = expand('%')
"  if l:file =~# '^\f\+_test\.go$'
"    call go#cmd#Test(0, 1)
"  elseif l:file =~# '^\f\+\.go$'
"    call go#cmd#Build(0)
"  endif
"endfunction
"
"" let g:go_def_mode = 'guru'
"" let g:go_referrers_mode = 'guru'
"" let g:go_implements_mode = 'guru'
"let g:go_list_type = "quickfix"
"" let g:go_fmt_fail_silently = 1
"let g:go_fmt_command = "goimports"
"
"let g:go_auto_type_info = 1
"" Uncomment to highlight variable references
"" let g:go_auto_sameids = 1
"let g:go_highlight_array_whitespace_error = 0
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_fields = 1
"let g:echodoc#highlight_trailing = 1
"let g:go_highlight_function_arguments = 1
"let g:go_highlight_function_calls = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_generate_tags = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_space_tab_error = 0
"let g:go_highlight_structs = 1
"let g:go_highlight_trailing_whitespace_error = 0
"let g:go_highlight_types = 1
"
"let g:go_fmt_experimental = 1
"let g:go_doc_popup_window = 1
"let g:go_def_mapping_enabled = 1
"let g:go_metalinter_disabled = []
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"
"autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
"
"augroup completion_preview_close
"  autocmd!
"  if v:version > 703 || v:version == 703 && has('patch598')
"    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
"  endif
"augroup END
"
"augroup go
"  au!
"	autocmd BufWritePost *.go !go fmt %
"	"" autocmd BufWritePost *.go CocFix
"  " autocmd BufWritePost *.go silent! call CocAction('runCommand', 'editor.action.organizeImport')
"	""
"  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
"  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
"  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
"  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
"
"	au Filetype go nmap <localleader>ae <Plug>(go-alternate-edit)
"	au Filetype go nmap <localleader>ah <Plug>(go-alternate-split)
"	au Filetype go nmap <localleader>a  <Plug>(go-alternate-vertical)
"
"	" gd = :GoDef
"	" <C-t> :GoDefPop
"	" K :GoDoc press enter to quit
"	" :GoDescribe shows all information about a type
"	" :GoChannelPeers shows all sends and recvs from a channel
"	" :GoCallers :Gocallees show where functions are used
"	" :GoWhichErrs shows what type an error might be
"	" au Filetype go nnoremap <localleader>p :GoImport<space>
"
"  au FileType go nmap gt <Plug>(go-def-type)
"  au FileType go nmap <localleader>dd <Plug>(go-def-vertical)
"  au FileType go nmap <localleader>dv <Plug>(go-doc-vertical)
"  au FileType go nmap <localleader>db <Plug>(go-doc-browser)
"
"  au FileType go nmap <localleader>r  <Plug>(go-run)
"  " au FileType go nmap <localleader>n :GoReferrers<cr>
"  au FileType go nmap <localleader>t  <Plug>(go-test)
"  au FileType go nmap <localleader>c  <Plug>(go-coverage-toggle)
"  " au FileType go nmap gi  <Plug>(go-implements)
"  au FileType go nnoremap <silent> <localleader>l <Plug>(go-metalinter)
"
"  au FileType go nnoremap <localleader>gd :GoDeclsDir<cr>
"
"  au FileType go nnoremap <localleader>b :GoDebugBreakpoint<cr>
"augroup END
"" }}}

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

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1
let g:python_highlight_all = 1
" }}}
