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
" }}}

" Tpope {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-markdown'
" }}}

" Shougo {{{
Plug 'Shougo/denite.nvim'
" }}}

" Nvim LSP {{{
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'tjdevries/nlua.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/cmp-copilot'

Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'

Plug 'edolphin-ydf/goimpl.nvim'

" For luasnip users
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Copilot
" Plug 'github/copilot.vim'

Plug 'tami5/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
" }}}

"DAP {{{
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'leoluz/nvim-dap-go'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rcarriga/nvim-dap-ui'
"}}}

" Telescope {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'

Plug 'sudormrfbin/cheatsheet.nvim'

Plug 'dhruvmanila/telescope-bookmarks.nvim'
Plug 'benfowler/telescope-luasnip.nvim'
" Plug 'fhill2/telescope-ultisnips.nvim'
" }}}

" Lualine {{{
Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/tabline.nvim'
" }}}

" Go Lang Bundle {{{
" Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
let g:go_bin_path= $HOME . "/go/bin"
" }}}

" HTML Bundle {{{
Plug 'gorodinskiy/vim-coloresque'
Plug 'mattn/emmet-vim'
" }}}

" Treesitter {{{{
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
" }}}}

Plug 'towolf/vim-helm'

" Other {{{
Plug 'lewis6991/gitsigns.nvim'
Plug 'numToStr/Comment.nvim'

Plug 'vim-scripts/CSApprox'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'machakann/vim-highlightedyank'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'windwp/nvim-autopairs'

let g:carbon_now_sh_options = {'t': 'monokai'}
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif

Plug 'Shougo/vimproc.vim', {'do': g:make}

if v:version >= 703
 Plug 'Shougo/vimshell.vim'
endif

Plug 'honza/vim-snippets'
" }}}

" Color {{{
set background=dark
let g:gruvbox_contrast_dark = 'hard'
Plug 'morhetz/gruvbox'
" }}}

Plug 'rcarriga/nvim-notify'

" Rust {{{
Plug 'simrat39/rust-tools.nvim'
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

set cmdheight=2 " Better display for messages
set updatetime=500 " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c
set signcolumn=yes  " always show signcolumns

set autoread
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" set autoindent                  " Sets autoindent
set colorcolumn=80      " Turn on the colored column at column 80
set cursorline
set nowrap              " Turn off line wraps
set showcmd             " Show commands in the bottom right corner
set spelllang=en_us
set textwidth=80

set foldlevelstart=15   " most folds should be open on start

set lazyredraw          " Don't redraw the screen during a macro
set mat=1               " How many seconds to blink on a matched paren

set inccommand=split " Interactive substitute

" set shell=bash\ --login " make the sh command source the bash_profile
set backupcopy=yes      " For webpack hot reloading
set shell=/bin/sh

"set list
set listchars=tab:▸\ ,eol:¬

set noshowmode   " Gets rid of the original showing of modes in vim

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

" Use lua only file type detection
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0
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
" nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Eval till = char
nnoremap <leader>= vt="zyf=a <C-r>=<C-r>z<cr><esc>

" nnoremap <leader>ue :UltiSnipsEdit<cr>

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
  " autocmd BufWritePre *.py execute ':Black'
augroup END

augroup javascript
  autocmd!
  autocmd FileType javascript :call ShortTab()
  autocmd FileType javascript setlocal foldmethod=syntax
  " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
  " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.yml,*.html Prettier
augroup END

augroup proto
  autocmd!
  autocmd FileType proto :call LongTab()
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

" augroup snippets
" 	autocmd!
" 	autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets
" augroup END

augroup telescope
	autocmd!
	" Turn off auto complete for Telescope prompts
	autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { completion = { autocomplete = false } }
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

cnoreabbr mg Make! gen

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

function! ScratchFn()
  let curdate=system('date +%s')[:-2]
  let buffName="scratch-" . curdate
  execute "vsplit " . l:buffName

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
	Telescope filetypes
endfunction

" remap scratch to Scratch
cnoreabbr scratch Scratch

command!Scratch call ScratchFn()

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif
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

" LSP {{{
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <C-\> :SymbolsOutline<cr>

nnoremap go <cmd>Lspsaga preview_definition<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap ga <cmd>Lspsaga code_action<CR>
nnoremap gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <localleader>R <cmd>lua vim.lsp.buf.rename()<CR>
" for some reason the lsp saga rename window isn't able to accept backspaces
" nnoremap <localleader>R <cmd>Lspsaga rename<CR>

nnoremap K     <cmd>Lspsaga hover_doc<CR>
nnoremap <C-s> <cmd>Lspsaga signature_help<CR>

nnoremap <silent> gi <cmd>lua require('telescope.builtin').lsp_implementations()<CR>
nnoremap <silent> gr <cmd>lua require('telescope.builtin').lsp_references()<CR>

nnoremap <localleader>dd :vsp<cr>:lua vim.lsp.buf.definition()<cr>
nnoremap <localleader>dt :tab<cr>:lua vim.lsp.buf.definition()<cr>

nnoremap <silent> gn <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gp <cmd>Lspsaga diagnostic_jump_prev<CR>

nnoremap <silent> <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>

" augroup go-fmt
" 	autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
" 	autocmd BufWritePre *.go lua require'sidneyw.lsp'.goimports(1000)
" augroup END

" }}}

" Copilot {{{
" imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true
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

" UltiSnips {{{
" ======================
" set rtp^=$HOME
" let g:UltiSnipsExpandTrigger="<C-k>"
" let g:UltiSnipsJumpForwardTrigger="<C-l>"
" let g:UltiSnipsJumpBackwardTrigger="<C-j>"
" let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetsDir="/Users/sidneywijngaarde/.config/nvim/UltiSnips/"

imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : ''
" -1 for jumping backwards.
inoremap <silent> <C-j> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(-1)<Cr>
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
