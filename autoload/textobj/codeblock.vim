let s:save_cpo = &cpo
set cpo&vim

function! s:get_fence() abort
  let l:default = '```'
  let l:filetype = &filetype
  if l:filetype ==# ''
    return l:default
  endif
  return get(g:, 'textobj_codeblock_fence', {})->get(l:filetype, l:default)
endfunction

function! s:get_marker(fence) abort
  return [
        \ a:fence .. '\s\?\w*\s*$',
        \ a:fence .. '\s*$',
        \ ]
endfunction

function! textobj#codeblock#outer() abort
  let l:fence = s:get_fence()
  let [l:head_marker, l:tail_marker] = s:get_marker(l:fence)
  let l:head = search(l:head_marker, 'Wb')
  let l:tail = search(l:tail_marker, 'W')
  if l:head ==# 0 || l:tail ==# 0
    return 0 " no match
  endif
  return ['V', [0, l:head, 1, 0], [0, l:tail, 1, 0]]
endfunction

function! textobj#codeblock#inner() abort
  let l:fence = s:get_fence()
  let [l:head_marker, l:tail_marker] = s:get_marker(l:fence)
  let l:head = search(l:head_marker, 'Wb')
  let l:tail = search(l:tail_marker, 'W')
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
