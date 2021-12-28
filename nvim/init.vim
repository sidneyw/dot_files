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
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'kyazdani42/nvim-tree.lua', { 'tag': 'c75e4a63b73f223a80835ab3b75f602dc3e60e66' }
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

" " Coc {{{
" " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" " \ 'coc-go',
" let g:coc_global_extensions = [
"       \ 'coc-lua',
"       \ 'coc-css',
"       \ 'coc-emmet',
"       \ 'coc-html',
"       \ 'coc-json',
"       \ 'coc-prettier',
"       \ 'coc-python',
"       \ 'coc-snippets',
"       \ 'coc-tsserver',
"       \ 'coc-ultisnips',
"       \ 'coc-vimlsp',
"       \ 'coc-yaml',
"       \ ]
" " }}}

" Nvim LSP {{{
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'

" For ultisnips users.
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" set completeopt=menu,menuone,noselect

" Plug 'glepnir/lspsaga.nvim'
Plug 'tami5/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
" }}}

" Telescope {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
" Plug 'fannheyward/telescope-coc.nvim'
Plug 'fhill2/telescope-ultisnips.nvim'
" }}}

" Lualine {{{
Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/tabline.nvim'
" Plug 'akinsho/bufferline.nvim'
" Plug 'romgrk/barbar.nvim'
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
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
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
set background=dark
let g:gruvbox_contrast_dark = 'hard'
Plug 'morhetz/gruvbox'
" }}}

Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'rcarriga/nvim-notify'
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

lua require("sidneyw")

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
nnoremap <leader>te :TablineTabNew %<CR>
" nnoremap <leader>te :tabe %<CR>
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
nnoremap <leader>ev :call EditVimrc()<cr>

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

" Delayed to allow the tab to load before attempting to name it.
" TablineTabRename cannot be called before the window comes up.
augroup name-tab
  autocmd VimEnter * call timer_start(200, { tid -> execute("lua require'sidneyw.lualine'.cwdTab()")})
augroup end

command! -nargs=1 -complete=dir Tabcd lua require'sidneyw.lualine'.tabcd(<f-args>)

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

function! EditVimrc()
  let dotfilesDir = fnameescape($HOME . '/.dot_files/nvim/')
  let initVim = l:dotfilesDir . fnameescape("init.vim")
  let initLua = l:dotfilesDir . fnameescape('/lua/sidneyw/init.lua')

  exe "TablineTabNew " . l:initLua
  " call TabCd(l:dotfilesDir)
  " exe "edit " . l:initLua
  exe "Glcd"
  exe "vs " . l:initVim
  exe "TablineTabRename DotFiles"
endfunction

function! EditDot(file)
  let path = $HOME . '/.dot_files/' . a:file
  execute "tabe " . fnameescape(l:path)
  execute "Glcd"
endfunction

" }}}

" Plugins {{{
" ===================

" Black {{{
let g:black_linelength=100
" }}}

" Bufferline {{{
" ======================
let g:bufferline_echo = 0
" }}}

" Dap {{{
nnoremap <silent> <leader>dt :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dc :lua require('dap').continue()<CR>
nnoremap <silent> <leader>td :lua require('dap-go').debug_test()<CR>
nnoremap <silent> <leader>dv :lua require"telescope".extensions.dap.variables{}<CR>
nnoremap <silent> <leader>do :lua require("dapui").toggle()<CR>
" }}}

" LSP {{{
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <C-\> :SymbolsOutline<cr>

nnoremap go <cmd>Lspsaga preview_definition<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap ga <cmd>Lspsaga code_action<CR>
nnoremap gt <cmd>lua vim.lsp.buf.type_definition()<CR>

nnoremap K     <cmd>Lspsaga hover_doc<CR>
nnoremap <C-k> <cmd>Lspsaga signature_help<CR>

nnoremap <silent> gi <cmd>lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap <silent> gr <cmd>lua require('telescope.builtin').lsp_references()<CR>

nnoremap <localleader>dd :vsp<cr>:lua vim.lsp.buf.definition()<cr>
nnoremap <localleader>dt :tab<cr>:lua vim.lsp.buf.definition()<cr>

nnoremap <silent> gn <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gp <cmd>Lspsaga diagnostic_jump_prev<CR>

nnoremap <silent> <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>

augroup go-fmt
	autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
	autocmd BufWritePre *.go lua require'sidneyw.lsp'.goimports(1000)
augroup END

" }}}

" NVIM Tree {{{
nnoremap <C-n> :NvimTreeFindFileToggle<CR>
" }}}

" Telescope {{{
" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>lua require('sidneyw.telescope').project_files()<CR>
nnoremap <leader>f <cmd>lua require('sidneyw.telescope').project_files()<CR>
nnoremap <leader>a  <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>q  <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <leader>b  <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>h  <cmd>lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>m  <cmd>lua require('telescope.builtin').oldfiles()<CR>
" nnoremap <leader>fv <cmd>lua require('sidneyw.telescope').search_dotfiles({ hidden = true })<CR>
" nnoremap <leader>i  <cmd>lua require('sidneyw.telescope').implementations()<CR>
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

" UltiSnips {{{
" ======================
" set rtp^=$HOME
" let g:UltiSnipsExpandTrigger="<C-k>"
" let g:UltiSnipsJumpForwardTrigger="<C-l>"
" let g:UltiSnipsJumpBackwardTrigger="<C-j>"
" let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="/Users/sidneywijngaarde/.config/nvim/UltiSnips/"
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

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1
let g:python_highlight_all = 1
" }}}
