"-----------------
" 04_functions.vim
"-----------------
function! CSVH(x)
  execute 'match Keyword /^\([^,]*,\)\{'.a:x.'}\zs[^,]*/'
  execute 'normal ^'.a:x.'f,'
endfunction
command! -nargs=1 Csvhl :call CSVH(<args>)



