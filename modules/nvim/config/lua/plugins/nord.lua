return {
  "arcticicestudio/nord-vim",
  -- "shaunsingh/nord.nvim",
  lazy = false,
	priority = 1000,
	config = function()
    vim.cmd("colorscheme nord")
    vim.api.nvim_set_hl(0, 'TelescopeMatching', {fg = "#A3BE8C"})
  end,
}
