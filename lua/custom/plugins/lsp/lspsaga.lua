return {
  {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    config = function()
      require('lspsaga').setup {
        use_saga_diagnostic_sign = true,
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = '',
        border_style = 'round',
        code_action_icon = '💡',
        code_action_prompt = {
          enable = true,
          sign = true,
          sign_priority = 20,
          virtual_text = true,
        },
        finder_action_keys = {
          open = 'o',
          vsplit = 's',
          split = 'i',
          quit = 'q',
          scroll_down = '<C-f>',
          scroll_up = '<C-b>',
        },
        code_action_keys = {
          quit = 'q',
          exec = '<CR>',
        },
        rename_action_keys = {
          quit = '<C-c>',
          exec = '<CR>',
        },
      }
    end,
  },
}
