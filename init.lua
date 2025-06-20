-- Based on https://github.com/nvim-lua/kickstart.nvim then with lots of Benjie's edits applied

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
      -- TODO: move to 'folke/lazydev.nvim' instead of neodev.nvim
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      -- pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use { -- Like VSCode "sticky scroll"
    'nvim-treesitter/nvim-treesitter-context',
    after = 'nvim-treesitter',
    run = function()
      require'treesitter-context'.setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 8, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 1, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  }


  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      {"nvim-telescope/telescope-live-grep-args.nvim" },
      {'nvim-lua/plenary.nvim' }
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Benjie's selection of plugins
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-abolish'
  use 'tpope/vim-eunuch'
  --use 'tpope/vim-fugitive'
  use 'tpope/vim-git'

  use 'tpope/vim-ragtag'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  use 'tpope/vim-unimpaired'
  -- Plug 'nathanaelkane/vim-indent-guides'
  -- Entering multiselect:
  --   Ctrl-N to multiselect current word
  --   Ctrl up/down to add vertical cursors
  --   Shift-arrows to start selecting pattern to multiselect
  -- Once in multiselect:
  --   Two modes, switch with <tab>
  --   n/N to get next/prev occurrance
  --   [/] to jump to next/prev cursor
  --   q to skip current cursor and find next
  --   Q to remove current cursor and go back to previous
  --   Regular vim (i,a,I,A,r,R,c,...)
  -- :help visual-multi
  use 'mg979/vim-visual-multi' --, {'branch': 'master'}
  use 'michaeljsmith/vim-indent-object'
  use 'tpope/vim-dotenv'
  -- use 'tpope/vim-dadbod'
  use 'Olical/vim-enmasse'

  use {
  "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        keywords = {
          ENHANCE = { icon = " ", color = "hint", alt = { "ENHANCEMENT", "IMPROVEMENT", "IMPROVE" } }
        }
      }
    end
  }

  use 'benjie/local-npm-bin.vim'

  -- Time tracking
  use 'wakatime/vim-wakatime'

  use 'mhinz/vim-grepper'

  use 'onsails/lspkind.nvim'

  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }

  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }
  use { 'sbdchd/neoformat',
    after = { 'local-npm-bin.vim' },
    config = function ()
      vim.g.neoformat_enabled_javascript = {'prettier', 'eslint_d'}
      vim.g.neoformat_enabled_javascriptreact = {'prettier', 'eslint_d'}
      vim.g.neoformat_enabled_typescript = {'prettier', 'eslint_d'}
      vim.g.neoformat_enabled_typescriptreact = {'prettier', 'eslint_d'}
      vim.g.neoformat_enabled_json = {'prettier'}
      vim.g.neoformat_enabled_jsonc = {'prettier'}
      vim.g.neoformat_enabled_json5 = {'prettier'}
      vim.g.neoformat_enabled_markdown = {'prettier'}
      vim.g.neoformat_enabled_css = {'prettier'}
      vim.g.neoformat_enabled_graphql = {'prettier'}
      vim.g.neoformat_enabled_html = {'prettier'}
      vim.g.neoformat_enabled_svg = {'prettier'}
      -- Run both prettier _AND_ eslint_d!
      vim.g.neoformat_run_all_formatters = 1
      local neoformat_group = vim.api.nvim_create_augroup('Neoformat', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = neoformat_group,
        pattern = 'javascript',
        command = 'augroup neoformatauto | autocmd! BufWritePre <buffer> silent Neoformat | augroup END',
      })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = neoformat_group,
        pattern = '*.js,*.mjs,*.cjs,*.jsx,*.mjsx,*.cjsx,*.ts,*.mts,*.cts,*.tsx,*.mtsx,*.ctsx,*.css,*.graphql,*.json,*.md',
        command = 'silent Neoformat',
      })
    end
  }


  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
