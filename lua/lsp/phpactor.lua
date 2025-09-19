local enabled = false

local toReturn = {}

if enabled then
  toReturn = {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    -- root_dir = lspconfig.util.root_pattern('composer.json', '.git', '.phpactor.yml'),
    root_dir = vim.fn.getcwd(),
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
      language_server_phpstan = {
        enabled = false,
      },
    },
  }
end

return toReturn
