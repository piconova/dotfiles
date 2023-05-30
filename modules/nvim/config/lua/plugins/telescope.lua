return {
  'nvim-telescope/telescope.nvim',
  -- tag = '0.1.1',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    'LukasPietzschmann/telescope-tabs',
    'natecraddock/telescope-zf-native.nvim',
  },
  config = function()
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local telescope_tabs = require("telescope-tabs")

    vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    vim.keymap.set('i', '<C-p>', builtin.find_files, {})
    vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('i', '<C-f>', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('n', '<C-S-f>', builtin.live_grep, {})
    vim.keymap.set('i', '<C-S-f>', builtin.live_grep, {})
    vim.keymap.set('v', '<C-f>', builtin.grep_string, {})
    vim.keymap.set('n', '<C-b>', builtin.buffers, {})
    vim.keymap.set('i', '<C-b>', builtin.buffers, {})

    vim.keymap.set('n', 'ff', builtin.find_files, {})
    vim.keymap.set('n', 'fj', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('n', 'fg', builtin.live_grep, {})
    vim.keymap.set('n', 'bb', builtin.buffers, {})
    vim.keymap.set('n', 'tt', telescope_tabs.list_tabs, {})

    vim.api.nvim_set_keymap(
      "n",
      "fb",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { noremap = true }
    )

    local telescope = require("telescope")
    telescope.load_extension("file_browser")
    telescope.load_extension("zf-native")

    local fb_actions = telescope.extensions.file_browser.actions

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "^node_modules/",
          "^.git/",
          "^bin*/",
          "^build*/",
        },
        layout_config = {
                                  
        },
        mappings = {
          i = {
            ["<Esc>"] = actions.close,
            ["<C-h>"] = "which_key"
          },
        },
      },

      pickers = {
        find_files = {
          mappings = {
            i = {
              ["<CR>"] = actions.select_tab_drop,
              ["<S-CR>"] = actions.select_vertical,
              ["<C-S-CR>"] = actions.select_horizontal,
            }
          },
        },
        buffers = {
          mappings = {
            i = { 
              ["<CR>"] = actions.select_tab_drop 
            },
          },
        },
      },

      extensions = {
        file_browser = {
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<CR>"] = actions.select_tab_drop,
              ["<C-h>"] = "which_key",
              ["<S-CR>"] = actions.select_vertical,
              ["<C-S-CR>"] = actions.select_horizontal,
              ["<C-n>"] = fb_actions.create,
              ["<C-d>"] = fb_actions.remove,
            },
          },
        },
        ["zf-native"] = {
          file = {
            enable = true,
            highlight_results = true,
            match_filename = true,
          },
          generic = {
            enable = true,
            highlight_results = true,
            match_filename = false,
          },
        },
      },
    }) 

  end,
}
