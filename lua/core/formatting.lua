local M = {}

-- Format on save
function M.setup()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
      -- Only try LSP formatting if the server supports it
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client.supports_method("textDocument/formatting") then
          vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
          return
        end
      end
    end,
  })
end

return M

