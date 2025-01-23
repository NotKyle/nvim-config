-- Add your custom plugin directory to runtimepath
local custom_plugin_dir = vim.fn.expand '~/Projects/Neovim'

if vim.fn.isdirectory(custom_plugin_dir) == 1 then
  vim.opt.runtimepath:append(custom_plugin_dir)
end

return {}
