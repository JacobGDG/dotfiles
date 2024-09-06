require('legendary').setup({
  extensions = {
    smart_splits = {}, -- https://github.com/mrjones2014/legendary.nvim/blob/master/doc/EXTENSIONS.md#smart-splitsnvim
  },

  keymaps = {
    {
      'kj',
      { i = '<ESC>:w<CR>' },
      description = "Save file, avoiding ESC",
    },
    {
      '<leader>s',
      { n = "\"_diwP" },
      description = "Stamp default register onto word",
    },
    {
      '<Up>',
      { n = '<Nop>' },
      hide = true,
    },
    {
      '<Down>',
      { n = '<Nop>' },
      hide = true,
    },
    {
      '<Left>',
      { n = '<Nop>' },
      hide = true,
    },
    {
      '<Right>',
      { n = '<Nop>' },
      hide = true,
    }
  }
})
