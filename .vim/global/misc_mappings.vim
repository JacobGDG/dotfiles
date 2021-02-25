" copy current file path to system clipboard
noremap <silent> <leader>yp :let @+=@%<CR>
" replace word with last yank 'Stamp'
nnoremap S diw"0p

" no more pesky escape (for insert and visual mode)
imap kj <Esc>
