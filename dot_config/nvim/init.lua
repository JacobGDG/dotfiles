local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    {
      "morhetz/gruvbox", -- theme
      lazy = false,
      priority = 10000,
    },

    {
      'mrjones2014/legendary.nvim',
      priority = 9999,
      lazy = false,
    },


    { 
      "nvim-telescope/telescope.nvim",
      tag = "0.1.6",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require('telescope').setup {
          defaults = {
            file_ignore_patterns = {
              "vcr_cassettes"
            }
          }
        }
      end,
      keys = {
        {
          '<leader>o',
          function()
            require('telescope.builtin').find_files()
          end,
          mode = { 'n' },
          desc = "Find file",
        },
        {
          '<leader>f',
          function()
            require('telescope.builtin').live_grep()
          end,
          mode = { 'n' },
          desc = "Find string",
        },
        {
          '<leader>b',
          function()
            require('telescope.builtin').buffers()
          end,
          mode = { 'n' },
          desc = "Find buffer",
        },
        {
          '<leader>h',
          function()
            require('telescope.builtin').help_tags()
          end,
          mode = { 'n' },
          desc = "Get help!",
        },
      }
    },

    -- netrw but a buffer
    {
      'stevearc/oil.nvim',
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require('oil').setup {
          skip_confirm_for_simple_edits = true,
          view_options = {
            show_hidden = true
          },

          use_default_keymaps = false,
          keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["g."] = "actions.toggle_hidden",
            ["<leader>l"] = "actions.refresh",
          },
        }
      end,
      keys = {
        {
          '-',
          '<CMD>Oil<CR>',
          mode = 'n',
          desc = "Open parent directory",
        }
      }
    },

    { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" } }, -- Autocomplete
    { 
      "williamboman/mason.nvim",
      dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "tflint" },
        })
      end
    }, -- LSP

    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require('gitsigns').setup()
      end
    },
    {
      "ggandor/leap.nvim",
      config = function()
        require('leap').create_default_mappings()
      end
    },

    {
      "nvim-lualine/lualine.nvim",
      lazy = false,
      init = function()
        require("lualine").setup {
          options = { theme = "gruvbox" }
        }
      end
    },

    "sheerun/vim-polyglot", -- syntax highlighting

    "nvim-tree/nvim-web-devicons",

    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
    },

    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
      end
    },
    {
      "zbirenbaum/copilot-cmp",
      config = function ()
        require("copilot_cmp").setup()
      end
    },
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      branch = "canary",
      dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim" },
      },
      opts = {
      	-- debug = true,
      },
    },

    -- TMUX navigation
    'mrjones2014/smart-splits.nvim',


    'kwkarlwang/bufresize.nvim',
  },
  {}
  )

vim.opt.showmatch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

vim.opt.scrolloff = 3

vim.opt.hidden = true

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "+1"

vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
    pattern = "*",
    command = "set relativenumber",
  })
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
    pattern = "*",
    command = "set norelativenumber",
  })

vim.opt.showcmd = true
vim.opt.wildmode = longest,list