-- vim.cmd [[colorscheme onedark]]
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_a = {
      {
        'mode',
        cond = function()
          return vim.api.nvim_get_mode().mode ~= 'n'
        end
      }
    },
    lualine_b = {
      -- 'branch',
      -- 'diff',
      'diagnostics'
    },
    lualine_c = {
      {
        'filename',
        path = 1,
        shorten = false,
        shorting_target = 25
      }
    },
    lualine_x = {
      {
        'encoding',
        cond = function()
          return vim.bo.fileencoding ~= 'utf-8'
        end
      },
      {
        'fileformat',
        cond = function()
          return vim.bo.fileformat ~= 'unix'
        end,
        symbols = {
          unix = '', -- e712
          dos = '',  -- e70f
          mac = '',  -- e711
        }
      },
      -- TODO: make it so the filetype only displays if it is surprising
      {
        'filetype',
        icon_only = true
      },
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path = 1, shorting_target = 9}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
-- require('indent_blankline').setup {
--   char = '┊',
--   show_trailing_blankline_indent = false,
-- }

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local lga_actions = require("telescope-live-grep-args.actions")
local function load_telescope_excludes()
  -- Lua Patterns - Special Characters That Require `%`
  -- +-----------+-------------------------------+
  -- | `%`       | Escape character itself       |
  -- | `.`       | Matches any character         |
  -- | `^`       | Anchors the start of a string |
  -- | `$`       | Anchors the end of a string   |
  -- | `(` `)`   | Capturing groups              |
  -- | `[` `]`   | Character sets                |
  -- | `*`       | Wildcard repetition           |
  -- | `+`       | One or more                   |
  -- | `-`       | Non-greedy repetition         |
  -- | `?`       | Matches 0 or 1                |
  -- +-----------+-------------------------------+
  local path = vim.fn.getcwd()
  local ignores = { "%.git/.*", "%.yarn/.*" }

  while path ~= "/" do
    local ignore_file = path .. "/.telescope_ignore"
    if vim.fn.filereadable(ignore_file) == 1 then
      for line in io.lines(ignore_file) do
        if not line:match("^#") and line:match("%S") then -- Ignore comments and empty lines
          table.insert(ignores, line)
        end
      end
    end
    path = vim.fn.fnamemodify(path, ":h") -- Move up one directory
  end
  -- print("Telescope Ignore Patterns: " .. vim.inspect(ignores))
  return ignores
end
require('telescope').setup {
  defaults = {
    file_ignore_patterns = load_telescope_excludes(),
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    -- All but the last are default arguments, see `:help vimgrep_arguments`
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      -- Added multiline matching
      "--multiline",
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  }
}
local function update_telescope_ignores()
  local telescope = require("telescope")
  -- local current_config = telescope.get_defaults()
  -- current_config.defaults.file_ignore_patterns = load_telescope_excludes()
  -- telescope.setup(current_config)
  telescope.setup({
    defaults = {
      file_ignore_patterns = load_telescope_excludes(),
    },
  })
  -- vim.notify("Telescope ignore patterns updated", vim.log.levels.INFO)
end
-- Auto-reload on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = ".telescope_ignore",
  callback = update_telescope_ignores,
})


-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', ':noh<cr>', { desc = '[ ] Clear highlights' })
-- cd to the directory containing the file in the buffer
vim.keymap.set('n', '<leader>cd', ':lcd %:h<cr>', { desc = '[C]hange [D]irectory', silent = true })

-- mkdir the folder for the current buffer
vim.keymap.set('n', '<leader>md', ':!mkdir -p %:h<cr><cr>', { desc = '[M]ake [D]irectory', silent = true })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = 'Find existing [b]uffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files({ hidden = true }) end, { desc = '' })
vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files({ hidden = true }) end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function() require('telescope.builtin').live_grep({ additional_args = function() return { "--hidden" } end }) end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'cpp',
    'css',
    'diff',
    'dockerfile',
    'dot',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'mermaid',
    'passwd',
    'python',
    'regex',
    'rust',
    'sql',
    'toml',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
  },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Setup neovim lua configuration
require('neodev').setup()

-- Turn on lsp status information
require('fidget').setup()

local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    ['<Tab>'] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' }
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- -- The function below will be called before any actual modifications from lspkind
      -- -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function (entry, vim_item)
      --   ...
      --   return vim_item
      -- end
    })
  }
}

-- vim.lsp.set_log_level("debug")

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Apply to all language servers
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("graphql", {
  -- root_dir = lspconfig.util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json"),
  flags = {
    debounce_text_changes = 150,
  },
  -- filetypes = { "graphql" },
  --settings = {
  --  graphql = {
  --    schemaPath = './simple.graphqls',
  --    documents = '*.graphql'
  --  }
  --}
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false, -- Avoid unnecessary third-party plugin warnings
        library = {
          vim.env.VIMRUNTIME, -- Neovim runtime files
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
      telemetry = { enable = false },
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
    local bufnr = ev.buf

    local nmap = function(keys, func, desc)
      if desc then desc = 'LSP: ' .. desc end
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    -- Use this to accept suggestions from LSP/TypeScript/etc
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-d>', vim.lsp.buf.signature_help, 'Signature [D]ocumentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    if client.name == "graphql" then
      print("GraphQL LSP attached")
    end
  end
})

-- Setup mason so it can manage external tooling
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {'ts_ls', 'lua_ls', 'graphql'},
  automatic_enable = true
}

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

