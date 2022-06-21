if get(g:, 'loaded_textobj_codeblock', v:false)
  finish
endif
let g:loaded_textobj_codeblock = v:true

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('codeblock', {
      \ '-': {
      \   'select-a': [], 'select-a-function': 'textobj#codeblock#outer',
      \   'select-i': [], 'select-i-function': 'textobj#codeblock#innter',
      \ },
      \ })

let &cpo = s:save_cpo
unlet s:save_cpo
