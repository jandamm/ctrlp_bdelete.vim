if (exists('g:ctrlp_bdelete_loaded')) || &compatible
  finish
end
let g:ctrlp_bdelete_loaded = 1

if !exists('g:ctrlp_buffer_func')
  let g:ctrlp_buffer_func = {}
endif

call ctrlp_bdelete#store()

let g:ctrlp_buffer_func['enter'] = 'ctrlp_bdelete#mappings'
