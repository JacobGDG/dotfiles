require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "vcr_cassettes"
    }
  }
}

vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', {noremap = true})
