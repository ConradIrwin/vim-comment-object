function! SelectComment()

  " TODO: What happens if a , or : is used in a comment-indicator?
  let comment_indicators=map(split(&com, ","),  'split(v:val, ":")[-1]')

  " Creates a regular expression that matches any line that starts with a
  " comment indicator.
  "
  " TODO: Handle the "f" flag and the "b" flag.
  let comment_regex="\\V\\^\\s\\*\\(" . join(map(comment_indicators, 'escape(v:val, "\\")'), "\\|") . "\\)"

  " bail if not a comment
  if match(getline("."), comment_regex) == -1
    return 
  endif

  " find the first commented line
  while line(".") - 1 && match(getline(line(".") - 1), comment_regex) > -1
    normal k
  endwhile

  " start selecting
  normal V

  " find the last commented line
  while line(".") < line("$") &&  match(getline(line(".") + 1), comment_regex) > -1
    normal j
  endwhile
endfunction

vnoremap ac :<C-U>silent! call SelectComment()<CR>
omap ac :normal vic<CR>

" TODO: In the case that a comment has different start and end delimeters from
" its extension character, we should exclude those lines.
vnoremap ic :<C-U>silent! call SelectComment()<CR>
omap ic :normal vic<CR>
