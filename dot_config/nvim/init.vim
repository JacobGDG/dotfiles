" --------------- GENERAL

set nocompatible            " disable compatibility to old-time vi
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

set scrolloff=3             " scroll page when X from top/bottom

set hidden                  " allow unsaved buffers to be hidden

set number relativenumber   " add line numbers
set cursorline              " highlight current cursorline
set cc=120                  " set an 80 column border for good coding style
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
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim

" no arrow keys you
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set re=0                    " https://dev.to/ronenlaufer/comment/1d702

set directory=$HOME/.vim/swapfiles//  " Store .swp files outside of working directories (easy git)

" --------------- gitcommit specifics

autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn+=51
autocmd FileType gitcommit set spell

" --------------- MAPPINGS

" copy current file path to system clipboard
noremap <silent> <leader>yp :let @+=substitute(@%, '^.*/src/[^/]\+/', '', '')<CR>

" replace word with last yank 'Stamp'
nnoremap S diwh"0p

" no more pesky escape (for insert and visual mode)
imap kj <Esc>:w<CR>

" list buffer, pick the number jump to
nnoremap gb :ls<CR>:vertical sbuffer<Space>

" ---------------- PLUGIN MANAGER

" https://github.com/junegunn/vim-plug
" :PlugInstall
call plug#begin()
  " improvents for Netrw
  Plug 'tpope/vim-vinegar'

  " Fuzzy search
  " Plug 'junegunn/fzf'
  " Plug 'junegunn/fzf.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

  " Theme
  Plug 'morhetz/gruvbox'

  " status bar at the bottom
  Plug 'nvim-lualine/lualine.nvim'

  Plug 'christoomey/vim-tmux-navigator'

  Plug 'github/copilot.vim'

  " git plugin
  Plug 'tpope/vim-fugitive'
  " GitHub plugin for vim-fugitive
  Plug 'tpope/vim-rhubarb'

  Plug 'tpope/vim-rails'

  " Quick nav :HopWord
  Plug 'phaazon/hop.nvim'

  Plug 'MunifTanjim/nui.nvim'
  Plug 'jackMort/ChatGPT.nvim'

  Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'simrat39/rust-tools.nvim'

  Plug 'hrsh7th/nvim-cmp' 
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'nvim-tree/nvim-web-devicons'
call plug#end()
" ---------------- PLUGIN CONFIG

lua << EOF
require("lualine").setup {
  options = { theme = "gruvbox" }
}
require("chatgpt").setup()
require'hop'.setup()

require("mason").setup()
require("mason-lspconfig").setup()

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
EOF

noremap <silent> <leader>h :HopWord<CR>

luafile $HOME/.config/nvim/lua/skip-top-comments-ruby.lua
au BufReadPost,BufNewFile *.rb lua SkipTopCommentsRuby()

" ---------------- LSP CONFIG
luafile $HOME/.config/nvim/plugins/cmp.lua
luafile $HOME/.config/nvim/plugins/rust-tools.lua

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>

" THEME
set t_Co=256
set background=dark
colorscheme gruvbox

let g:tmux_navigator_no_mappings = 1
noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
noremap <silent> <c-\> :<C-U>TmuxNavigatePrevious<cr>

nnoremap <leader>gb :GBrowse<CR>
nnoremap <leader>gbb :.GBrowse<CR>
nnoremap <leader>\ :Explore<CR>
nnoremap <leader>v :Vexplore<CR>
