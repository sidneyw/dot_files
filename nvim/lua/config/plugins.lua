vim.cmd([[
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
]])
