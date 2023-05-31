-- tab related stuff
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.api.nvim_command('autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4')

-- line numbers
vim.opt.number = true
-- vim.opt.relativenumber = true

-- enable mouse
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'popup'
-- vim.opt.keymodel = "startsel,stopsel"

-- bash like tab completions
vim.opt.wildmode = { "longest", "list" }

-- show vertical line
vim.opt.cc = { 100 }

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- highlight current line
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- scrolling
vim.opt.ttyfast = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

-- remove swap file and write directly to file
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.swapfile = false

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/state/nvim/undo')
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- command line tweaks
vim.opt.showmode = false
vim.opt.hidden = true

-- case insensitive search
vim.opt.ignorecase = true

vim.opt.wildignore = {
  '*.o', 
  '*.a', 
  '*.so', 
  '__pycache__' 
}

-- render leading tab and spaces
vim.opt.list = true
vim.opt.listchars = { 
  space = '·', 
  tab = '>~' 
}

-- =========================================================
--                     Key Bindings
-- =========================================================
vim.g.mapleader = ' '

-- Map Ctrl + S to save file
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })

-- Map Alt + arrow key up/down to move current line up/down
vim.api.nvim_set_keymap('n', '<M-Up>', ':m-2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-Down>', ':m+<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-Up>', '<Esc>:m-2<CR>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-Down>', '<Esc>:m+<CR>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-Up>', '<Esc>:m-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-Down>', '<Esc>:m+<CR>==', { noremap = true, silent = true })


-- Map Shift + Up/Down/Left/Right for selection
vim.api.nvim_set_keymap('n', '<S-Up>', 'v<Up>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Down>', 'v<Down>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Left>', 'v<Left>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Right>', 'v<Right>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Left>', 'v<S-Left>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-Right>', 'v<S-Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Up>', '<Esc>v<Up>i', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Down>', '<Esc>v<Down>i', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Left>', '<Esc>v<Left>i', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Right>', '<Esc>v<Right>i', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-S-Left>', '<Esc>v<S-Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-S-Right>', '<Esc>v<S-Right>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Left>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Right>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Up>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Down>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-S-Left>', '<S-Left>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-S-Right>', '<S-Right>', { noremap = true })

-- Map Ctrl + X to cut current line
vim.api.nvim_set_keymap('n', '<C-x>', 'dd', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-x>', 'd', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-x>', '<Esc>dd', { noremap = true })

-- Map Ctrl + C to copy current line
vim.api.nvim_set_keymap('n', 'yy', '^yg_', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', 'yy', { })
vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>yyi', { })
vim.api.nvim_set_keymap('v', '<C-c>', 'y', { noremap = true })

-- Map Ctrl + Z to undo
vim.api.nvim_set_keymap('n', '<C-z>', 'u', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<Esc>ui', { noremap = true })

-- Map Ctrl + Y to redo
vim.api.nvim_set_keymap('n', '<C-y>', '<C-r>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-y>', '<Esc><C-r><i>', { noremap = true })

-- Map Ctrl + A to go to start of line
vim.api.nvim_set_keymap('', '<Home>', '^', { noremap = true })
vim.api.nvim_set_keymap('!', '<Home>', '<C-Home>', { noremap = true })
vim.api.nvim_set_keymap('i', '<Home>', '<Esc>^i', { noremap = true })
vim.api.nvim_set_keymap('v', '<Home>', '0', { noremap = true })

-- Map Ctrl + E to go to end of line
vim.api.nvim_set_keymap('', '<End>', '$', { noremap = true })
vim.api.nvim_set_keymap('!', '<End>', '<C-End>', { noremap = true })
vim.api.nvim_set_keymap('i', '<End>', '<Esc>A', { noremap = true })
vim.api.nvim_set_keymap('v', '<End>', '$', { noremap = true })

-- Map Ctrl + A to select all text
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-a>', '<Esc>ggVG', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-a>', '<Esc>ggVG', { noremap = true })

-- Map Tab key to indent in visual mode
vim.api.nvim_set_keymap('n', '<Tab>', 'i<Tab>', { silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', 'i<S-Tab>', { silent = true })
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-d>', { noremap = true })

-- Map Backspace to delete in visual mode
vim.api.nvim_set_keymap('v', '<BS>', '"_d', { silent = true })
vim.api.nvim_set_keymap('n', '<BS>', 'i<BS>', { noremap = true, silent = true })

-- Define the mapping for navigating back and forth with Alt + Left/Right
vim.api.nvim_set_keymap('n', '<M-Left>', '<C-o>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-Right>', '<C-i>', { noremap = true })

-- Modes
vim.api.nvim_set_keymap('n', 'vv', 'v', { noremap = true })
vim.api.nvim_set_keymap('i', 'vv', '<Esc>v', { noremap = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('v', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('v', 'kj', '<Esc>', { noremap = true })

-- Remove highling from search result
vim.api.nvim_set_keymap('n','<Esc><Esc>', '<Esc>:nohls<CR><Esc>', { noremap = true, silent = true })

-- Ctrl + w to close current buffer
vim.api.nvim_set_keymap('n', '<C-w>', ':bdelete<CR>', { noremap = true })


-- =========================================================
--                  Lazy Package Manager
-- =========================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

