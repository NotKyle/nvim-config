local use_formatting = false

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
      local prettier = {
        exe = 'prettier',
        args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0), '--write', '-' },
        stdin = true,
      }
      local util = require 'formatter.util'

      require('formatter').setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          lua = {
            require('formatter.filetypes.lua').stylua,
            function()
              if util.get_current_buffer_file_name() == 'special.lua' then
                return nil
              end
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

          javascript = { prettier },
          typescript = { prettier },
          html = { prettier },

          php = { prettier },

          blade = {
            function()
              return {
                exe = 'blade-formatter',
                args = { '--stdin' },
                stdin = true,
              }
            end,
          },

          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      }
    end,
  },
  {
    'MunifTanjim/prettier.nvim',
    config = function()
      require('prettier').setup {
        bin = 'prettier',
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
          'php',
        },
      }
    end,
  },
}
