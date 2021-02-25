" VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Theme
Plugin 'morhetz/gruvbox'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" :wq out of vim. reopen and run :PluginInstall
Plugin 'tpope/vim-rails'
" allows repeat#set repeat.vim
Plugin 'tpope/vim-repeat'

"git tools
Plugin 'tpope/vim-fugitive'
Plugin 'shumphrey/fugitive-gitlab.vim'


Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'preservim/nerdcommenter'

" status bar at the bottom
Plugin 'vim-airline/vim-airline'

" insert uuid
Plugin 'kburdett/vim-nuuid'

" vimwiki
Plugin 'vimwiki/vimwiki'

" Asychronous Lint Enginer https://github.com/dense-analysis/ale
Plugin 'dense-analysis/ale'

" Fuzzy search
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" VUNDLE

" load every .vim file within .vim/global
runtime! /global/**/*.vim
