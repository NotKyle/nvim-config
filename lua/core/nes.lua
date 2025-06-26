local M = {}
local ns = vim.api.nvim_create_namespace 'copilot-nes'

-- Show virtual text hint if NES is available
function M.show_hint(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  if vim.b[bufnr].nes_state then
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
      virt_text = { { '💡 NES available', 'Comment' } },
      virt_text_pos = 'eol',
      hl_mode = 'combine',
    })
  end
end

-- Autocmd to update the NES indicator
function M.setup_autocmd()
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorMoved', 'InsertLeave' }, {
    group = vim.api.nvim_create_augroup('CopilotNES', { clear = true }),
    callback = function()
      M.show_hint()
    end,
  })
end

function M.setup()
  if vim.g.copilot_nes_enabled then
    M.setup_autocmd()
  end
end

return M
