---@diagnostic disable: undefined-doc-name
return {
  {
    'neovim/nvim-lspconfig',
  },
  -- Mason & LSP management
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    config = true,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'intelephense',
          'html-lsp',
          'css-lsp',
          'lua-language-server',
          'stylua',
        },
        auto_update = true,
      }
    end,
  },

  -- Noice (UI)
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        -- Turn off UI extras like LSP popups and virtual text
        lsp = {
          progress = { enabled = true },
          signature = { enabled = true },
          hover = { enabled = true },
          message = { enabled = true },
        },

        -- Filter noisy notify messages
        routes = {
          -- Suppress "No information available" and other common noise
          {
            filter = {
              event = 'notify',
              find = 'No information available',
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = 'notify',
              min_height = 1,
              any = {
                { find = 'written' },
                { find = 'change' },
                { find = 'successfully' },
                { find = 'Already installed' },
              },
            },
            opts = { skip = true },
          },
        },

        -- Show only errors/warnings
        notify = {
          enabled = true,
          view = 'mini', -- or "notify" if you use `nvim-notify`
          level = vim.log.levels.WARN, -- Only WARN and ERROR
        },

        -- UI tweaks (optional)
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      }
    end,
  },

  -- CMP (completion)
  {
    'Saghen/blink.cmp',
    event = 'InsertEnter',
    version = '*', -- ✅ this makes it track stable tags, not commits
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'core.cmp'
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
  },

  -- Treesitter & extras
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'lua',
          'php',
          'html',
          'css',
          'javascript',
          'json',
        },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true,
        max_lines = 3,
        separator = '-',
      }
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },

  -- UI
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  { 'folke/snacks.nvim', config = true },

  -- Telescope (no keymaps)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Productivity
  { 'folke/todo-comments.nvim', config = true },
  { 'mbbill/undotree' },
  { 'folke/trouble.nvim', config = true },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = true,
  },

  -- Yazi integration
  {
    'mikavilpas/yazi.nvim',
    cmd = { 'Yazi', 'YaziHere' },
    config = true,
  },
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewFileHistory',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = 'LazyGit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Open LazyGit' })
    end,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    ---@type TailwindTools.Option
    opts = {
      server = {
        override = true, -- setup the server from the plugin if true
        settings = {}, -- shortcut for `settings.tailwindCSS`
        on_attach = function(client, bufnr) end, -- callback triggered when the server attaches to a buffer
      },
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = 'inline', -- "inline" | "foreground" | "background"
        inline_symbol = '󰝤 ', -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = '󱏿', -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = '#38BDF8',
        },
      },
      cmp = {
        highlight = 'foreground', -- color preview style, "foreground" | "background"
      },
      telescope = {
        utilities = {
          callback = function(name, class) end, -- callback used when selecting an utility class in telescope
        },
      },
      -- see the extension section to learn more
      extension = {
        queries = {}, -- a list of filetypes having custom `class` queries
        patterns = { -- a map of filetypes to Lua pattern lists
          -- example:
          -- rust = { "class=[\"']([^\"']+)[\"']" },
          -- javascript = { "clsx%(([^)]+)%)" },
        },
      },
    },
  },
  {
    'zimeg/newsflash.nvim',
    event = 'VeryLazy',
  },
  {
    'nvim-lualine/lualine.nvim',
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup {
        chunk = {
          enable = true,
          priority = 15,
          style = {
            { fg = '#ca9ee6' },
            { fg = '#e78284' },
          },
          use_treesitter = true,
          chars = {
            horizontal_line = '─',
            vertical_line = '│',
            left_top = '╭',
            left_bottom = '╰',
            right_arrow = '>',
          },
          textobject = '',
          max_file_size = 1024 * 1024,
          error_sign = true,
          -- animation related
          duration = 20,
          delay = 1,
        },
        indent = {
          enable = true,
          priority = 10,
          style = { vim.api.nvim_get_hl(0, { name = 'Whitespace' }) },
          use_treesitter = false,
          chars = { '│' },
          ahead_lines = 5,
          delay = 1,
        },
      }
    end,
  },
  {
    'jinh0/eyeliner.nvim',
    config = function()
      require('eyeliner').setup {
        -- show highlights only after keypress
        highlight_on_key = false,

        -- dim all other characters if set to true (recommended!)
        dim = true,

        -- set the maximum number of characters eyeliner.nvim will check from
        -- your current cursor position; this is useful if you are dealing with
        -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
        max_length = 9999,

        -- filetypes for which eyeliner should be disabled;
        -- e.g., to disable on help files:
        -- disabled_filetypes = {"help"}
        disabled_filetypes = {},

        -- buftypes for which eyeliner should be disabled
        -- e.g., disabled_buftypes = {"nofile"}
        disabled_buftypes = {},

        -- add eyeliner to f/F/t/T keymaps;
        -- see section on advanced configuration for more information
        default_keymaps = true,
      }
    end,
  },
  {
    'mvllow/modes.nvim',
    config = function()
      require('modes').setup {
        colors = {
          copy = '#f5c359',
          delete = '#c75c6a',
          insert = '#c6d0f5',
          visual = '#9745be',
        },

        -- Set opacity for cursorline and number background
        line_opacity = 0.15,

        -- Enable cursor highlights
        set_cursor = true,

        -- Enable cursorline initially, and disable cursorline for inactive windows
        -- or ignored filetypes
        set_cursorline = true,

        -- Enable line number highlights to match cursorline
        set_number = true,

        -- Enable sign column highlights to match cursorline
        set_signcolumn = true,

        -- Disable modes highlights in specified filetypes
        -- Please PR commonly ignored filetypes
        ignore_filetypes = { 'NvimTree', 'TelescopePrompt' },
      }
    end,
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_enable_last_session = false,
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        session_lens = { load_on_setup = false },
        auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },

        -- Save sessions based on the project directory
        session_dir = vim.fn.stdpath 'data' .. '/sessions/',
      }
    end,
  },
  {
    'onsails/lspkind.nvim',
    config = function()
      -- setup() is also available as an alias
      require('lspkind').init {
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol_text',

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = 'codicons',

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Text = '󰉿',
          Method = '󰆧',
          Function = '󰊕',
          Constructor = '',
          Field = '󰜢',
          Variable = '󰀫',
          Class = '󰠱',
          Interface = '',
          Module = '',
          Property = '󰜢',
          Unit = '󰑭',
          Value = '󰎠',
          Enum = '',
          Keyword = '󰌋',
          Snippet = '',
          Color = '󰏘',
          File = '󰈙',
          Reference = '󰈇',
          Folder = '󰉋',
          EnumMember = '',
          Constant = '󰏿',
          Struct = '󰙅',
          Event = '',
          Operator = '󰆕',
          TypeParameter = '',
        },
      }
    end,
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    enabled = false,
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  {
    'github/copilot.vim',
    event = 'InsertEnter',
  },
  {
    'copilotlsp-nvim/copilot-lsp',
    init = function()
      vim.g.copilot_nes_debounce = 25
      vim.lsp.enable 'copilot'
    end,
  },
  {
    'Exafunction/windsurf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'Chaitanyabsprip/fastaction.nvim',
    ---@type FastActionConfig
    opts = {
      dismiss_keys = { 'j', 'k', '<c-c>', 'q', '<esc>' },
    },
  },
  {
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup {
        animate = {
          enabled = false,
          timeout = 100,
          easing = 'linear',
        },
      }
    end,
  },
  {
    'kwkarlwang/bufresize.nvim',
  },
  {
    'tomasky/bookmarks.nvim',
    event = 'VimEnter',
    config = function()
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      local bookmarks_dir = vim.fn.stdpath 'data' .. '/bookmarks'
      vim.fn.mkdir(bookmarks_dir, 'p') -- Ensure the directory exists

      require('bookmarks').setup {
        save_file = bookmarks_dir .. '/' .. project_name .. '.json',
        keywords = {
          ['@t'] = '☑️ ',
          ['@w'] = '⚠️ ',
          ['@f'] = '⛏ ',
          ['@n'] = ' ',
        },
        on_attach = function(bufnr)
          local bm = require 'bookmarks'
          local map = vim.keymap.set
          map('n', 'mm', bm.bookmark_toggle)
          map('n', 'mi', bm.bookmark_ann)
          map('n', 'mc', bm.bookmark_clean)
          map('n', 'mn', bm.bookmark_next)
          map('n', 'mp', bm.bookmark_prev)
          map('n', 'ml', bm.bookmark_list)
          map('n', 'mx', bm.bookmark_clear_all)
        end,
      }
    end,
  },
  {
    'f-person/git-blame.nvim',
  },
  {
    'folke/drop.nvim',
    opts = {},
    enabled = false,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
