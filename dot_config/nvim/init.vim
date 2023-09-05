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

  " Syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " LSP
  Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'

  " Autocomplete
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'

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

require("mason-lspconfig").setup {
    ensure_installed = { },
}

EOF
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" au BufReadPost,BufNewFile *.rb lua SkipTopCommentsRuby()
