# ctrlp_bdelete.vim

> Merged the following repos [j5shi](https://github.com/j5shi/ctrlp_bdelete.vim), [amadeus](https://github.com/amadeus/ctrlp_bdelete.vim), [hokorobi](https://github.com/hokorobi/ctrlp_bdelete.vim)

The ctrlp.vim plugin for Vim does not provide a way to delete open buffers and
there are no plans to add this functionality.

The [author of ctrlp.vim](https://github.com/kien), however, provided the basis
of an [extension](https://github.com/kien/ctrlp.vim/issues/280) to ctrlp.vim
that users could drop into their vimrc to get this feature.

This plugin has taken that snippet and improved it to add support for marking
multiple buffers, in addition to implementing bugfixes.

## Installation

The easiest way to install ctrlp_bdelete.vim is using
[Vundle](https://github.com/gmarik/Vundle.vim) or
[Pathogen](https://github.com/tpope/vim-pathogen).

If you are already setting `g:ctrlp_buffer_func` somewhere in your vimrc,
make sure to call `ctrlp_bdelete#init()` after that (this plugin won't clobber it,
but you may clobber the plugin initialization if you change
`g:ctrlp_buffer_func` later).

## Usage

Open ctrlp in buffer mode (<kbd>c-p</kbd> <kbd>c-b</kbd>), filter as needed,
navigate to a buffer you wish to close and press <kbd>c-@</kbd>
(<kbd>c-2</kbd>). The buffer will be deleted and will disappear from the
list.

You may also mark multiple buffers with <kbd>c-z</kbd> and then close them all
at once with a single press of <kbd>c-@</kbd>.

You can set your own mapping with `let g:ctrlp_bdelete_keymap_trigger = <c-@>`

### TODO

 * Fix rendering bug that causes the ctrlp pane to consume the entire window in
   some cases (sporadic).
 * Write documentation for Vim
