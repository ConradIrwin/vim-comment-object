function! SelectComment()
  let curindent = indent(".")
  " Technically will allow for false positives with any multichar comments
  let commstr = &commentstring[0]

  " bail if not a comment
  if getline(".")[curindent] != commstr
    return 
  endif

  " find the first commented line
  while line(".") - 1 && indent(line(".") - 1) == curindent && getline(line(".") - 1)[curindent] == commstr
    normal k
  endwhile

  " start selecting
  normal V

  " find the last commented line
  while line(".") < line("$") && indent(line(".") + 1) == curindent && getline(line(".") + 1)[curindent] == commstr
    normal j
  endwhile
endfunction

vnoremap ac :<C-U>silent! call SelectComment()<CR>
omap ac :normal vic<CR>

" TODO: In the case that a comment has different start and end delimeters from
" its extension character, we should exclude those lines.
vnoremap ic :<C-U>silent! call SelectComment()<CR>
omap ic :normal vic<CR>
