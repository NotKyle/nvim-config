-- run lualine after all plugins are loaded
function lualine()
  local function recording_component()
    local reg = vim.fn.reg_recording()
    if reg == '' then
      return ''
    end
    return '⏺ Recording (@' .. reg .. ')'
  end

  local function recording_color()
    if vim.fn.reg_recording() ~= '' then
      return { fg = '#ffffff', bg = '#ff5f5f', gui = 'bold' } -- white on red
    end
    return {} -- default
  end

  require('lualine').setup {
    sections = {
      lualine_c = {
        {
          recording_component,
          color = recording_color,
        },
        -- You can add more components here if you like
      },
      -- other sections (like lualine_x, lualine_y, etc)
    },
  }
end

lualine()
