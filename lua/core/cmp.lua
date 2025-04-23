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
      function(cmp, fallback)
        -- Protect everything in a pcall
        local ok = pcall(function()
          local nes = vim.b[vim.api.nvim_get_current_buf()].nes_state

          if nes then
            cmp.hide()
            require('copilot-lsp.nes').apply_pending_nes()
            return
          end

          if cmp.snippet_active and cmp.snippet_active() then
            cmp.accept()
            return
          end

          if cmp.menu_visible then
            cmp.select_and_accept()
            return
          end

          -- Use fallback if provided
          if fallback then
            fallback()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
          end
        end)

        if not ok then
          -- Gracefully fallback to a Tab keystroke if something fails
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
        end
      end,
      'snippet_forward',
      'fallback',
    },
  },
}

-- Register optional sources if using
-- require('blink.sources.lsp').register()
-- require('blink.sources.snippet').register()
