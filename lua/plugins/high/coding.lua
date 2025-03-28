-- lua/plugins/coding.lua
return {
  {
    'laytan/tailwind-sorter.nvim',
    config = function()
      require('tailwind-sorter').setup {
        on_save_enabled = false, -- If `true`, automatically enables on save sorting.
        on_save_pattern = { '*.html', '*.js', '*.jsx', '*.tsx', '*.twig', '*.hbs', '*.php', '*.heex', '*.astro' }, -- The file patterns to watch and sort.
        node_path = 'node',
        trim_spaces = false, -- If `true`, trim any extra spaces after sorting.
      }
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
    opts = {}, -- your configuration
  },
  {
    -- CMP
    'hrsh7th/nvim-cmp',
    dependencies = {
      'Jezda1337/nvim-html-css', -- add it as dependencies of `nvim-cmp` or standalone plugin
    },
    opts = {
      sources = {
        {
          name = 'html-css',
          option = {
            enable_on = { 'html', 'php' }, -- html is enabled by default
            notify = true,
            documentation = {
              auto_show = true, -- show documentation on select
            },
            -- add any external scss like one below
            style_sheets = {
              -- 'https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css',
            },
          },
        },
      },
    },
  }, ---@type LazySpec
  {
    -- Inline diagnostics
    'rachartier/tiny-inline-diagnostic.nvim',
    enabled = true,
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      -- Default configuration
      require('tiny-inline-diagnostic').setup {
        preset = 'modern', -- Can be: "modern", "classic", "minimal", "ghost", "simple", "nonerdfont", "amongus"
        hi = {
          error = 'DiagnosticError',
          warn = 'DiagnosticWarn',
          info = 'DiagnosticInfo',
          hint = 'DiagnosticHint',
          arrow = 'NonText',
          background = 'CursorLine', -- Can be a highlight or a hexadecimal color (#RRGGBB)
          mixing_color = 'None', -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
        },
        options = {
          -- Show the source of the diagnostic.
          show_source = false,

          -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
          -- You can increase it if you have performance issues.
          -- Or set it to 0 to have better visuals.
          throttle = 20,

          -- The minimum length of the message, otherwise it will be on a new line.
          softwrap = 30,

          -- If multiple diagnostics are under the cursor, display all of them.
          multiple_diag_under_cursor = false,

          -- Enable diagnostic message on all lines.
          multilines = false,

          -- Show all diagnostics on the cursor line.
          show_all_diags_on_cursorline = false,

          -- Enable diagnostics on Insert mode. You should also see the `throttle` option to 0, as some artifacts may appear.
          enable_on_insert = false,

          overflow = {
            -- Manage the overflow of the message.
            --    - wrap: when the message is too long, it is then displayed on multiple lines.
            --    - none: the message will not be truncated.
            --    - oneline: message will be displayed entirely on one line.
            mode = 'wrap',
          },

          -- Format the diagnostic message.
          -- Example:
          -- format = function(diagnostic)
          --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
          -- end,
          format = nil,

          --- Enable it if you want to always have message with `after` characters length.
          break_line = {
            enabled = false,
            after = 30,
          },

          virt_texts = {
            priority = 9999,
          },

          -- Filter by severity.
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },

          -- Overwrite events to attach to a buffer. You should not change it, but if the plugin
          -- does not works in your configuration, you may try to tweak it.
          overwrite_events = nil,
        },
      }
    end,
  },
  {
    'folke/noice.nvim',
    enabled = true,
    config = function()
      require('noice').setup {
        notify = {
          enabled = false,
        },
        error = {
          enabled = true,
          -- Error messages are formatted using the builtins for error. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = 'error',
          --- @type NoiceFormat|string
          format_done = 'error_done',
          view = 'mini',
          -- Limit maximum number of errors to show to 3
          limit = 3,
        },
        lsp = {
          progress = {
            enabled = false,
            -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
            -- See the section on formatting for more details on how to customize.
            --- @type NoiceFormat|string
            format = 'lsp_progress',
            --- @type NoiceFormat|string
            format_done = 'lsp_progress_done',
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = 'mini',
          },
        },
      }
    end,
  },
  -- {
  --   -- File grep
  --   'mikavilpas/yazi.nvim',
  --   event = 'VeryLazy',
  --   keys = {
  --     -- 👇 in this section, choose your own keymappings!
  --     {
  --       '<leader>e',
  --       '<cmd>Yazi<cr>',
  --       desc = 'Open yazi at the current file',
  --     },
  --     {
  --       -- Open in the current working directory
  --       '<leader>-',
  --       '<cmd>Yazi cwd<cr>',
  --       desc = "Open the file manager in nvim's working directory",
  --     },
  --     {
  --       -- NOTE: this requires a version of yazi that includes
  --       -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
  --       '<c-up>',
  --       '<cmd>Yazi toggle<cr>',
  --       desc = 'Resume the last yazi session',
  --     },
  --   },
  --   ---@type YaziConfig
  --   opts = {
  --     -- if you want to open yazi instead of netrw, see below for more info
  --     open_for_directories = false,
  --     keymaps = {
  --       show_help = '<f1>',
  --     },
  --   },
  -- },
  -- {
  --   -- Session manager
  --   'rmagatti/auto-session',
  --   lazy = false,
  --   ---enables autocomplete for opts
  --   ---@module "auto-session"
  --   ---@type AutoSession.Config
  --   opts = {
  --     suppressed_dirs = { '~/Downloads', '/' },
  --     -- log_level = 'debug',
  --     bypass_session_save_cmds = { 'tabnew', 'foldmethod' },
  --   },
  -- },
  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = 'Glow',
  },
  {
    'luckasRanarison/nvim-devdocs',
    cmd = { 'DevdocsFetch', 'DevdocsInstall', 'DevdocsUpdate', 'DevdocsUpdateAll', 'DevdocsUninstall', 'DevdocsOpen', 'DevdocsOpenFloat' },
    opts = {
      wrap = true,
      float_win = {
        relative = 'editor',
        height = 75,
        width = 170,
        border = 'rounded',
      },
      ensure_installed = {
        'php',
        'wordpress',
        'html',
        'jquery',
        'nginx',
        'http',
        'bash',
        'javascript',
        'go',
      },
      -- after_open = function()
      --   vim.cmd 'Glow'
      -- end,
    },
    previewer_cmd = 'glow',
    cmd_args = { '-s', 'dark', '-w', '80' },
    picker_cmd_args = { '-p' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    -- Auto close tags
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    lazy = true,
  },
  {
    -- Highlight matching pairs
    'andymass/vim-matchup',
    event = 'VeryLazy',
    config = function()
      vim.api.nvim_set_hl(0, 'OffScreenPopup', { fg = '#fe8019', bg = '#3c3836', italic = true })
      vim.g.matchup_matchparen_offscreen = {
        method = 'popup',
        highlight = 'OffScreenPopup',
      }
    end,
  },
  {
    -- Project management
    'Rics-Dev/project-explorer.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      paths = {
        '~/Desktop/Sites/',
        '~/.config/nvim',
      },
      file_explorer = function(dir)
        vim.cmd 'Telescope file_browser'
        vim.cmd('cd ' .. dir)
      end,
    },
    config = function(_, opts)
      require('project_explorer').setup(opts)
    end,

    keys = {
      { '<leader>pp', '<cmd>ProjectExplorer<CR>', desc = 'Open Project Explorer' },
    },
    event = 'VeryLazy',
    lazy = true,
  },
  {
    'coffebar/neovim-project',
    enabled = true,
    dependencies = {
      { 'Shatur/neovim-session-manager' },
    },
  },
  {
    -- Code actions
    'rachartier/tiny-code-action.nvim',
    enabled = true,
    event = 'LspAttach',
    config = function()
      require('tiny-code-action').setup()
    end,
  },

  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

  { 'numToStr/Comment.nvim', opts = {} },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup {
        indent = {
          char = '│',
        },
        scope = {
          enabled = false,
          char = '│',
          show_start = false,
          show_end = false,
          include = {
            node_type = { ['*'] = { '*' } },
          },
        },
      }
    end,
  },
  {
    'echasnovski/mini.hipatterns',
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    enabled = false,
    config = function()
      require('mini.indentscope').setup {
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        symbol = '│',
      }

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Disable indentscope for certain filetypes',
        pattern = {
          'NvimTree',
          'help',
          'Trouble',
          'trouble',
          'lazy',
          'notify',
          'better_term',
          'toggleterm',
          'lazyterm',
          'noice',
        },
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  -- Helper keymaps to move forward and backward using [key ]key
  {
    'echasnovski/mini.bracketed',
    version = false,
    opts = {},
    enabled = false,
  },
  {
    'tpope/vim-abolish',
    enabled = false,
    config = function()
      vim.g.abolish_case = 'smart'
    end,
  },
  {
    -- Inline diagnostics
    'rachartier/tiny-inline-diagnostic.nvim',
    enabled = false,
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      -- Default configuration
      require('tiny-inline-diagnostic').setup {
        preset = 'modern', -- Can be: "modern", "classic", "minimal", "ghost", "simple", "nonerdfont", "amongus"
        hi = {
          error = 'DiagnosticError',
          warn = 'DiagnosticWarn',
          info = 'DiagnosticInfo',
          hint = 'DiagnosticHint',
          arrow = 'NonText',
          background = 'CursorLine', -- Can be a highlight or a hexadecimal color (#RRGGBB)
          mixing_color = 'None', -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
        },
        options = {
          -- Show the source of the diagnostic.
          show_source = false,

          -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
          -- You can increase it if you have performance issues.
          -- Or set it to 0 to have better visuals.
          throttle = 20,

          -- The minimum length of the message, otherwise it will be on a new line.
          softwrap = 30,

          -- If multiple diagnostics are under the cursor, display all of them.
          multiple_diag_under_cursor = false,

          -- Enable diagnostic message on all lines.
          multilines = false,

          -- Show all diagnostics on the cursor line.
          show_all_diags_on_cursorline = false,

          -- Enable diagnostics on Insert mode. You should also see the `throttle` option to 0, as some artifacts may appear.
          enable_on_insert = false,

          overflow = {
            -- Manage the overflow of the message.
            --    - wrap: when the message is too long, it is then displayed on multiple lines.
            --    - none: the message will not be truncated.
            --    - oneline: message will be displayed entirely on one line.
            mode = 'wrap',
          },

          -- Format the diagnostic message.
          -- Example:
          -- format = function(diagnostic)
          --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
          -- end,
          format = nil,

          --- Enable it if you want to always have message with `after` characters length.
          break_line = {
            enabled = false,
            after = 30,
          },

          virt_texts = {
            priority = 9999,
          },

          -- Filter by severity.
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },

          -- Overwrite events to attach to a buffer. You should not change it, but if the plugin
          -- does not works in your configuration, you may try to tweak it.
          overwrite_events = nil,
        },
      }
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'wurli/contextindent.nvim',
    opts = { pattern = '*' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'OXY2DEV/patterns.nvim',
  },

  -- Task management
  {
    'atiladefreitas/dooing',
  },
  {
    'Hashino/doing.nvim',
    config = function()
      -- default options
      require('doing').setup {
        message_timeout = 2000,
        doing_prefix = 'Doing: ',

        -- doesn't display on buffers that match filetype/filename/filepath to
        -- entries. can be either a string array or a function that returns a
        -- string array. filepath can be relative to cwd or absolute
        ignored_buffers = { 'NvimTree' },

        -- if should append "+n more" to the status when there's tasks remaining
        show_remaining = true,

        -- if should show messages on the status string
        show_messages = true,

        -- window configs of the floating tasks editor
        -- see :h nvim_open_win() for available options
        edit_win_config = {
          width = 50,
          height = 15,
          border = 'rounded',
        },

        -- if plugin should manage the winbar
        winbar = { enabled = true },

        store = {
          -- name of tasks file
          file_name = '.tasks',
        },
      }
      -- example on how to change the winbar highlight
      vim.api.nvim_set_hl(0, 'WinBar', { link = 'Search' })

      local doing = require 'doing'

      vim.keymap.set('n', '<leader>da', doing.add, { desc = '[D]oing: [A]dd' })
      vim.keymap.set('n', '<leader>de', doing.edit, { desc = '[D]oing: [E]dit' })
      vim.keymap.set('n', '<leader>dn', doing.done, { desc = '[D]oing: Do[n]e' })
      vim.keymap.set('n', '<leader>dt', doing.toggle, { desc = '[D]oing: [T]oggle' })

      vim.keymap.set('n', '<leader>ds', function()
        vim.notify(doing.status(true), vim.log.levels.INFO, { title = 'Doing:', icon = '' })
      end, { desc = '[D]oing: [S]tatus' })
    end,
  },
  -- TS Context
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = true,
      max_lines = 3,
      trim_scope = 'outer',
    },
  },
  {
    'xzbdmw/clasp.nvim',
    config = function()
      require('clasp').setup {
        pairs = { ['{'] = '}', ['"'] = '"', ["'"] = "'", ['('] = ')', ['['] = ']', ['<'] = '>' },
        -- If called from insert mode, do not return to normal mode.
        keep_insert_mode = true,
      }

      -- jumping from smallest region to largest region
      vim.keymap.set({ 'n', 'i' }, '<c-l>', function()
        require('clasp').wrap 'next'
      end)

      -- jumping from largest region to smallest region
      vim.keymap.set({ 'n', 'i' }, '<c-l>', function()
        require('clasp').wrap 'prev'
      end)

      -- If you want to exclude nodes whose end row is not current row
      vim.keymap.set({ 'n', 'i' }, '<c-l>', function()
        require('clasp').wrap('next', function(nodes)
          local n = {}
          for _, node in ipairs(nodes) do
            if node.end_row == vim.api.nvim_win_get_cursor(0)[1] - 1 then
              table.insert(n, node)
            end
          end
          return n
        end)
      end)
    end,
  },

  {
    'nvim-tree/nvim-web-devicons',
    enabled = true,
  },

  {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  },

  -- {
  --   'gelguy/wilder.nvim',
  --   event = 'CmdlineEnter',
  --   build = ':UpdateRemotePlugins',
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     local wilder = require 'wilder'
  --     wilder.setup { modes = { ':', '/', '?' } }
  --     wilder.set_option('pipeline', {
  --       wilder.branch(
  --         wilder.python_file_finder_pipeline {
  --           file_command = function(_, arg)
  --             if string.find(arg, '.') ~= nil then
  --               return { 'fd', '-tf', '-H' }
  --             else
  --               return { 'fd', '-tf' }
  --             end
  --           end,
  --           dir_command = { 'fd', '-td' },
  --           filters = { 'fuzzy_filter', 'difflib_sorter' },
  --         },
  --         wilder.cmdline_pipeline(),
  --         wilder.python_search_pipeline()
  --       ),
  --     })
  --
  --     wilder.set_option(
  --       'renderer',
  --       wilder.popupmenu_renderer {
  --         highlighter = wilder.basic_highlighter(),
  --         left = { ' ', wilder.popupmenu_devicons() },
  --         right = { ' ', wilder.popupmenu_scrollbar { thumb_char = ' ' } },
  --         highlights = {
  --           default = 'WilderMenu',
  --           accent = wilder.make_hl('WilderAccent', 'Pmenu', {
  --             { a = 1 },
  --             { a = 1 },
  --             { foreground = '#f4468f' },
  --           }),
  --         },
  --       }
  --     )
  --   end,
  -- },

  -- TS textobjects
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
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
          move = {
            enable = true,
            set_jumps = true,
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
        },
      }
    end,
  },
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  {
    'folke/twilight.nvim',
  },
  {
    'folke/zen-mode.nvim',
  },
  ---@type LazySpec
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = { 'folke/snacks.nvim', lazy = true },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>e',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>w',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    'sindrets/diffview.nvim',
  },
  {
    'zeioth/garbage-day.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    config = function()
      require('diffview').setup {
        merge_tool = {
          layout = 'diff4_mixed',
        },
      }
    end,
  },
}
