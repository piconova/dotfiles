return {
  'numToStr/Comment.nvim',
  config = function()
      require('Comment').setup()

      -- Map ctrl + / to comment/uncomment
      vim.api.nvim_set_keymap('n', '<C-/>', 'gcc', { })
      vim.api.nvim_set_keymap('i', '<C-/>', '<Esc>gcc', { })
      vim.api.nvim_set_keymap('v', '<C-/>', 'gc', { })

  end
}
