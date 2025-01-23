local M = {}

local variables = {
  ['--colors--secondary'] = '#3498db',
  ['--colors--primary'] = '#e74c3c',
  ['--gap'] = '#f1c40f',
}

function M.highlight_variables()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local ns_id = vim.api.nvim_create_namespace 'css_variable_highlight'

  for lnum, line in ipairs(lines) do
    for var, color in pairs(variables) do
      local pattern = 'var%(%s*(' .. var .. ')'
      local start, finish = line:find(pattern)
      if start and finish then
        vim.api.nvim_buf_add_highlight(bufnr, ns_id, 'CustomColor' .. var, lnum - 1, start - 1, finish)
        vim.cmd('highlight CustomColor' .. var .. ' guifg=' .. color)
      end
    end
  end
end

function M.setup()
  vim.cmd [[
    augroup HighlightCSSVariables
      autocmd!
      autocmd BufReadPost,TextChanged *.css,*.scss lua require('colors').highlight_variables()
    augroup END
  ]]
end

return M
