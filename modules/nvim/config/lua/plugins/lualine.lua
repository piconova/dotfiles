return {
  "nvim-lualine/lualine.nvim",
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        theme = "nord",
        component_separators = '|',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { },
        lualine_x = { 
          {
          'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
              -- color_error = { fg = colors.red },
              -- color_warn = { fg = colors.yellow },
              -- color_info = { fg = colors.cyan },
            },
          },
        },
        lualine_y = { 'filetype', 'filesize' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
  })
  end,
}
