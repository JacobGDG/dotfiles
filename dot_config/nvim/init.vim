runtime the_basics.vim

" --------------- gitcommit specifics

autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn+=51
autocmd FileType gitcommit set spell

" --------------- MAPPINGS

" copy current file path to system clipboard
noremap <silent> <leader>yp :let @+=substitute(@%, '^.*/src/[^/]\+/', '', '')<CR>

" replace word with last yank 'Stamp'
nnoremap S "_diwP

" no more pesky escape (for insert and visual mode)
imap kj <Esc>:w<CR>


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

  Plug 'slim-template/vim-slim'

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

EOF
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

noremap <silent> <leader>h :HopWord<CR>

luafile $HOME/.config/nvim/lua/skip-top-comments-ruby.lua
au BufReadPost,BufNewFile *.rb lua SkipTopCommentsRuby()

luafile $HOME/.config/nvim/plugins/telescope.lua

" ---------------- LSP CONFIG "
luafile $HOME/.config/nvim/plugins/cmp.lua
luafile $HOME/.config/nvim/plugins/rust-tools.lua

" Telescope "
nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap frc <cmd>lua require('telescope.builtin').find_files({ default_text="controllers/" })<cr>
nnoremap frs <cmd>lua require('telescope.builtin').find_files({ default_text="spec/" })<cr>
nnoremap frm <cmd>lua require('telescope.builtin').find_files({ default_text="models/" })<cr>

" THEME "
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
nnoremap <leader>v :Vexplore<CR>
