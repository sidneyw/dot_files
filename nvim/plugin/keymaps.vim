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

" nnoremap <leader>ue :UltiSnipsEdit<cr>

if has('nvim')
  " Use escape to enter normal mode in a terminal buffer
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif

vnoremap <leader>s :sort<cr>
