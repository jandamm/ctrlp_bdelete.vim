if (exists('g:ctrlp_bdelete_loaded')) || &compatible
  finish
end
let g:ctrlp_bdelete_loaded = 1

if !exists('g:ctrlp_buffer_func')
  let g:ctrlp_buffer_func = {}
endif

" don't clobbber any existing user setting
if has_key(g:ctrlp_buffer_func, 'enter')
  if g:ctrlp_buffer_func['enter'] !=# 'ctrlp_bdelete#mappings'
    let s:ctrlp_bdelete_user_func = g:ctrlp_buffer_func['enter']
  endif
endif

let g:ctrlp_buffer_func['enter'] = 'ctrlp_bdelete#mappings'
