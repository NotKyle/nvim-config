return {
  'fnune/standard',
  lazy = false,
  priority = 1000,
  config = function()
    require('standard').setup {}
    vim.cmd 'colorscheme standard'
  end,
}
