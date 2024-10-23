return {
  "nvim-tree/nvim-web-devicons",
  'kwkarlwang/bufresize.nvim',

  {
    "morhetz/gruvbox", -- theme
    lazy = false,
    priority = 10000,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
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

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
