" --------------- GENERAL

set showmatch               " show matching
set ignorecase              " case insensitive
set smartcase               " case sensitive if capital

set hlsearch                " highlight search
set incsearch               " incremental search

set tabstop=2               " number of columns occupied by a tab
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set signcolumn=yes          " always show signcolumn

set scrolloff=3             " scroll page when X from top/bottom

set hidden                  " allow unsaved buffers to be hidden

set number relativenumber   " add line numbers
set cursorline              " highlight current cursorline
set cc=120                  " set an 120 column border for good coding style
" toggle relative number on insert and focus
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

set showcmd                 " show last command, bottom right

set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set ttyfast                 " Speed up scrolling in Vim

" no arrow keys you
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set directory=$HOME/.config/nvim/swapfiles//  " Store .swp files outside of working directories (easy git)

" copy current file path to system clipboard
noremap <silent> <leader>yp :let @+=substitute(@%, '^.*/src/[^/]\+/', '', '')<CR>

" replace word with last yank 'Stamp'
nnoremap S "_diwP

" no more pesky escape (for insert and visual mode)
imap kj <Esc>:w<CR>
