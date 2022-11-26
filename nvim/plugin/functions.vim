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