vim.o.ignorecase = false
vim.o.smartcase = false
vim.o.hlsearch = true
-- Benjie's old configuration options, copied over
vim.o.modelines = 0
vim.o.modeline = false
-- vim.o.termguicolors = true
vim.o.splitbelow = true
vim.o.splitright = true
--vim.o.mouse = 'a'
-- vim.o.guicursor="n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.o.wrapscan = false

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


-- ragtag in all your files
vim.g.ragtag_global_maps = 1
-- Add/remove current file to arguments list, for use with [a & ]a
vim.keymap.set('n', '<leader>a', ':argadd %<cr>')
vim.keymap.set('n', '<leader>A', ':argdel %<cr>')
-- unimpaired-like tab navigation
vim.keymap.set('n', 'tt', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '[g', ':tabprevious<CR>', { silent = true })
vim.keymap.set('n', ']g', ':tabnext<CR>', { silent = true })
vim.keymap.set('n', '[G', ':tabrewind<CR>', { silent = true })
vim.keymap.set('n', ']G', ':tablast<CR>', { silent = true })
-- 'r' for 'error' (from ALE lint)
--nnoremap <silent> [r <Plug>(coc-diagnostic-prev)
--nnoremap <silent> ]r <Plug>(coc-diagnostic-next)

-- To solve issues with DB timeouts when lots of tables/columns
vim.g.vim_dadbod_completion_force_context = 1


-- Don't unload buffers when switching (preserves undo history):
vim.o.hidden = true

-- Make vim wait less time for <Esc> codes.
vim.o.ttimeoutlen=-1
-- Seems to be required to fix neovim?
vim.o.ttimeout = false

-- Whitespace stuff
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
--vim.o.list = true
--vim.o.listchars="tab:  ,trail:·"

-- Maximize current pane
--nnoremap <C-w>a <C-w>\|<C-w>_
vim.keymap.set('n', '<C-w>a', '<C-w>|<C-w>_')

-- Remember last location in file
-- au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.api.nvim_command("normal g'\"")
    end
  end
})

-- No save backup by .swp
vim.o.wb = false
vim.o.swapfile = false
vim.o.ar = false

-- Persistent undo
vim.o.undodir = vim.fn.expand('$HOME/.vimundo')
vim.o.undofile = true
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md", "*.mdx", "*.txt" },
  callback = function()
    vim.bo.textwidth = 80
    -- Avoid duplicates.
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[tlv]", "")
    -- See `:help fo-table`
    vim.bo.formatoptions = vim.bo.formatoptions .. "tlv"
  end,
})



vim.keymap.set("n", "]r", function()
    require("trouble").next({skip_groups = true, jump = true});
end, { desc = "Next t[r]ouble item" })

vim.keymap.set("n", "[r", function()
  require("trouble").previous({skip_groups = true, jump = true});
end, { desc = "Previous t[r]ouble item" })

vim.keymap.set("n", "[R", function()
  require("trouble").first({skip_groups = true, jump = true});
end, { desc = "First t[r]ouble item" })

vim.keymap.set("n", "]R", function()
  require("trouble").last({skip_groups = true, jump = true});
end, { desc = "Last t[r]ouble item" })

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>rs", function()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.api.nvim_command("e!")
end, {desc = "[R]e[S]tart LSP"})

-- vim.keymap.set("i", "<C-X>c", 'copilot#Accept("<CR>")',
--   {expr=true, silent=true, desc = "[X]omplete [C]opilot"})
-- vim.g.copilot_no_tab_map = true

--[[ Generate a uuid and place it at current cursor position --]]
local insert_uuid = function()
    -- Get row and column cursor,
    -- use unpack because it's a tuple.
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local uuid = string.gsub(vim.fn.system('uuidgen -r') or "", '[\n]', '')
    -- Notice the uuid is given as an array parameter, you can pass multiple strings.
    -- Params 2-5 are for start and end of row and columns.
    -- See earlier docs for param clarification or `:help nvim_buf_set_text.
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { uuid })
    vim.api.nvim_win_set_cursor(0, { row, col + string.len(uuid) })
end

vim.keymap.set('i', '<C-u>', insert_uuid, { noremap = true, silent = true })

-- endash
vim.cmd('iabbrev --! –')
-- emdash
vim.cmd('iabbrev ---! —')

-- Scroll offset
vim.cmd('set scrolloff=10')
