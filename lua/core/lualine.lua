require('lualine').setup {
  sections = {
    lualine_c = {
      'filename',
      {
        function()
          local clients = vim.lsp.get_active_clients { bufnr = 0 }
          if #clients == 0 then
            return 'No LSP'
          end
          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end
          return 'LSP: ' .. table.concat(names, ', ')
        end,
        color = { fg = '#a6e3a1' },
      },
    },
  },
}
