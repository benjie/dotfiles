vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Set colorscheme
vim.o.termguicolors = true

-- Don't unload buffers when switching (preserves undo history):
vim.o.hidden = true

-- Disable banner
vim.g.netrw_banner = 0
-- Use vertical rather than horizontal split for preview
vim.g.netrw_preview   = 1
-- Use tree view in netrw
vim.g.netrw_liststyle = 3
-- Only use 20% of width when opening split/preview
vim.g.netrw_winsize   = 20
-- Browse in vertical split
vim.g.netrw_browse_split = 2

-- Whitespace stuff
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.list = true
vim.o.listchars="tab:  ,trail:·"


vim.cmd('colorscheme industry')
vim.keymap.set('n', '<leader><space>', ':noh<cr>', { desc = '[ ] Clear highlights' })
vim.keymap.set('n', '<leader>cd', ':lcd %:h<cr>', { desc = '[C]hange [D]irectory', silent = true })
vim.keymap.set('n', '<leader>md', ':!mkdir -p %:h<cr><cr>', { desc = '[M]ake [D]irectory', silent = true })
-- vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files({ hidden = true }) end, { desc = '' })
-- vim.keymap.set('n', '<leader>sg', function() require('telescope.builtin').live_grep({ additional_args = function() return { "--hidden" } end }) end, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '[g', ':tabprevious<CR>', { silent = true })
vim.keymap.set('n', ']g', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', '[G', ':tabrewind<CR>', { silent = true })
vim.keymap.set('n', ']G', ':tablast<CR>', { silent = true })

