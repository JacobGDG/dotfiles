" copy current file path to system clipboard
noremap <silent> <leader>yp :let @+=@%<CR>
" toggle paste mode
set pastetoggle=<F2>
" replace word with last yank 'Stamp'
nnoremap S diw"0P

" move current line up and down. use vim.repeat to enable the use of the dot
" command.
nmap <Plug>MoveLineUp "addk"aP
      \:call repeat#set("\<Plug>MoveLineUp", v:count)<CR>
nmap <C-Up> <Plug>MoveLineUp
nmap <Plug>MoveLineDown "add"ap
      \:call repeat#set("\<Plug>MoveLineDown")<CR>
nmap <silent><C-Down> <Plug>MoveLineDown

" no more pesky escape (for insert and visual mode)
imap kj <Esc>
