local ok, blink = pcall(require, 'blink.cmp')
if not ok then
  vim.notify('blink.cmp not found!', vim.log.levels.ERROR)
  return
end

blink.setup {
  completion = {
    list = {
      selection = {
        preselect = false,
      },
    },
  },
  keymap = {
    preset = 'default',

    -- Smart <CR>
    ['<CR>'] = { 'accept', 'fallback' },

    -- Completion menu toggling
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },

    -- Navigation
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    -- Docs and signature
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

    -- Tab with Copilot NES integration
    ['<Tab>'] = {
      function(cmp)
        local nes = vim.b[vim.api.nvim_get_current_buf()].nes_state
        if nes then
          cmp.hide()
          return require('copilot-lsp.nes').apply_pending_nes()
        end

        if cmp.snippet_active() then
          return cmp.accept()
        end

        if cmp.visible() then
          return cmp.select_and_accept()
        end

        return cmp.fallback()
      end,
      'snippet_forward',
      'fallback',
    },
  },
}

-- Register optional sources if using
-- require('blink.sources.lsp').register()
-- require('blink.sources.snippet').register()
