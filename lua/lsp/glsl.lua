-- in your LSP config (e.g. inside LazyVim's lspconfig setup)
local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'

lspconfig.glsl_analyzer.setup {
  cmd = { 'glsl_analyzer' },
  filetypes = { 'glsl', 'vert', 'frag' },
  root_dir = util.root_pattern('.git', '.'),
}
