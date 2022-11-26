lua require("sidneyw")

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
" }}}

" Plugins {{{
" ===================

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
