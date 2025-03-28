return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    local mini_modules = {
      'comment',
      'surround',
      'indentscope',
      'bufremove',
      'files',
      'pick',
      'move',
      'pairs',
    }

    for _, name in ipairs(mini_modules) do
      require('mini.' .. name).setup()
    end
  end,
}
