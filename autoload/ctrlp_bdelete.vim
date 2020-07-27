" ctrlp_bdelete.vim: An extension to ctrlp.vim for closing buffers.
"
" To use this plugin, install it with Vundle or Pathogen, then add
"   call ctrlp_bdelete#init()
" to your ~/.vimrc to initialize the ctrlp settings.
"
" When installed, you can use <C-@> in the ctrlp finder to delete open
" buffers. This also works for buffers marked with <C-z>.
"
" =============================================================================
" File: plugin/ctrlp_bdelete.vim
" Description: ctrlp, buffer
" Author: Chris Corbyn <chris@w3style.co.uk>
" =============================================================================

if (exists('g:ctrlp_bdelete_lazyloaded')) || &compatible
  finish
end
let g:ctrlp_bdelete_lazyloaded = 1

function! ctrlp_bdelete#init() abort
  unlet g:ctrlp_bdelete_loaded
  runtime plugin/ctrlp_bdelete.vim
endfunction


function! ctrlp_bdelete#store() abort
  " don't clobbber any existing user setting
  if has_key(g:ctrlp_buffer_func, 'enter')
    if g:ctrlp_buffer_func['enter'] !=# 'ctrlp_bdelete#mappings'
      let s:ctrlp_bdelete_user_func = g:ctrlp_buffer_func['enter']
    endif
  endif
endfunction

" Buffer function used in the ctrlp settings (applies mappings).
function! ctrlp_bdelete#mappings(...) abort
  " call the original user setting, if set
  if exists('s:ctrlp_bdelete_user_func')
    call call(s:ctrlp_bdelete_user_func, a:000)
  endif

  let bdelete_keymap_trigger = get(g:, 'ctrlp_bdelete_keymap_trigger', '<c-@>')
  exec 'nnoremap <buffer> <silent> ' . bdelete_keymap_trigger . ' :call <sid>DeleteMarkedBuffers()<cr>'
endfunction

function! s:DeleteMarkedBuffers() abort
  " get the line number to preserve position
  let currln = line('.')
  let lastln = line('$')

  " list all marked buffers
  let marked = ctrlp#getmarkedlist()

  " the file under the cursor is implicitly marked
  if empty(marked) && ctrlp#getcline() !=? ''
    call add(marked, fnamemodify(ctrlp#getcline(), ':p'))
  endif

  " call bdelete on all marked buffers
  for fname in marked
    let g:ctrlp_delete_buf_fname = fname
    let bufid = fname =~# '\[\d\+\*No Name\]$'
          \ ? str2nr(matchstr(matchstr(fname, '\[\d\+\*No Name\]$'), '\d\+'))
          \ : fnamemodify(fname, ':p')
    let g:ctrlp_delete_buf_bufid = substitute(bufid, ' ', '\\ ', 'g')
    exec 'silent! bdelete' g:ctrlp_delete_buf_bufid
  endfor

  " refresh ctrlp
  exec "normal \<f5>"

  " unmark buffers that have been deleted
  silent! call ctrlp#clearmarkedlist()

  " preserve line selection
  if line('.') == currln && line('$') < lastln
    exec "normal \<up>"
  endif
endfunction
