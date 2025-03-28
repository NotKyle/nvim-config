-- run lualine after all plugins are loaded
function lualine()
  require('lualine').setup {
    options = {
      theme = 'auto',
    },
    sections = {
      lualine_x = {
        function()
          local ok, doing = pcall(require, 'doing')
          if not ok then
            -- print '[doing module not found]' -- Debug output
            return '[doing module not found]'
          end

          local doing_status = type(doing.status) == 'function' and doing.status() or doing.status
          -- print('doing.status:', doing_status) -- Debug output

          if not doing_status or doing_status == '' then
            return '[No Status]'
          end

          -- Replace Doing:
          doing_status = doing_status:gsub('Doing: ', '')

          return '[' .. doing_status .. ']'
        end,
      },
    },
  }
end

lualine()
