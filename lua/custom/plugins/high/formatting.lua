local use_formatting = true

if not use_formatting then
  return {}
end

return {
  {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'mhartington/formatter.nvim',
    config = function()
      -- Utilities for creating configurations
      local prettier = { exe = 'prettier', args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) }, stdin = true }
      local util = require 'formatter.util'

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require('formatter').setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require('formatter.filetypes.lua').stylua,

            -- You can also define your own configuration
            function()
              -- Supports conditional formatting
              if util.get_current_buffer_file_name() == 'special.lua' then
                return nil
              end

              -- Full specification of configurations is down below and in Vim help
              -- files
              return {
                exe = 'stylua',
                args = {
                  '--search-parent-directories',
                  '--stdin-filepath',
                  util.escape_path(util.get_current_buffer_file_path()),
                  '--',
                  '-',
                },
                stdin = true,
              }
            end,
          },

          -- Format javascript
          javascript = {
            prettier,
          },

          -- Format typescript
          typescript = {
            prettier,
          },

          -- Format php
          php = {
            function()
              -- Path to the root directory (you can adjust this if needed)
              local root_dir = vim.fn.getcwd()
              local config_file = root_dir .. '/.php-cs-fixer.dist.php'

              -- Check if the configuration file exists
              if vim.fn.filereadable(config_file) == 1 then
                return {
                  exe = 'php-cs-fixer',
                  args = {
                    'fix',
                    '--using-cache=no',
                    '--config=' .. config_file,
                    vim.api.nvim_buf_get_name(0),
                  },
                  stdin = false,
                }
              else
                return {
                  exe = 'php-cs-fixer',
                  args = {
                    'fix',
                    '--using-cache=no',
                    '--rules=@PSR12',
                    vim.api.nvim_buf_get_name(0),
                  },
                  stdin = false,
                }
              end
            end,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ['*'] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
        -- vim.api.nvim_command("autocmd BufWritePre * FormatWrite"),
      }
    end,
  },
  {
    'MunifTanjim/prettier.nvim',
    config = function()
      local prettier = require 'prettier'

      prettier.setup {
        bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
        filetypes = {
          'css',
          'graphql',
          'html',
          'javascript',
          'javascriptreact',
          'json',
          'less',
          'markdown',
          'scss',
          'typescript',
          'typescriptreact',
          'yaml',
          -- "php",
        },
      }
    end,
  },
}
