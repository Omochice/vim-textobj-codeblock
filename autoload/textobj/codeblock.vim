let s:save_cpo = &cpo
set cpo&vim

function! textobj#codeblock#outer() abort
  let l:head = search('```\s\?\w*\s*$', 'Wb')
  let l:tail = search('```\s*$', 'W')
  if l:head ==# 0 || l:tail ==# 0
    return 0 " no match
  endif
  return ['V', [0, l:head, 1, 0], [0, l:tail, 1, 0]]
endfunction

function! textobj#codeblock#innter() abort
  let l:head = search('```\s\?\w*\s*$', 'Wb')
  let l:tail = search('```\s*$', 'W')
  if l:head ==# 0 || l:tail ==# 0
    return 0  " no match
  endif
  if l:head+1 ==# l:tail
    return 0  " no code area in block
  endif
  return ['V', [0, l:head+1, 1, 0], [0, l:tail-1, 1, 0]]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
