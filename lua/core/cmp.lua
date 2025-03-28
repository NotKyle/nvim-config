local ok, blink = pcall(require, 'blink.cmp')
if not ok then
  vim.notify('blink.cmp not found!', vim.log.levels.ERROR)
  return
end

blink.setup {
  completion = {
    list = {
      selection = {
        preselect = false, -- ✅ Don't preselect the first item
      },
    },
  },
  keymap = {
    preset = 'default',

    -- ✅ Confirm + fallback (smart Enter)
    ['<CR>'] = { 'accept', 'fallback' },

    -- Completion menu toggling
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },

    -- Navigation
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    -- Docs and signature
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
}
