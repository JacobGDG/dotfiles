return {
  'mrjones2014/smart-splits.nvim',

  { -- keybindings
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

  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').create_default_mappings()
    end
  },
}
