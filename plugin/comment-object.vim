function! SelectComment()
  let curindent = indent(".")

  " bail if not a comment
  if getline(".")[curindent] != "#"
    return 
  endif

  " find the first commented line
  while line(".") - 1 && indent(line(".") - 1) == curindent && getline(line(".") - 1)[curindent] == "#"
    normal k
  endwhile

  " start selecting
  normal V

  " find the last commented line
  while line(".") < line("$") && indent(line(".") + 1) == curindent && getline(line(".") + 1)[curindent] == "#"
    normal j
  endwhile
endfunction

vnoremap ic :<C-U>silent! call SelectComment()<CR>
omap ic :normal vic<CR>
