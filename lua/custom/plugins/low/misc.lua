-- lua/plugins/misc.lua
return {
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end,
  },
  {
    'Dan7h3x/LazyDo',
    branch = 'main',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'vds2212/vim-remotions',
    event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },

    config = function()
      local motions = {
        para = { backward = '{', forward = '}' },
        sentence = { backward = '(', forward = ')' },
        change = { backward = 'g,', forward = 'g;' },
        class = { backward = '[[', forward = ']]' },
        classend = { backward = '[]', forward = '][' },
        method = { backward = '[m', forward = ']m' },
        methodend = { backward = '[M', forward = ']M' },
        line = { backward = 'k', forward = 'j', repeat_count = 1 },
        char = { backward = 'h', forward = 'l', repeat_count = 1 },
        word = { backward = 'b', forward = 'w', repeat_count = 1 },
        fullword = { backward = 'B', forward = 'W', repeat_count = 1 },
        wordend = { backward = 'ge', forward = 'e', repeat_count = 1 },
        pos = { backward = '<C-i>', forward = '<C-o>' },
        page = { backward = '<C-u>', forward = '<C-d>' },
        pagefull = { backward = '<C-b>', forward = '<C-f>' },
        undo = { backward = 'u', forward = '<C-r>', direction = 1 },
        linescroll = { backward = '<C-e>', forward = '<C-y>' },
        charscroll = { backward = 'zh', forward = 'zl' },
        vsplit = { backward = '<C-w><', forward = '<C-w>>' },
        hsplit = { backward = '<C-w>-', forward = '<C-w>+' },
        arg = { backward = '[a', forward = ']a' },
        buffer = { backward = '[b', forward = ']b' },
        location = { backward = '[l', forward = ']l' },
        quickfix = { backward = '[q', forward = ']q' },
        tag = { backward = '[t', forward = ']t' },
        diagnostic = { backward = '[g', forward = ']g' },
      }

      vim.g.remotions_motions = motions
    end,
  },
}
