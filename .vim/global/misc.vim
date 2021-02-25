syntax on
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set softtabstop=2
set cursorline
set hidden
set number relativenumber
" toggle relative number on insert and focus
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" search
" ignore case unless capital given
set ignorecase
set smartcase
" highlight all matches
set hlsearch

" Show command in bottom right portion of the screen
set showcmd

" Force the cursor onto a new line after 80 characters
set textwidth=80
" Colour the 81st (or 73rd) column so that we don’t type over our limit
set colorcolumn=+1


" no arrow keys you
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" folding zf to fold. open close all zR zM
set foldmethod=indent
set nofoldenable
