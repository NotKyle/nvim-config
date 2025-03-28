return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = { 'ConformInfo' },
  config = function()
    require('conform').setup {
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        php = { 'php_cs_fixer' },
        html = { 'prettier' },
        css = { 'prettier' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        json = { 'prettier' },
        sh = { 'shfmt' },
      },
    }
  end,
}
